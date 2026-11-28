/* Top page: forward PhevBridge callbacks (window.__phevEvent/__phevRx/__phevAlarm) to the Remote tab iframe. */
(function () {
  ["__phevEvent", "__phevRx", "__phevAlarm"].forEach(function (fn) {
    window[fn] = function () {
      var fr = document.getElementById("remoteFrame");
      if (!fr || !fr.contentWindow) return;
      fr.contentWindow.postMessage({ phevCb: true, fn: fn, args: Array.prototype.slice.call(arguments) }, "*");
    };
  });
})();

/* Settings > Car WiFi page <-> Remote iframe */
(function () {
  function fr() { var f = document.getElementById("remoteFrame"); return f && f.contentWindow; }
  function cmd(c) { var w = fr(); if (w) w.postMessage({ phevCmd: c }, "*"); }
  var set = function (id, t) { var e = document.getElementById(id); if (e) e.textContent = t || "\u2014"; };
  window.addEventListener("message", function (e) {
    var d = e.data; if (!d || d.phevStatus !== true || e.source !== fr()) return;
    set("wifiStatus", d.status); set("wifiPairMsg", d.pair); set("wifiNote", d.wifi);
    window.__phevConn = !!d.connected; if (window.__phevLangPend && !d.connected) langReload();
  });
  /* the Remote iframe reads the app language when it loads: reload it after a language change, but never while a car session is active */
  function langReload() { window.__phevLangPend = false; var f = document.getElementById("remoteFrame"); if (f && f.contentWindow) { try { f.contentWindow.location.reload(); } catch (e) { } } }
  document.addEventListener("langchange", function () { window.__phevLangPend = true; if (!window.__phevConn) langReload(); });
  function bind(id, c, after) { var b = document.getElementById(id); if (b) b.addEventListener("click", function () { cmd(c); if (after) after(); }); }
  bind("wifiConnect", "connect"); bind("wifiDisc", "disconnect"); bind("wifiPair", "pair");
  var cfg = document.getElementById("wifiCfg");
  if (cfg) cfg.addEventListener("click", function () {
    var t = document.querySelector('.tabs button[data-tab="remote"]'); if (t) t.click(); setTimeout(function () { cmd("settings"); }, 150);
  });
  var f = document.getElementById("remoteFrame"); if (f) f.addEventListener("load", function () { setTimeout(function () { cmd("hello"); }, 300); });
})();
