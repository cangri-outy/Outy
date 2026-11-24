/* PHEV protocol engine (port of buxtronix/phev2mqtt protocol + client, GPL-3.0).
 * Pure logic: no DOM, no sockets. Works in the WebView and in Node (tests). */
(function (root, factory) {
  if (typeof module === "object" && module.exports) module.exports = factory();
  else root.PhevEngine = factory();
})(typeof self !== "undefined" ? self : this, function () {
  "use strict";

  var T = { PING_REQ: 0xf3, PING_RESP: 0x3f, SEND: 0xf6, RESP: 0x6f,
    START24: 0x6e, START24_RESP: 0xe6, START18: 0x5e, START18_RESP: 0xe5,
    START14: 0x4e, START14_RESP: 0xe4, BAD_XOR: 0xbb, CC: 0xcc, START_RESP: 0x2f };
  var R = { BATT_WARN: 0x02, PREAC: 0x10, TIME: 0x12, ACK_PREAC_TERM: 0x13, VIN: 0x15,
    SETTINGS: 0x16, AC_OPER: 0x1a, SET_AC_MY18: 0x1b, AC_MODE: 0x1c, BATT: 0x1d,
    PLUG: 0x1e, CHARGE: 0x1f, CLIMATE_TIMERS: 0x05, SET_AC_MODE_MY14: 0x02, SET_AC_EN_MY14: 0x04,
    REGISTER: 0x10, UNREGISTER: 0x15, DOORS: 0x24, LIGHTS: 0x23, HEADLIGHTS_W: 0x0a, PARKING_W: 0x0b, CANCEL_CHARGE_TIMER: 0x17 };

  function hex(a) { var s = ""; for (var i = 0; i < a.length; i++) s += (a[i] < 16 ? "0" : "") + a[i].toString(16); return s; }
  function unhex(s) { var o = []; for (var i = 0; i + 1 < s.length; i += 2) o.push(parseInt(s.substr(i, 2), 16)); return o; }

  /* ---- security key / key map (raw.go) ---- */
  function SecurityKey() { this.keyMap = []; this.securityKey = 0; this.sNum = 0; this.rNum = 0; }
  SecurityKey.prototype.update = function (p, ack) {
    // Only an unacknowledged init frame (ack=0) (re-)establishes key state; a replayed/acked
    // init frame must not reset an already-running session (SIDMonitor issue #16).
    if (ack) return;
    // Known reference init format is exactly 14 bytes with declared length 0x0C (12): reject
    // anything else rather than deriving a key from an unexpected frame shape (SIDMonitor).
    if (p.length !== 14 || p[1] !== 0x0c) { this.keyMap = []; this.securityKey = 0; this.sNum = 0; this.rNum = 0; return; }
    var r = (p[4] & 8) >> 3;
    r |= (p[5] & 8) >> 2; r |= (p[6] & 8) >> 1; r |= (p[7] & 8);
    r |= (p[8] & 8) << 1; r |= (p[9] & 8) << 2; r |= (p[10] & 8) << 3; r |= (p[11] & 8) << 4;
    this.securityKey = r & 0xff;
    var km = new Array(256), i;
    for (i = 0; i < 256; i++) km[i] = i;
    var index = 0;
    for (i = 0; i < 256; i++) {
      index += km[i]; index += this.securityKey; index %= 256;
      var t = km[i]; km[i] = km[index]; km[index] = t;
    }
    this.keyMap = km; this.sNum = 0; this.rNum = 0;
  };
  SecurityKey.prototype.rKey = function (inc) {
    if (!this.keyMap.length) return 0;
    var r = this.rNum; if (inc) this.rNum = (this.rNum + 1) & 0xff; return this.keyMap[r];
  };
  SecurityKey.prototype.sKey = function (inc) {
    if (!this.keyMap.length) return 0;
    var r = this.sNum; if (inc) this.sNum = (this.sNum + 1) & 0xff; return this.keyMap[r];
  };

  function xorWith(a, x) { var o = new Array(a.length); for (var i = 0; i < a.length; i++) o[i] = (a[i] ^ x) & 0xff; return o; }
  function checksum(m) { var len = ((m[1] + 2) & 0xff), b = 0; for (var i = 0; i < len - 1; i++) b = (b + m[i]) & 0xff; return b; }
  function validateChecksum(m) {
    var len = m[1] + 2; if (m.length < len) return false; return checksum(m) === m[len - 1];
  }
  /* -> {msg, xor, rem} or null */
  /* Tries to decode one frame at the start of m. Returns:
   *  {status:"complete", msg, xor}  - a full, checksum-valid frame
   *  {status:"incomplete"}          - not enough bytes yet for a plausible frame; wait for more
   *  {status:"invalid"}             - garbage at this position; caller should resync by 1 byte */
  function tryDecodeOne(m) {
    if (m.length < 4) return { status: "incomplete" };
    var candidates = [m[2], m[2] ^ 1], i, sawInsufficient = false;
    for (i = 0; i < candidates.length; i++) {
      var xor = candidates[i], len = (m[1] ^ xor) + 2;
      if (len < 3 || len > 253) continue;              // implausible declared length for this xor guess (matches SIDMonitor's verified bound)
      if (m.length < len) { sawInsufficient = true; continue; }  // this guess needs more bytes than we have; try the other guess first
      var msg = xorWith(m.slice(0, len), xor);
      if (checksum(msg) === msg[len - 1]) return { status: "complete", msg: msg, xor: xor };
    }
    // Neither candidate validated with the bytes on hand. If at least one candidate's declared
    // length simply exceeds what we have (rather than failing checksum outright), the right
    // answer may be waiting on the wire - wait for more data instead of resyncing past it.
    return { status: sawInsufficient ? "incomplete" : "invalid" };
  }
  /* kept for external callers/tests: decodes a single complete frame from a buffer with no partial-frame semantics */
  function validateAndDecode(m) {
    var r = tryDecodeOne(m);
    if (r.status !== "complete") return null;
    return { msg: r.msg, xor: r.xor, rem: m.length > r.msg.length ? m.slice(r.msg.length) : [] };
  }

  function encode(msg, key) {
    var d = [msg.type, (msg.data.length + 3) & 0xff, msg.ack || 0, msg.register].concat(msg.data);
    d.push(checksum(d));
    var x = 0;
    switch (msg.type) {
      case T.START24: case T.START24_RESP: case T.START18: case T.START18_RESP: case T.START14: case T.START14_RESP: break;
      case T.SEND: x = key.sKey(true); break;
      default: x = key.sKey(false);
    }
    msg.xor = x;
    return xorWith(d, x);
  }

  /* decode a decoded (de-XORed) frame, updating the key as upstream DecodeFromBytes does.
   * `raw` is the frame as received (needed to derive the key from start packets). */
  function decodeFrame(dec, xor, raw, key) {
    var m = { type: dec[0], length: dec[1] + 2, ack: dec[2], register: dec[3], data: dec.slice(4, dec[1] + 1), xor: xor, original: dec, raw: raw };
    if (m.type === T.START24 || m.type === T.START18 || m.type === T.START14) key.update(raw, m.ack);
    else if (m.type === T.RESP) key.rKey(true);
    return m;
  }

  /* Splits a byte stream into complete messages. Returns {msgs, rest}: rest is any trailing bytes
   * that don\'t yet form a complete frame (e.g. a frame split across two TCP reads) and must be
   * prepended to the next call\'s data - callers should not discard it (ported from SIDMonitor\'s
   * PhevStreamDecoder, which buffers across reads instead of dropping a split frame). */
  function parseStream(data, key) {
    var msgs = [], off = 0;
    while (off < data.length) {
      var r = tryDecodeOne(data.slice(off));
      if (r.status === "incomplete") break;             // wait for more bytes; keep data[off:] as rest
      if (r.status === "invalid") { off += 1; continue; }  // resync
      var raw = data.slice(off, off + r.msg.length);
      msgs.push(decodeFrame(r.msg, r.xor, raw, key));
      off += r.msg.length;
    }
    return { msgs: msgs, rest: data.slice(off) };
  }

  /* ---- register decoders ---- */
  function decodeTimer(b0, b1, b2) {
    var v = b0 | (b1 << 8) | (b2 << 16);           // README: stored big-endian, read as little
    var days = [];
    ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"].forEach(function (n, i) { if (v & (1 << (2 + i))) days.push(n); });
    return { on: !!(v & (1 << 17)), hour: (v >> 12) & 31, minute: ((v >> 9) & 7) * 10,
      durationMin: [10, 20, 30, 40][v & 3], days: days, raw: hex([b0, b1, b2]) };
  }
  function decodeClimateTimers(d) {
    if (d.length < 16) return null;
    var out = [];
    for (var i = 0; i < 5; i++) out.push(decodeTimer(d[1 + 3 * i], d[2 + 3 * i], d[3 + 3 * i]));
    return out;
  }

  function Engine(opts) {
    this.opts = opts || {};
    this.send = this.opts.send || function () {};
    this.now = this.opts.now || function () { return Date.now(); };
    this.key = new SecurityKey();
    this.state = { started: false, modelYear: 0, soc: null, charging: null, chargeRemainingMin: null,
      plugged: null, preAC: null, acMode: null, acDuration: null, acOperating: null, timers: null, vin: null,
      carTime: null, registers: {},
      locked: null, headlights: null, parkingLights: null, hazard: null, interior: null,
      doorDriver: null, doorPassenger: null, doorRearLeft: null, doorRearRight: null, boot: null, bonnet: null };
    this.lastRx = 0; this.pingSeq = 0x0a; this.pending = []; this.listeners = [];
    this.badXor = 0; this.pendingAck = null;
  }
  Engine.prototype.on = function (fn) { this.listeners.push(fn); };
  Engine.prototype._emit = function (ev, data) { for (var i = 0; i < this.listeners.length; i++) this.listeners[i](ev, data); };
  Engine.prototype._tx = function (msg) { var b = encode(msg, this.key); this.send(b); return b; };

  /* call every ~200 ms while connected (upstream pinger) */
  Engine.prototype.tick = function () {
    var t = this.now();
    if (t - this.lastRx < 500) return;
    this._tx({ type: T.PING_REQ, ack: 0, register: this.pingSeq, data: [0] });
    this.pingSeq++; if (this.pingSeq > 0x63) this.pingSeq = 0;
    var self = this;
    this.pending = this.pending.filter(function (p) {
      if (t - p.t0 > 10000) { p.cb(new Error("timed out setting register 0x" + p.register.toString(16))); return false; }
      return true;
    });
  };

  var MAX_RX_BUFFER = 8192;   // sanity cap so an unsyncable stream cannot grow this buffer forever (SIDMonitor)
  /* feed raw bytes (array of ints) received from the car. Buffers any incomplete trailing frame
   * across calls instead of discarding it. */
  Engine.prototype.feed = function (bytes) {
    this.lastRx = this.now();
    var buf = (this.rxBuffer || []).concat(bytes);
    if (buf.length > MAX_RX_BUFFER) { buf = []; this._emit("error", "rx buffer overflow, resyncing"); }
    var res = parseStream(buf, this.key), self = this;
    this.rxBuffer = res.rest;
    res.msgs.forEach(function (m) { self._handle(m); });
  };

  Engine.prototype._handle = function (m) {
    var st = this.state, self = this;
    switch (m.type) {
      case T.START_RESP:
        this._tx({ type: T.PING_REQ, ack: 0, register: 0x0a, data: [0] }); break;
      case T.START24: case T.START18: case T.START14: {
        var my = m.type === T.START24 ? 24 : m.type === T.START18 ? 18 : 14;
        st.modelYear = my;
        this._tx({ type: my === 24 ? T.START24_RESP : my === 18 ? T.START18_RESP : T.START14_RESP, ack: 1, register: 1, data: [0] });
        st.started = true; this._emit("started", my); break;
      }
      case T.BAD_XOR:
        this.badXor++;
        this.pending.forEach(function (p) { self._sendPending(p); });  // upstream: resend
        break;
      case T.RESP:
        if (m.ack === 0) {
          this._register(m);
          this._tx({ type: T.SEND, ack: 1, register: m.register, data: [0] });
        } else {
          for (var i = 0; i < this.pending.length; i++) {
            if (this.pending[i].register === m.register) { var p = this.pending.splice(i, 1)[0]; p.cb(null); break; }
          }
        }
        break;
    }
    this._emit("msg", m);
  };

  Engine.prototype._register = function (m) {
    var st = this.state, d = m.data;
    st.registers[m.register] = hex(d);
    switch (m.register) {
      case R.BATT: if (d.length >= 1) { st.soc = d[0]; if (d.length >= 3) st.parkingLights = d[2] === 1; } break;
      case R.CHARGE: if (d.length === 3) { st.charging = d[0] === 1; st.chargeRemainingMin = d[2] !== 0xff ? ((d[2] << 8) | d[1]) : 0; } break;
      case R.PLUG: if (d.length === 2) st.plugged = (d[1] === 1 || d[0] > 0); break;
      case R.PREAC: if (d.length >= 1) st.preAC = d[0] === 0 ? "off" : d[0] === 2 ? "on" : d[0] === 3 ? "terminated" : "unknown(" + d[0] + ")"; break;
      case R.AC_OPER: if (d.length >= 2) st.acOperating = d[1] === 1; break;
      case R.AC_MODE: if (d.length === 1) {
        st.acMode = ["unknown", "cool", "heat", "windscreen"][d[0] & 0x0f] || "unknown";
        st.acDuration = ({ 0x00: 10, 0x10: 20, 0x20: 30 })[d[0] & 0xf0] || null; } break;
      case R.CLIMATE_TIMERS: st.timers = decodeClimateTimers(d); break;
      case R.TIME: if (d.length === 7) st.carTime = { y: 2000 + d[0], mo: d[1], d: d[2], h: d[3], mi: d[4], s: d[5] }; break;
      case R.VIN: if (d.length >= 20) { var s = ""; for (var i = 1; i < 18; i++) s += String.fromCharCode(d[i]); st.vin = s; } break;
      // Door/Lock status (upstream README #0x24): byte0 lock(1=locked,2=unlocked), 3..8 doors/boot/bonnet, 9 headlights
      case R.DOORS: if (d.length >= 10) {
        st.locked = d[0] === 1;
        st.doorDriver = d[3] === 1; st.doorPassenger = d[4] === 1;
        st.doorRearRight = d[5] === 1; st.doorRearLeft = d[6] === 1;
        st.boot = d[7] === 1; st.bonnet = d[8] === 1; st.headlights = d[9] === 1;
      } break;
      // Interior/Hazard lights (upstream README #0x23 worked examples): byte3=hazard(1=on), byte4=interior(1=on)
      case R.LIGHTS: if (d.length >= 5) { st.hazard = d[3] === 1; st.interior = d[4] === 1; } break;
    }
    this._emit("state", st);
  };

  Engine.prototype._sendPending = function (p) {
    this._tx({ type: T.SEND, ack: 0, register: p.register, data: p.data });
  };
  /* set a register; cb(err) on ack or timeout (10 s, checked by tick()) */
  Engine.prototype.setRegister = function (register, data, cb) {
    var p = { register: register, data: data, cb: cb || function () {}, t0: this.now() };
    this.pending.push(p); this._sendPending(p);
  };

  /* climate command, exactly as upstream cmd/mqtt.go. mode: off|cool|heat|windscreen; minutes 10|20|30 */
  Engine.prototype.setClimate = function (mode, minutes, cb) {
    var modes = { off: 0, cool: 1, heat: 2, windscreen: 3 }, durs = { 10: 0, 20: 1, 30: 2 };
    if (!(mode in modes)) return cb && cb(new Error("bad mode"));
    var m = modes[mode], d = durs[minutes];
    if (m !== 0 && d === undefined) return cb && cb(new Error("minutes must be 10, 20 or 30"));
    d = d || 0;
    var my = this.state.modelYear, self = this;
    if (my === 14) {
      var payload = []; for (var i = 0; i < 15; i++) payload.push(0xff);
      payload[0] = 0; payload[1] = 0; payload[6] = m | d;
      this.setRegister(R.SET_AC_MODE_MY14, payload, function (e) {
        if (e) return cb && cb(e);
        self.setRegister(R.SET_AC_EN_MY14, [m === 0 ? 1 : 2], cb);
      });
    } else if (my === 18 || my === 24) {
      this.setRegister(R.SET_AC_MY18, [m === 0 ? 1 : 2, m, d, 0], cb);
    } else cb && cb(new Error("car not started yet"));
  };
  Engine.prototype.resetPreAC = function (cb) { this.setRegister(R.ACK_PREAC_TERM, [1], cb); };
  /* Headlights / parking lights (upstream README "Write registers": 0xa, 0xb; 0x1=on, 0x2=off) */
  Engine.prototype.setHeadlights = function (on, cb) { this.setRegister(R.HEADLIGHTS_W, [on ? 1 : 2], cb); };
  Engine.prototype.setParkingLights = function (on, cb) { this.setRegister(R.PARKING_W, [on ? 1 : 2], cb); };
  /* Cancel charge timer (upstream README + reference client: register 0x17, sent as 0x1 then 0x11) */
  Engine.prototype.cancelChargeTimer = function (cb) {
    var self = this;
    this.setRegister(R.CANCEL_CHARGE_TIMER, [0x01], function (e) {
      if (e) return cb && cb(e);
      self.setRegister(R.CANCEL_CHARGE_TIMER, [0x11], cb);
    });
  };
  /* Pair this phone. Matches upstream cmd/register.go exactly: while the car is in its
   * registration window (the single-beep state after the lock/unlock sequence) it broadcasts
   * its VIN unsolicited; only once that VIN notification has been seen do we write register
   * 0x10=1. Writing immediately, without waiting for that VIN, is a likely source of silent
   * registration failures if the car's handshake wasn't actually ready yet. Upstream also notes
   * the registration window lasts about 5 minutes after the beep. */
  Engine.prototype.registerClient = function (cb, timeoutMs) {
    var self = this, done = false;
    function finish(err) { if (done) return; done = true; self.listeners.splice(self.listeners.indexOf(onMsg), 1); clearTimeout(t); cb && cb(err); }
    function onMsg(ev, m) {
      if (ev === 'msg' && m.type === T.RESP && m.ack === 0 && m.register === R.VIN) {
        finish2();
      }
    }
    function finish2() { self.listeners.splice(self.listeners.indexOf(onMsg), 1); clearTimeout(t); self.setRegister(R.REGISTER, [1], cb); }
    if (!this.state.started) return cb && cb(new Error('not connected'));
    if (this.state.vin) { this.setRegister(R.REGISTER, [1], cb); return; }  // already seen a VIN broadcast this session
    this.on(onMsg);
    var t = setTimeout(function () { finish(new Error('car did not announce its VIN: it may no longer be in registration mode (the window lasts about 5 minutes after the beep) - try the lock/unlock sequence again')); }, timeoutMs || 15000);
  };
  Engine.prototype.refresh = function (cb) { this.setRegister(0x06, [0x03], cb); };   // upstream "update" poke

  /* ---- calendar-driven preheat planning (pure) ---- */
  /* events: [{title,begin,end,allDay,location}] epoch ms.  cfg: {minutes, departBeforeMin, keyword, requireLocation, horizonH}
   * Returns {event, startAt, minutes} or null.  Preheat is timed to END when you leave:
   * startAt = eventBegin - departBeforeMin - minutes. */
  function planPreheat(events, cfg, now) {
    var best = null, mins = cfg.minutes || 20, dep = cfg.departBeforeMin == null ? 15 : cfg.departBeforeMin;
    var horizon = now + (cfg.horizonH || 24) * 3600000, kw = (cfg.keyword || "").toLowerCase();
    (events || []).forEach(function (e) {
      if (e.allDay) return;
      if (kw && (e.title || "").toLowerCase().indexOf(kw) < 0) return;
      if (cfg.requireLocation && !(e.location && e.location.trim())) return;
      var startAt = e.begin - (dep + mins) * 60000;
      if (startAt <= now || e.begin > horizon) return;
      if (!best || startAt < best.startAt) best = { event: e, startAt: startAt, minutes: mins };
    });
    return best;
  }

  return { Engine: Engine, SecurityKey: SecurityKey, encode: encode, parseStream: parseStream,
    validateAndDecode: validateAndDecode, validateChecksum: validateChecksum, checksum: checksum,
    xorWith: xorWith, decodeTimer: decodeTimer, decodeClimateTimers: decodeClimateTimers,
    planPreheat: planPreheat, hex: hex, unhex: unhex, T: T, R: R };
});
