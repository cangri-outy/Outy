"use strict";
// Run: node --test tests/
const test = require("node:test");
const assert = require("node:assert");
const E = require("../app/assets/phev-engine.js");

function initFrame(bits) {                       // 14-byte start frame, declared length 0x0C
  const p = new Array(14).fill(0);
  p[0] = E.T.START24; p[1] = 0x0c; p[2] = 0; p[3] = 0;
  for (let i = 0; i < 8; i++) p[4 + i] = bits[i] ? 8 : 0;
  return p;
}
function keyed() {
  const k = new E.SecurityKey();
  k.update(initFrame([1, 0, 1, 1, 0, 0, 1, 0]), 0);
  return k;
}

test("checksum: validate accepts a good frame and rejects a corrupted one", () => {
  const body = [E.T.PING_REQ, 3 + 1, 0, 0x0a, 0x00];
  const frame = body.concat([E.checksum(body.concat([0]))]);
  assert.ok(E.validateChecksum(frame));
  frame[4] ^= 0x01;
  assert.ok(!E.validateChecksum(frame));
});

test("security key: map is a permutation, deterministic and derived from the init frame", () => {
  const a = keyed(), b = keyed();
  assert.strictEqual(a.keyMap.length, 256);
  assert.deepStrictEqual([...a.keyMap].sort((x, y) => x - y), [...Array(256).keys()]);
  assert.deepStrictEqual(a.keyMap, b.keyMap);
  const c = new E.SecurityKey(); c.update(initFrame([0, 0, 0, 0, 0, 0, 0, 0]), 0);
  assert.notDeepStrictEqual(a.keyMap, c.keyMap);
  assert.strictEqual(a.securityKey, 0b01001101);   // bit i of the key = bit 3 of init byte 4+i
});

test("security key: acknowledged or malformed init frames never reset a running session", () => {
  const k = keyed(); const map = k.keyMap.slice();
  k.update(initFrame([0, 0, 0, 0, 1, 1, 1, 1]), 1);           // acked replay: ignored
  assert.deepStrictEqual(k.keyMap, map);
  k.update(new Array(13).fill(0), 0);                          // wrong length: cleared, not derived
  assert.strictEqual(k.keyMap.length, 0);
  assert.strictEqual(k.sKey(true), 0);
});

test("security key: counters advance and wrap at 256", () => {
  const k = keyed();
  const first = k.sKey(false);
  assert.strictEqual(k.sKey(false), first);                    // peek does not advance
  for (let i = 0; i < 256; i++) k.sKey(true);
  assert.strictEqual(k.sNum, 0);
  assert.strictEqual(k.sKey(false), first);
});

test("encode then parseStream round-trips type, register and data", () => {
  const tx = keyed(), rx = keyed();
  const wire = E.encode({ type: E.T.SEND, ack: 0, register: E.R.AC_MODE, data: [1, 2, 3] }, tx);
  const out = E.parseStream(wire, rx);
  assert.strictEqual(out.msgs.length, 1);
  assert.strictEqual(out.msgs[0].type, E.T.SEND);
  assert.strictEqual(out.msgs[0].register, E.R.AC_MODE);
  assert.deepStrictEqual(out.msgs[0].data, [1, 2, 3]);
  assert.strictEqual(out.rest.length, 0);
});

test("fragmented TCP frames: partial data is kept and completed by the next read", () => {
  const tx = keyed(), rx = keyed();
  const wire = E.encode({ type: E.T.SEND, ack: 0, register: 0x10, data: [9, 8, 7, 6] }, tx);
  const cut = 4;
  const first = E.parseStream(wire.slice(0, cut), rx);
  assert.strictEqual(first.msgs.length, 0);
  assert.deepStrictEqual(first.rest, wire.slice(0, cut));
  const second = E.parseStream(first.rest.concat(wire.slice(cut)), rx);
  assert.strictEqual(second.msgs.length, 1);
  assert.deepStrictEqual(second.msgs[0].data, [9, 8, 7, 6]);
});

test("two frames in one read are both returned, in order", () => {
  const tx = keyed(), rx = keyed();
  const a = E.encode({ type: E.T.SEND, ack: 0, register: 0x10, data: [1] }, tx);
  const b = E.encode({ type: E.T.SEND, ack: 0, register: 0x11, data: [2] }, tx);
  const out = E.parseStream(a.concat(b), rx);
  assert.deepStrictEqual(out.msgs.map(m => m.register), [0x10, 0x11]);
});

test("corrupted frame is rejected, not delivered", () => {
  const tx = keyed(), rx = keyed();
  const wire = E.encode({ type: E.T.SEND, ack: 0, register: 0x10, data: [5, 5] }, tx);
  wire[wire.length - 1] ^= 0xff;
  const out = E.parseStream(wire, rx);
  assert.ok(!out.msgs.some(m => m.register === 0x10 && m.data[0] === 5 && m.data[1] === 5));
});

test("climate timer decoding", () => {
  const v = (1 << 17) | (7 << 12) | (3 << 9) | (1 << 3) | 1;   // on, 07:30, Mon, 20 min
  const t = E.decodeTimer(v & 255, (v >> 8) & 255, v >> 16);
  assert.strictEqual(t.on, true);
  assert.strictEqual(t.hour, 7);
  assert.strictEqual(t.minute, 30);
  assert.deepStrictEqual(t.days, ["Mon"]);
  assert.strictEqual(t.durationMin, 20);
  assert.strictEqual(E.decodeClimateTimers([0, 0, 0]), null);   // too short
});

test("preheat planning: ends when you leave, honours keyword, all-day, past and horizon", () => {
  const now = Date.UTC(2026, 0, 1, 6, 0), H = 3600000;
  const ev = (title, hours, extra) => Object.assign({ title, begin: now + hours * H, end: now + (hours + 1) * H, allDay: false, location: "x" }, extra);
  const cfg = { minutes: 20, departBeforeMin: 15, keyword: "", horizonH: 24 };
  const p = E.planPreheat([ev("work", 3)], cfg, now);
  assert.strictEqual(p.startAt, now + 3 * H - 35 * 60000);
  assert.strictEqual(p.minutes, 20);
  assert.strictEqual(E.planPreheat([ev("work", 3, { allDay: true })], cfg, now), null);
  assert.strictEqual(E.planPreheat([ev("work", 0.5)], cfg, now), null);          // start time already passed
  assert.strictEqual(E.planPreheat([ev("work", 30)], cfg, now), null);           // beyond horizon
  assert.strictEqual(E.planPreheat([ev("gym", 3)], Object.assign({}, cfg, { keyword: "work" }), now), null);
  assert.strictEqual(E.planPreheat([ev("work", 3, { location: "" })], Object.assign({}, cfg, { requireLocation: true }), now), null);
  const earliest = E.planPreheat([ev("b", 5), ev("a", 3)], cfg, now);
  assert.strictEqual(earliest.event.title, "a");
});

test("engine: pings when idle, tolerates garbage input and never throws", () => {
  const sent = []; let t = 1000;
  const eng = new E.Engine({ send: b => sent.push(b), now: () => t });
  eng.tick();
  assert.strictEqual(sent.length, 1);
  assert.strictEqual(sent[0][0] ^ 0, E.T.PING_REQ);              // no key yet, so no XOR
  assert.doesNotThrow(() => eng.feed([0, 1, 2, 3, 255, 254, 253]));
  assert.doesNotThrow(() => eng.feed(new Array(10000).fill(0xaa)));   // oversized junk is capped
});
