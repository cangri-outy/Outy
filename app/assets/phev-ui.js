/* PHEV tab UI + glue between PhevEngine (phev-engine.js) and the native PhevBridge. */
(function () {
  "use strict";
  var E = window.PhevEngine, N = window.PhevNative;
  var $ = function (id) { return document.getElementById(id); };
  var ro = (navigator.language || "").indexOf("ro") === 0;
  var L = ro ? {
    off: "Deconectat", conn: "Se conectează…", wait: "Aștept mașina…", on: "Conectat", simple: "Conectează",
    disc: "Deconectează", soc: "Baterie", charge: "Încărcare", charging: "Se încarcă", notCharging: "Nu se încarcă",
    plug: "Încărcător", live: "activ", none: "inactiv", climate: "Climatizare", timers: "Programări clima ale mașinii",
    noTimers: "Nicio programare activă (sau încă necitită)", heat: "Climatizare", start: "Pornește", cancel: "Oprește",
    modeHeat: "Încălzire", modeCool: "Răcire", modeDefrost: "Dezaburire",
    lights: "Lumini exterioare", headOn: "Faruri pornite", headOff: "Faruri oprite", parkOn: "Poziție pornite", parkOff: "Poziție oprite",
    chargeTimer: "Programare încărcare", cancelChg: "Anulează programarea", locked: "Încuiat", unlocked: "Descuiat",
    doorsClosed: "Închise", doorsOpen: "Deschise", lightOn: "Pornit", lightOff: "Oprit",
    pairing: "Înregistrează telefonul", pairHelp: "În mașină: „Setup Your Vehicle”, apoi apasă butonul.",
    cal: "Preîncălzire după calendar", planNone: "Niciun eveniment potrivit în următoarele 24 h",
    needCal: "Permite accesul la calendar", save: "Salvează & armează", disarm: "Dezarmează", term: "Preîncălzire oprită de mașină", reset: "Resetează",
    sent: "Trimis, aștept confirmarea mașinii…", ok: "Confirmat de mașină", noconf: "Trimis, dar mașina n-a confirmat încă",
    err: "Eroare: ", min: "min", hazard: "Avarii", interior: "Lumină interior",
    tabLights: "Lumini", tabCharging: "Încărcare", tabHeating: "Climă", tabSettings: "Setări",
    bgReliability: "Fiabilitate în fundal", bgReliabilityBtn: "Dezactivează optimizarea bateriei",
    bgReliabilityHelp: "Recomandat pentru preîncălzirea programată: Android poate opri conexiunea dacă aplicația e în fundal și optimizarea bateriei e activă.",
    bgReliabilityOn: "Deja dezactivată pentru această aplicație", bgReliabilityOff: "Activă — apasă butonul pentru a o dezactiva",
    connection: "Conexiune", registerSec: "Înregistrare telefon"
  } : {
    off: "Disconnected", conn: "Connecting…", wait: "Waiting for the car…", on: "Connected", simple: "Connect",
    disc: "Disconnect", soc: "Battery", charge: "Charging", charging: "Charging", notCharging: "Not charging",
    plug: "Charger", live: "live", none: "not live", climate: "Climate", timers: "Car's climate timers",
    noTimers: "No active timers (or not read yet)", heat: "Preheat", start: "Start", cancel: "Stop",
    modeHeat: "Heat", modeCool: "Cool", modeDefrost: "Defrost",
    lights: "Exterior lights", headOn: "Headlights on", headOff: "Headlights off", parkOn: "Parking lights on", parkOff: "Parking lights off",
    chargeTimer: "Charge timer", cancelChg: "Cancel charge timer", locked: "Locked", unlocked: "Unlocked",
    doorsClosed: "Closed", doorsOpen: "Open", lightOn: "On", lightOff: "Off",
    pairing: "Register this phone", pairHelp: "In the car: \"Setup Your Vehicle\", then press the button.",
    cal: "Calendar preheat", planNone: "No matching event in the next 24 h",
    needCal: "Allow calendar access", save: "Save & arm", disarm: "Disarm", term: "Preheat terminated by the car", reset: "Reset",
    sent: "Sent, waiting for the car to confirm…", ok: "Confirmed by the car", noconf: "Sent, but the car hasn't confirmed yet",
    err: "Error: ", min: "min", hazard: "Hazards", interior: "Interior light",
    tabLights: "Lights", tabCharging: "Charging", tabHeating: "Heating", tabSettings: "Settings",
    bgReliability: "Background reliability", bgReliabilityBtn: "Turn off battery optimization",
    bgReliabilityHelp: "Recommended for scheduled preheat: Android can suspend the connection while the app is backgrounded if battery optimization is on.",
    bgReliabilityOn: "Already turned off for this app", bgReliabilityOff: "Currently on — tap to turn it off",
    connection: "Connection", registerSec: "Register phone"
  };
  var root = $("phevRoot"); if (!root) return;
  if (!N) { root.innerHTML = "<p class='muted'>PHEV native bridge missing.</p>"; return; }

  // ---- settings ----
  var DEF = { host: "192.168.8.46", port: 8080, ssid: "", psk: "", auto: false, minutes: 20, depart: 15, keyword: "", reqLoc: false, calMin: 20 };
  var S = (function () { try { return Object.assign({}, DEF, JSON.parse(localStorage.getItem("phev.settings") || "{}")); } catch (e) { return Object.assign({}, DEF); } })();
  function saveS() {
    try { localStorage.setItem("phev.settings", JSON.stringify(S)); } catch (e) { }
    // Mirror the bits the background service needs (Wi-Fi + mode) into native SharedPreferences,
    // since a scheduled preheat can run with no WebView alive to read localStorage from.
    if (N.saveNetConfig) { try { N.saveNetConfig(S.ssid || "", S.psk || "", S.host, S.port | 0, S.mode || "heat"); } catch (e) { } }
  }

  // ---- UI skeleton: persistent header (status + car + gauge), then 4 tabs ----
  root.innerHTML =
    '<div class="card"><div class="phevHead"><b id="pStatus">' + L.off + '</b><span id="pMy" class="muted small"></span></div>' +
    '<div class="row"><button type="button" id="pConnect" class="phevBtn primary">' + L.simple + '</button>' +
    '<button type="button" id="pDisc" class="phevBtn">' + L.disc + '</button></div></div>' +

    '<div class="card dashCard">' +
      '<div class="carStage">' +
      '<div class="carSvgWrap">' +
        '<img src="car-photo.jpg" class="carPhotoImg" alt="">' +
        '<svg viewBox="0 0 937 1679" class="carOverlaySvg" preserveAspectRatio="xMidYMid meet">' +
          '<defs>' +
            '<radialGradient id="beamGrad"><stop offset="0" stop-color="#ffffff" stop-opacity="0.9"/><stop offset="1" stop-color="#ffffff" stop-opacity="0"/></radialGradient>' +
            '<radialGradient id="tailGrad"><stop offset="0" stop-color="#ff3b3b" stop-opacity="0.95"/><stop offset="1" stop-color="#ff3b3b" stop-opacity="0"/></radialGradient>' +
          '</defs>' +
          '<ellipse id="carHalo" cx="468" cy="820" rx="330" ry="635" class="carHalo"/>' +
          /* interior cabin glow: windshield + rear glass + the mid panel visible in the photo */
          '<rect id="interiorGlow" x="292" y="468" width="356" height="300" rx="50" class="interiorGlow"/>' +
          /* headlights: the photo shows no exposed lamp units from directly above, so the glow sits
             just ahead of the nose, where real headlights would be, beaming further forward.
             Two brightness tiers: "park" (sidelights/parking lights alone) and "on" (full headlights). */
          '<g id="headL" class="headlight"><ellipse cx="390" cy="258" rx="26" ry="16"/><path d="M372 250 L250 150 L250 340 Z" class="beam"/></g>' +
          '<g id="headR" class="headlight"><ellipse cx="546" cy="258" rx="26" ry="16"/><path d="M564 250 L686 150 L686 340 Z" class="beam"/></g>' +
          /* taillights: same two-tier brightness, lit by parking lights alone or brighter with headlights */
          '<g id="tailL" class="taillight"><ellipse cx="300" cy="1362" rx="30" ry="20"/></g>' +
          '<g id="tailR" class="taillight"><ellipse cx="636" cy="1362" rx="30" ry="20"/></g>' +
          /* doors/hood/trunk: each panel is hinged along the edge closest to the body and scales out
             from that hinge when open, mimicking a door swinging or a hood/trunk lifting, rather than
             just a flat glow. Front doors hinge just behind the mirrors; rear doors further back. */
          '<rect id="doorFL" x="178" y="630" width="70" height="170" rx="14" class="doorMark hingeRight"/>' +
          '<rect id="doorRL" x="178" y="810" width="70" height="170" rx="14" class="doorMark hingeRight"/>' +
          '<rect id="doorFR" x="689" y="630" width="70" height="170" rx="14" class="doorMark hingeLeft"/>' +
          '<rect id="doorRR" x="689" y="810" width="70" height="170" rx="14" class="doorMark hingeLeft"/>' +
          '<rect id="bonnetMark" x="270" y="255" width="396" height="200" rx="20" class="panelMark hingeBottom"/>' +
          '<rect id="bootMark" x="270" y="790" width="396" height="390" rx="20" class="panelMark hingeTop"/>' +
        '</svg>' +
        '<div class="gaugeOverlay"><svg viewBox="0 0 120 120" class="gauge"><circle cx="60" cy="60" r="52" class="gaugeTrack"/>' +
          '<circle cx="60" cy="60" r="52" class="gaugeFill" id="socArc" stroke-dasharray="0 327"/></svg>' +
          '<div class="gaugeCenter"><b id="pSoc">--</b><span class="muted small">' + L.soc + '</span><svg id="boltIcon" class="bolt" viewBox="0 0 24 24" hidden><path d="M13 2 4 14h6l-1 8 9-12h-6z"/></svg></div>' +
        '</div>' +
      '</div>' +
        '<p id="pCarNote" class="muted small carNote"></p>' +
      '</div>' +
      '<div class="vehInfoRow"><span id="pVin" class="muted small"></span><span id="pClock" class="muted small"></span></div>' +
    '</div>' +

    '<nav class="phevTabs">' +
      '<button type="button" class="phevTabBtn on" data-page="lights">' + L.tabLights + '</button>' +
      '<button type="button" class="phevTabBtn" data-page="charging">' + L.tabCharging + '</button>' +
      '<button type="button" class="phevTabBtn" data-page="heating">' + L.tabHeating + '</button>' +
      '<button type="button" class="phevTabBtn" data-page="settings">' + L.tabSettings + '</button>' +
    '</nav>' +

    '<section class="phevPage" data-page="lights">' +
      '<div class="card"><div class="statusRow">' +
        '<div class="statusChip" id="chipLock"><svg viewBox="0 0 24 24"><path d="M6 10V7a6 6 0 0 1 12 0v3M5 10h14v10H5z"/></svg><span id="pLock">--</span></div>' +
        '<div class="statusChip" id="chipDoors"><svg viewBox="0 0 24 24"><path d="M4 3h11v18H4zM15 3l5 2v16l-5-2M9 12v.01"/></svg><span id="pDoors">--</span></div>' +
        '<div class="statusChip" id="chipHeadlights"><svg viewBox="0 0 24 24"><path d="M3 11a7 7 0 0 1 7-7c4 0 7 3 7 7v6H8a5 5 0 0 1-5-5z"/><path d="M17 9h4M17 12h4M17 15h4"/></svg><span id="pHeadlights">--</span></div>' +
      '</div>' +
      '<div class="statusRow">' +
        '<div class="statusChip" id="chipInterior"><svg viewBox="0 0 24 24"><path d="M12 2v2M12 20v2M4.9 4.9l1.4 1.4M17.7 17.7l1.4 1.4M2 12h2M20 12h2M4.9 19.1l1.4-1.4M17.7 6.3l1.4-1.4"/><circle cx="12" cy="12" r="4"/></svg><span id="pInterior">--</span></div>' +
        '<div class="statusChip" id="chipHazard"><svg viewBox="0 0 24 24"><path d="M12 3 2 20h20z"/></svg><span id="pHazard">--</span></div>' +
      '</div></div>' +
      '<div class="card"><h3>' + L.lights + '</h3>' +
        '<div class="row"><button type="button" id="pHeadOn" class="phevBtn">' + L.headOn + '</button><button type="button" id="pHeadOff" class="phevBtn">' + L.headOff + '</button></div>' +
        '<div class="row"><button type="button" id="pParkOn" class="phevBtn">' + L.parkOn + '</button><button type="button" id="pParkOff" class="phevBtn">' + L.parkOff + '</button></div>' +
        '<p id="pLightsMsg" class="small"></p></div>' +
    '</section>' +

    '<section class="phevPage" data-page="charging" hidden>' +
      '<div class="card"><div class="statusRow">' +
        '<div class="statusChip" id="chipPlug"><svg viewBox="0 0 24 24"><path d="M8 2v4M16 2v4M6 8h12v5a6 6 0 0 1-12 0zm2 11v3a2 2 0 0 0 2 2h4a2 2 0 0 0 2-2v-3"/></svg><span id="pPlug">--</span></div>' +
        '<div class="statusChip" id="chipCharge"><svg viewBox="0 0 24 24"><path d="M13 2 4 14h6l-1 8 9-12h-6z"/></svg><span id="pChg">--</span></div>' +
      '</div></div>' +
      '<div class="card"><h3>' + L.chargeTimer + '</h3>' +
        '<div class="row"><button type="button" id="pCancelChg" class="phevBtn">' + L.cancelChg + '</button></div>' +
        '<p id="pChgMsg" class="small"></p></div>' +
    '</section>' +

    '<section class="phevPage" data-page="heating" hidden>' +
      '<div class="card"><div class="statusRow"><div class="statusChip" id="chipClimate"><svg id="climateIcon" viewBox="0 0 24 24"><path d="M12 2v20M4 7l16 10M20 7 4 17"/></svg><span id="pClimate">--</span></div></div></div>' +
      '<div class="card">' + '<h3>' + L.climate + '</h3>' +
      '<div class="seg" id="pMode"><button type="button" data-mode="heat" class="on">' + L.modeHeat + '</button><button type="button" data-mode="cool">' + L.modeCool + '</button><button type="button" data-mode="windscreen">' + L.modeDefrost + '</button></div>' +
      '<div class="seg" id="pDur"><button type="button" data-m="10">10 ' + L.min + '</button><button type="button" data-m="20" class="on">20 ' + L.min + '</button><button type="button" data-m="30">30 ' + L.min + '</button></div>' +
      '<div class="row"><button type="button" id="pHeat" class="phevBtn primary">' + L.start + '</button><button type="button" id="pStop" class="phevBtn">' + L.cancel + '</button>' +
      '<button type="button" id="pReset" class="phevBtn" hidden>' + L.reset + '</button></div><p id="pCmd" class="small"></p></div>' +

      '<div class="card"><h3>' + L.timers + '</h3><div id="pTimers" class="muted"></div></div>' +

      '<div class="card"><h3>' + L.cal + '</h3>' +
      '<label class="phevF">' + L.heat + '<select id="cMin"><option value="10">10</option><option value="20">20</option><option value="30">30</option></select></label>' +
      '<label class="phevF">' + (ro ? "Pleacă cu (min) înainte" : "Leave (min) before event") + '<input id="cDep" inputmode="numeric"></label>' +
      '<label class="phevF">' + (ro ? "Cuvânt în titlu" : "Title contains") + '<input id="cKw" autocapitalize="off"></label>' +
      '<label class="phevF">' + (ro ? "Doar evenimente cu locație" : "Only events with a location") + '<input id="cLoc" type="checkbox"></label>' +
      '<div class="row"><button type="button" id="cArm" class="phevBtn primary">' + L.save + '</button><button type="button" id="cOff" class="phevBtn">' + L.disarm + '</button></div>' +
      '<p id="cPlan" class="small"></p><p id="cNote" class="muted small"></p></div>' +
    '</section>' +

    '<section class="phevPage" data-page="settings" hidden>' +
      '<div class="card"><h3>' + L.connection + '</h3><details class="phevDet" open><summary>Wi-Fi</summary>' +
      '<label class="phevF">SSID<input id="pSsid" placeholder="REMOTE…" autocapitalize="off" autocomplete="off"></label>' +
      '<label class="phevF">Password<input id="pPsk" type="password" autocomplete="off"></label>' +
      '<label class="phevF">Host<input id="pHost"></label><label class="phevF">Port<input id="pPort" inputmode="numeric"></label>' +
      '<div class="row"><button type="button" id="pWifiSet" class="phevBtn">Wi-Fi settings</button></div>' +
      '<label class="phevF">Diagnostic capture<input id="pCap" type="checkbox"></label>' +
      '<p class="muted small" id="pWifiNote"></p><p class="muted small" id="pCapNote"></p></details></div>' +

      '<div class="card"><h3>' + L.registerSec + '</h3><p class="muted small">' + L.pairHelp + '</p>' +
      '<div class="row"><button type="button" id="pPair" class="phevBtn">' + L.pairing + '</button></div><p id="pPairMsg" class="small"></p></div>' +

      '<div class="card"><h3>' + L.bgReliability + '</h3><p class="muted small">' + L.bgReliabilityHelp + '</p>' +
      '<div class="row"><button type="button" id="pBattOpt" class="phevBtn">' + L.bgReliabilityBtn + '</button></div><p id="pBattMsg" class="small"></p></div>' +

      '<div class="card"><div class="phevHead"><h3>Debug log</h3><div class="row" style="margin-top:0"><button type="button" id="pLogCopy" class="phevBtn">Copy log</button><button type="button" id="pLogClear" class="phevBtn">Clear</button></div></div>' +
      '<p class="muted small" id="pLogNote"></p><pre id="pLog" class="log" style="max-height:320px;overflow:auto"></pre></div>' +
    '</section>';

  // ---- tab switching ----
  Array.prototype.forEach.call(document.querySelectorAll(".phevTabBtn"), function (b) {
    b.addEventListener("click", function () {
      var page = b.dataset.page;
      Array.prototype.forEach.call(document.querySelectorAll(".phevTabBtn"), function (x) { x.classList.toggle("on", x === b); });
      Array.prototype.forEach.call(document.querySelectorAll(".phevPage"), function (sec) { sec.hidden = sec.dataset.page !== page; });
    });
  });

  function log(s) {
    var el = $("pLog"); if (!el) return;
    var ts = new Date().toISOString().slice(11, 23);  // HH:MM:SS.mmm, matches the file capture's format
    var line = ts + " " + s;
    el.textContent += line + "\n";
    el.scrollTop = el.scrollHeight;
    if (el.textContent.length > 40000) el.textContent = el.textContent.slice(-30000);
    if (N.logLine) {
      var ok = N.logLine(line);
      if (ok && !logFileNoted) { logFileNoted = true; $("pLogNote").textContent = "Also saving to Downloads/OutyDS-log-\u2026.log"; }
      else if (!ok && !logFileFailNoted) { logFileFailNoted = true; $("pLogNote").textContent = "Could not write to Downloads (check storage permission)"; }
    }
  }
  var logFileNoted = false, logFileFailNoted = false;
  function describeFrame(dir, m) {
    var names = {}; names[E.T.PING_REQ] = "PING_REQ"; names[E.T.PING_RESP] = "PING_RESP"; names[E.T.SEND] = "SEND";
    names[E.T.RESP] = "RESP"; names[E.T.START24] = "START24"; names[E.T.START24_RESP] = "START24_RESP";
    names[E.T.START18] = "START18"; names[E.T.START18_RESP] = "START18_RESP"; names[E.T.START14] = "START14";
    names[E.T.START14_RESP] = "START14_RESP"; names[E.T.BAD_XOR] = "BAD_XOR"; names[E.T.CC] = "CC"; names[E.T.START_RESP] = "START_RESP";
    var tn = names[m.type] || ("0x" + m.type.toString(16));
    return dir + " " + tn + " ack=" + m.ack + " reg=0x" + m.register.toString(16) + " data=" + E.hex(m.data, m.data.length);
  }
  $("pLogCopy").addEventListener("click", function () {
    var text = $("pLog").textContent;
    var ok = N.copyToClipboard ? N.copyToClipboard(text) : false;
    $("pLogNote").textContent = ok ? "Copied " + text.length + " characters to the clipboard" : "Could not copy (clipboard unavailable)";
  });
  $("pLogClear").addEventListener("click", function () { $("pLog").textContent = ""; $("pLogNote").textContent = ""; });
  function setStatus(t) { $("pStatus").textContent = t; }

  // ---- engine + transport ----
  var eng = null, tickT = null, refreshT = null, connected = false, wantConn = false;
  function newEngine() {
    eng = new E.Engine({ send: function (b) { var h = E.hex(b); log("TX raw " + h); N.send(h); } });
    eng.on(function (ev, d) {
      if (ev === "started") { setStatus(L.on); $("pMy").textContent = "MY" + d; log("car started, model year class " + d); onStarted(); }
      if (ev === "state") render();
      if (ev === "msg") log(describeFrame("RX", d));
      if (ev === "error") log("engine error: " + d);
    });
  }
  window.__phevRx = function (h) { log("RX raw " + h); if (eng) { try { eng.feed(E.unhex(h)); } catch (e) { log("rx error " + e); } } };
  window.__phevEvent = function (name, msg) {
    log(name + (msg ? ": " + msg : ""));
    if (name === "join") {
      if (msg === "ok") { $("pWifiNote").textContent = "Wi-Fi joined"; if (wantConn) openSocket(); }
      else if (msg !== "lost") { $("pWifiNote").textContent = msg; setStatus(L.off); wantConn = false; }
    }
    if (name === "open") { setStatus(L.wait); connected = true; startTimers(); }
    if (name === "closed") { connected = false; stopTimers(); setStatus(L.off + (msg ? " – " + msg : ""));
      if (wantConn && S.ssid && !joinTried && N.sdk() >= 29) { joinTried = true; joinWithPerm(); } }
  };
  function startTimers() {
    stopTimers();
    tickT = setInterval(function () { if (eng) eng.tick(); }, 200);
    refreshT = setInterval(function () { if (eng && eng.state.started) eng.refresh(); }, 300000);
  }
  function stopTimers() { clearInterval(tickT); clearInterval(refreshT); }
  function openSocket() { newEngine(); setStatus(L.conn); N.connect(S.host, S.port | 0); }
  var joinTried = false, lastTry = 0;
  function joinWithPerm() {
    if (N.hasPerm("wifi")) return N.joinCar(S.ssid, S.psk);
    N.askPerm("wifi"); $("pWifiNote").textContent = "Allow the permission prompt…";
    var n = 0, w = setInterval(function () {
      if (N.hasPerm("wifi")) { clearInterval(w); N.joinCar(S.ssid, S.psk); }
      else if (++n > 40) { clearInterval(w); $("pWifiNote").textContent = "Wi-Fi permission denied"; setStatus(L.off); }
    }, 750);
  }
  function connectNow(manual) {
    if (manual === true) joinTried = false;
    if (Date.now() - lastTry < 20000 && manual !== true) return;   // an attempt is already in flight
    lastTry = Date.now(); wantConn = true;
    if (N.wifiPresent()) openSocket();
    else if (S.ssid && N.sdk() >= 29) { joinTried = true; setStatus(L.conn); joinWithPerm(); }
    else { setStatus(L.off + " – join the car Wi-Fi first"); wantConn = false; }
  }
  function disconnect() { wantConn = false; try { N.cancelJoin(); } catch (e) { } N.close(); connected = false; stopTimers(); setStatus(L.off); }

  // ---- render ----
  var DAY_ABBR = ro ? ["D", "L", "Ma", "Mi", "J", "V", "S"] : ["S", "M", "T", "W", "T", "F", "S"];
  var DAY_FULL = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];
  function fmtMin(m) { return m >= 60 ? Math.floor(m / 60) + " h " + (m % 60) + " min" : m + " min"; }
  var GAUGE_C = 2 * Math.PI * 52;  // circumference of the gauge's r=52 circle
  function render() {
    if (!eng) return; var s = eng.state;

    // --- SoC gauge ---
    var pct = s.soc == null ? null : Math.max(0, Math.min(100, s.soc));
    $("pSoc").textContent = pct == null ? "--" : pct + "%";
    var arc = $("socArc");
    if (pct == null) { arc.setAttribute("stroke-dasharray", "0 " + GAUGE_C); }
    else {
      var len = (pct / 100) * GAUGE_C;
      arc.setAttribute("stroke-dasharray", len.toFixed(1) + " " + GAUGE_C);
      arc.classList.toggle("low", pct < 20);
      arc.classList.toggle("mid", pct >= 20 && pct < 50);
    }
    $("boltIcon").hidden = !s.charging;

    // --- status chips: charging/plug ---
    $("pPlug").textContent = s.plugged == null ? "--" : s.plugged ? L.live : L.none;
    $("chipPlug").classList.toggle("active", !!s.plugged);
    $("pChg").textContent = s.charging == null ? "--" : s.charging ? (L.charging + (s.chargeRemainingMin ? " \u00b7 " + fmtMin(s.chargeRemainingMin) : "")) : L.notCharging;
    $("chipCharge").classList.toggle("active", !!s.charging);

    // --- climate ---
    var climateOn = s.preAC === "on" || ((s.acMode === "heat" || s.acMode === "cool" || s.acMode === "windscreen") && s.acOperating);
    var modeLabel = { heat: L.modeHeat, cool: L.modeCool, windscreen: L.modeDefrost }[s.acMode] || s.acMode;
    var cl = s.preAC === "terminated" ? L.term : climateOn ? (modeLabel + " \u2022 on") : s.preAC ? "off" : "--";
    $("pClimate").textContent = cl;
    $("chipClimate").classList.toggle("active", climateOn);
    $("chipClimate").classList.toggle("warn", s.preAC === "terminated");
    $("pReset").hidden = s.preAC !== "terminated";

    // --- car graphic: doors, headlights (white), taillights (red, brighter when lights on), interior (yellow), lock halo ---
    $("doorFL").classList.toggle("open", s.doorDriver === true);
    $("doorFR").classList.toggle("open", s.doorPassenger === true);
    $("doorRL").classList.toggle("open", s.doorRearLeft === true);
    $("doorRR").classList.toggle("open", s.doorRearRight === true);
    $("bonnetMark").classList.toggle("open", s.bonnet === true);
    $("bootMark").classList.toggle("open", s.boot === true);
    // headlights/taillights: two brightness tiers - "park" (parking/sidelights alone) and the
    // brighter "on" (full headlights). headlights implies the sidelights are lit too, same as a real car.
    var lightTier = s.headlights ? "on" : s.parkingLights ? "park" : "off";
    [$("headL"), $("headR"), $("tailL"), $("tailR")].forEach(function (el) {
      el.classList.toggle("on", lightTier === "on");
      el.classList.toggle("park", lightTier === "park");
    });
    $("interiorGlow").classList.toggle("on", !!s.interior);
    var halo = $("carHalo");
    halo.classList.toggle("unlocked", s.locked === false);
    halo.classList.toggle("unknown", s.locked == null);
    halo.classList.toggle("locked-ok", s.locked === true);
    $("pCarNote").textContent = anyDoorOpenNote(s);
    function anyDoorOpenNote(st) {
      var open = [];
      if (st.doorDriver) open.push(ro ? "Ușă șofer" : "Driver door");
      if (st.doorPassenger) open.push(ro ? "Ușă pasager" : "Passenger door");
      if (st.doorRearLeft) open.push(ro ? "Ușă sp. stânga" : "Rear-left door");
      if (st.doorRearRight) open.push(ro ? "Ușă sp. dreapta" : "Rear-right door");
      if (st.boot) open.push(ro ? "Portbagaj" : "Boot");
      if (st.bonnet) open.push(ro ? "Capotă" : "Bonnet");
      return open.join(" \u00b7 ");
    }

    // --- lock / doors / headlights / interior / hazard chips ---
    $("pLock").textContent = s.locked == null ? "--" : s.locked ? L.locked : L.unlocked;
    $("chipLock").classList.toggle("warn", s.locked === false);
    var anyDoorOpen = [s.doorDriver, s.doorPassenger, s.doorRearLeft, s.doorRearRight, s.boot, s.bonnet].some(function (v) { return v === true; });
    var anyDoorKnown = [s.doorDriver, s.doorPassenger, s.doorRearLeft, s.doorRearRight, s.boot, s.bonnet].some(function (v) { return v != null; });
    $("pDoors").textContent = !anyDoorKnown ? "--" : anyDoorOpen ? L.doorsOpen : L.doorsClosed;
    $("chipDoors").classList.toggle("warn", anyDoorOpen);
    $("pHeadlights").textContent = s.headlights == null ? "--" : s.headlights ? L.lightOn : L.lightOff;
    $("chipHeadlights").classList.toggle("active", !!s.headlights);
    $("pInterior").textContent = s.interior == null ? "--" : s.interior ? L.lightOn : L.lightOff;
    $("chipInterior").classList.toggle("active", !!s.interior);
    $("pHazard").textContent = s.hazard == null ? "--" : s.hazard ? L.lightOn : L.lightOff;
    $("chipHazard").classList.toggle("warn", !!s.hazard);

    // --- vehicle info row: VIN + vehicle clock ---
    $("pVin").textContent = s.vin ? "VIN " + s.vin : "";
    $("pClock").textContent = s.carTime ? pad2(s.carTime.h) + ":" + pad2(s.carTime.mi) + " \u00b7 " + s.carTime.y + "-" + pad2(s.carTime.mo) + "-" + pad2(s.carTime.d) : "";

    // --- climate timers ---
    var tt = (s.timers || []).filter(function (t) { return t.on; });
    $("pTimers").innerHTML = tt.length ? '<div class="timerList">' + tt.map(function (t) {
      var days = '<div class="dayChips">' + DAY_FULL.map(function (dn, i) {
        return '<span class="dayChip' + ((t.days || []).indexOf(dn) >= 0 ? ' on' : '') + '">' + DAY_ABBR[i] + '</span>';
      }).join('') + '</div>';
      return '<div class="timerRow"><span class="tTime">' + pad2(+t.hour || 0) + ':' + pad2(+t.minute || 0) + '</span><span class="tDur">' + (+t.durationMin || 0) + ' ' + L.min + '</span>' + days + '</div>';
    }).join('') + '</div>' : L.noTimers;
  }
  function pad2(n) { return (n < 10 ? "0" : "") + n; }

  // ---- preheat ----
  var minutes = S.minutes, mode = S.mode || "heat";
  function markDur() { Array.prototype.forEach.call(document.querySelectorAll("#pDur button"), function (b) { b.classList.toggle("on", +b.dataset.m === minutes); }); }
  function markMode() { Array.prototype.forEach.call(document.querySelectorAll("#pMode button"), function (b) { b.classList.toggle("on", b.dataset.mode === mode); }); }
  markDur(); markMode();
  $("pDur").addEventListener("click", function (e) { var b = e.target.closest("button"); if (!b) return; minutes = +b.dataset.m; S.minutes = minutes; saveS(); markDur(); });
  $("pMode").addEventListener("click", function (e) { var b = e.target.closest("button"); if (!b) return; mode = b.dataset.mode; S.mode = mode; saveS(); markMode(); });

  function preheat(min, done) {
    if (!eng || !eng.state.started) { $("pCmd").textContent = L.err + "not connected"; return done && done(new Error("not connected")); }
    $("pCmd").textContent = L.sent;
    eng.setClimate(mode, min, function (err) {
      if (err) { $("pCmd").textContent = L.err + err.message; return done && done(err); }
      var t0 = Date.now(), w = setInterval(function () {
        var s = eng.state;
        if (s.preAC === "on" || ((s.acMode === "heat" || s.acMode === "cool" || s.acMode === "windscreen") && s.acOperating)) { clearInterval(w); $("pCmd").textContent = L.ok; done && done(null, true); }
        else if (Date.now() - t0 > 60000) { clearInterval(w); $("pCmd").textContent = L.noconf; done && done(null, false); }
      }, 1000);
    });
  }
  $("pHeat").addEventListener("click", function () { preheat(minutes); });
  $("pStop").addEventListener("click", function () {
    if (!eng || !eng.state.started) return; eng.setClimate("off", 10, function (e) { $("pCmd").textContent = e ? L.err + e.message : "OK"; });
  });
  $("pReset").addEventListener("click", function () { if (eng) eng.resetPreAC(function (e) { $("pCmd").textContent = e ? L.err + e.message : "OK"; }); });
  function needConn(el) { if (!eng || !eng.state.started) { el.textContent = L.err + "not connected"; return true; } return false; }
  $("pHeadOn").addEventListener("click", function () { if (needConn($("pLightsMsg"))) return; eng.setHeadlights(true, function (e) { $("pLightsMsg").textContent = e ? L.err + e.message : "OK"; }); });
  $("pHeadOff").addEventListener("click", function () { if (needConn($("pLightsMsg"))) return; eng.setHeadlights(false, function (e) { $("pLightsMsg").textContent = e ? L.err + e.message : "OK"; }); });
  $("pParkOn").addEventListener("click", function () { if (needConn($("pLightsMsg"))) return; eng.setParkingLights(true, function (e) { $("pLightsMsg").textContent = e ? L.err + e.message : "OK"; }); });
  $("pParkOff").addEventListener("click", function () { if (needConn($("pLightsMsg"))) return; eng.setParkingLights(false, function (e) { $("pLightsMsg").textContent = e ? L.err + e.message : "OK"; }); });
  $("pCancelChg").addEventListener("click", function () { if (needConn($("pChgMsg"))) return; $("pChgMsg").textContent = "…"; eng.cancelChargeTimer(function (e) { $("pChgMsg").textContent = e ? L.err + e.message : "OK"; }); });
  $("pPair").addEventListener("click", function () {
    if (!eng || !eng.state.started) { $("pPairMsg").textContent = L.err + "not connected"; return; }
    $("pPairMsg").textContent = eng.state.vin ? "Registering…" : "Waiting for the car to confirm registration mode (up to ~15 s)…";
    eng.registerClient(function (e) { $("pPairMsg").textContent = e ? L.err + e.message : "Registered"; });
  });

  // ---- settings fields ----
  function bindField(id, key, num) { var el = $(id); el.value = S[key]; el.addEventListener("change", function () { S[key] = num ? (parseInt(el.value, 10) || DEF[key]) : el.value.trim(); saveS(); }); }
  bindField("pSsid", "ssid"); bindField("pPsk", "psk"); bindField("pHost", "host"); bindField("pPort", "port", true);
  $("pWifiNote").textContent = N.sdk() >= 29 ? "" : "Android < 10: join the car Wi-Fi in system settings, then press Connect.";
  $("pWifiSet").addEventListener("click", function () { if (N.openWifiSettings) N.openWifiSettings(); });
  function refreshBattMsg() {
    var exempt = N.isIgnoringBatteryOptimizations ? N.isIgnoringBatteryOptimizations() : null;
    $("pBattMsg").textContent = exempt == null ? "" : exempt ? L.bgReliabilityOn : L.bgReliabilityOff;
    $("pBattOpt").hidden = !!exempt;
  }
  refreshBattMsg();
  $("pBattOpt").addEventListener("click", function () {
    if (N.requestIgnoreBatteryOptimizations) N.requestIgnoreBatteryOptimizations();
    setTimeout(refreshBattMsg, 1500);  // the system dialog is async; re-check shortly after
  });
  var capOn = false;
  $("pCap").addEventListener("change", function () {
    if ($("pCap").checked) { capOn = N.startCapture ? N.startCapture() : false; $("pCapNote").textContent = capOn ? "Writing to " + N.captureDir() + " (never your Wi-Fi password)" : "Could not start capture"; }
    else { if (N.stopCapture) N.stopCapture(); capOn = false; $("pCapNote").textContent = ""; }
  });
  $("pConnect").addEventListener("click", function () { connectNow(true); }); $("pDisc").addEventListener("click", disconnect);

  // ---- calendar-driven preheat ----
  $("cMin").value = String(S.calMin); $("cDep").value = S.depart; $("cKw").value = S.keyword; $("cLoc").checked = !!S.reqLoc;
  function readCal() { S.calMin = +$("cMin").value; S.depart = parseInt($("cDep").value, 10); if (isNaN(S.depart)) S.depart = 15; S.keyword = $("cKw").value.trim(); S.reqLoc = $("cLoc").checked; saveS(); }
  function replan() {
    var now = Date.now(), raw;
    if (!N.hasPerm("calendar")) { $("cNote").textContent = L.needCal; N.askPerm("calendar"); return false; }
    raw = JSON.parse(N.calendarEvents(now, now + 36 * 3600000));
    if (raw.error) { $("cNote").textContent = L.err + raw.error; return false; }
    var plan = E.planPreheat(raw, { minutes: S.calMin, departBeforeMin: S.depart, keyword: S.keyword, requireLocation: S.reqLoc, horizonH: 24 }, now);
    if (!plan) { N.cancelAlarm(); $("cPlan").textContent = L.planNone; return false; }
    var ok = N.setAlarm(plan.startAt, plan.minutes, plan.event.title || "");
    var when = new Date(plan.startAt);
    $("cPlan").textContent = (plan.event.title || "(no title)") + " \u2192 " + L.heat + " " + plan.minutes + " " + L.min + " @ " + when.toLocaleString();
    $("cNote").textContent = (N.canExact() ? "" : "Exact alarms are off: the alarm may be a few minutes late. ") + (ok ? "" : L.err + "alarm not set");
    if (!N.canExact()) { try { N.openExactSettings(); } catch (e) { } }
    return true;
  }
  var replanT = null;
  $("cArm").addEventListener("click", function () {
    readCal(); S.auto = true; saveS();
    if (!N.hasPerm("notifications")) N.askPerm("notifications");
    var ok = replan(); if (!ok) { var tries = 0, w = setInterval(function () { if (N.hasPerm("calendar") || ++tries > 30) { clearInterval(w); if (N.hasPerm("calendar")) replan(); } }, 1000); }
    clearInterval(replanT); replanT = setInterval(function () { if (S.auto) replan(); }, 900000);
  });
  $("cOff").addEventListener("click", function () { S.auto = false; saveS(); N.cancelAlarm(); clearInterval(replanT); $("cPlan").textContent = ""; $("cNote").textContent = ""; });

  // ---- scheduled job: connect, send preheat, confirm; retry every 30 s up to 20 min, max 3 sends (same policy as the Pi helper) ----
  var job = null;
  function runJob(min) {
    if (job) return; job = { min: min, t0: Date.now(), sends: 0, confirmed: false };
    log("scheduled preheat " + min + " min: start");
    (function step() {
      if (!job) return;
      if (job.confirmed || Date.now() - job.t0 > 20 * 60000 || job.sends >= 3) { log("scheduled preheat " + (job.confirmed ? "confirmed" : "gave up")); N.clearFired(); job = null; return; }
      if (!connected) { connectNow(); }
      else if (eng && eng.state.started) {
        job.sends++; preheat(min, function (err, ok) { if (ok) job && (job.confirmed = true); });
      }
      setTimeout(step, 30000);
    })();
  }
  window.__phevAlarm = function (min) { if (S.auto) runJob(min); };
  function onStarted() { /* nothing extra: job loop and buttons use eng.state.started */ }

  // alarm that fired while the app was closed (within 20 min)
  try {
    var as = JSON.parse(N.alarmState());
    if (S.auto && as.firedAt && Date.now() - as.firedAt < 20 * 60000) runJob(as.alarmMin || S.calMin);
    else if (as.firedAt) N.clearFired();
    if (S.auto && as.alarmAt && as.alarmAt > Date.now()) { $("cPlan").textContent = "Alarm armed @ " + new Date(as.alarmAt).toLocaleString(); replanT = setInterval(function () { if (S.auto) replan(); }, 900000); }
  } catch (e) { }

  // ---- OutyDS: commands from / status to the Settings > Car WiFi page (parent window) ----
  (function () {
    function post() {
      try { parent.postMessage({ phevStatus: true, status: $("pStatus").textContent, pair: $("pPairMsg").textContent, wifi: $("pWifiNote").textContent, connected: !!connected }, "*"); } catch (e) { }
    }
    ["pStatus", "pPairMsg", "pWifiNote"].forEach(function (id) { new MutationObserver(post).observe($(id), { childList: true, characterData: true, subtree: true }); });
    window.addEventListener("message", function (e) {
      var d = e.data; if (e.source !== parent || !d || !d.phevCmd) return;
      if (d.phevCmd === "connect") connectNow(true);
      else if (d.phevCmd === "disconnect") disconnect();
      else if (d.phevCmd === "pair") $("pPair").click();
      else if (d.phevCmd === "settings") { var b = document.querySelector('.phevTabBtn[data-page="settings"]'); if (b) b.click(); }
      post();
    });
    post();
  })();
  saveS();  // mirror current settings (including any set before this update) to native storage once on load
  newEngine();
})();
