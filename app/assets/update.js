/* OutyDS in-app updater: checks the latest GitHub release, asks the user, downloads the APK and starts the installer. */
(function () {
  "use strict";
  var VERSION = "1.96";                 // keep in sync with versionName (build script bumps it)
  var DEFAULT_REPO = "cangri-outy/Outy";                // "owner/repo" – can also be set in Settings > Updates
  var K_REPO = "outy.upd.repo", K_AUTO = "outy.upd.auto";
  var T = {
    ro: { title: "Actualizări", cur: "Versiune instalată", none: "Setează repo-ul GitHub (owner/repo).", checking: "Se verifică…", latest: "Ai deja ultima versiune.", failed: "Verificarea a eșuat (fără internet sau repo greșit).", noapk: "Release-ul nu are fișier .apk.", newv: "Versiune nouă disponibilă", upd: "Actualizează", later: "Mai târziu", dl: "Se descarcă…", inst: "Se deschide instalarea…", perm: "Permite instalarea din această sursă, apoi apasă din nou „Actualizează”.", noinst: "Instalarea nu a pornit. Fișierul e în Descărcări:", dlfail: "Descărcarea a eșuat.", nonative: "Funcția cere versiunea nativă a aplicației." },
    en: { title: "Updates", cur: "Installed version", none: "Set the GitHub repo (owner/repo).", checking: "Checking…", latest: "You already have the latest version.", failed: "Check failed (offline or wrong repo).", noapk: "The release has no .apk file.", newv: "New version available", upd: "Update", later: "Later", dl: "Downloading…", inst: "Opening the installer…", perm: "Allow installing from this source, then tap “Update” again.", noinst: "Installer did not start. The file is in Downloads:", dlfail: "Download failed.", nonative: "This needs the native app version." }
  };
  function L() { try { return window.I18N && I18N.get() === "en" ? T.en : T.ro; } catch (e) { return T.ro; } }
  function ls(k, v) { try { if (v === undefined) return localStorage.getItem(k); localStorage.setItem(k, v); } catch (e) { } return null; }
  function repo() { return (ls(K_REPO) || DEFAULT_REPO || "").trim(); }
  function nums(v) { return String(v).replace(/^[^0-9]*/, "").split(/[^0-9]+/).filter(Boolean).map(Number); }
  function newer(a, b) { var x = nums(a), y = nums(b); for (var i = 0; i < Math.max(x.length, y.length); i++) { var p = x[i] || 0, q = y[i] || 0; if (p !== q) return p > q; } return false; }
  function $(id) { return document.getElementById(id); }
  function nat() { return window.OutyNative && typeof OutyNative.updStart === "function" ? OutyNative : null; }

  function latest() {
    var r = repo(); if (!/^[\w.-]+\/[\w.-]+$/.test(r)) return Promise.reject("none");
    var ctl = typeof AbortController === "function" ? new AbortController() : null, to = setTimeout(function () { if (ctl) ctl.abort(); }, 9000);
    return fetch("https://api.github.com/repos/" + r + "/releases/latest", { headers: { Accept: "application/vnd.github+json" }, signal: ctl ? ctl.signal : undefined })
      .then(function (res) { clearTimeout(to); if (!res.ok) throw 0; return res.json(); })
      .then(function (j) {
        var a = (j.assets || []).filter(function (x) { return /\.apk$/i.test(x.name || ""); });
        a.sort(function (x, y) { return (/outyds/i.test(y.name) ? 1 : 0) - (/outyds/i.test(x.name) ? 1 : 0); });
        return { tag: j.tag_name || "", notes: (j.body || "").slice(0, 500), url: a[0] ? a[0].browser_download_url : "", name: a[0] ? a[0].name : "" };
      });
  }

  var dlId = null, timer = null;
  function setMsg(t) { var m = $("updMsg"); if (m) m.textContent = t || ""; var d = $("updDlgMsg"); if (d) d.textContent = t || ""; }
  function bar(p) { ["updBar", "updDlgBar"].forEach(function (id) { var b = $(id); if (b) { b.hidden = p == null; b.value = p || 0; } }); }

  function tryInstall() {
    var n = nat(), t = L(); if (!n || dlId == null) return;
    var r = n.updInstall(String(dlId));
    if (r === 1) setMsg(t.inst); else if (r === 2) setMsg(t.perm); else setMsg(t.noinst + " " + (window.__updName || ""));
  }
  function download(info) {
    var n = nat(), t = L();
    if (!n) { setMsg(t.nonative); return; }
    if (dlId != null && info === undefined) { tryInstall(); return; }
    if (!info.url) { setMsg(t.noapk); return; }
    window.__updName = info.name || ("OutyDS-" + info.tag + ".apk");
    var id = n.updStart(info.url, window.__updName);
    if (!id || id === "-1") { setMsg(t.dlfail); return; }
    dlId = id; setMsg(t.dl); bar(0);
    clearInterval(timer);
    timer = setInterval(function () {
      var s = String(n.updStatus(dlId)).split("|"), st = +s[0], got = +s[1], tot = +s[2];
      if (tot > 0) bar(Math.round(100 * got / tot));
      if (st === 8) { clearInterval(timer); bar(100); tryInstall(); }
      else if (st === 16 || st === -1) { clearInterval(timer); dlId = null; bar(null); setMsg(t.dlfail); }
    }, 600);
  }

  function dialog(info) {
    var t = L(), old = $("updDlg"); if (old) old.remove();
    var d = document.createElement("div"); d.id = "updDlg"; d.className = "updDlg";
    d.innerHTML = '<div class="updBox"><h3></h3><p class="updNotes"></p><progress id="updDlgBar" max="100" value="0" hidden></progress><p id="updDlgMsg" class="muted small"></p><div class="row"><button type="button" class="primary" id="updYes"></button><button type="button" id="updNo"></button></div></div>';
    d.querySelector("h3").textContent = t.newv + ": " + info.tag;
    d.querySelector(".updNotes").textContent = info.notes;
    d.querySelector("#updYes").textContent = t.upd; d.querySelector("#updNo").textContent = t.later;
    d.querySelector("#updNo").onclick = function () { d.remove(); };
    d.querySelector("#updYes").onclick = function () { download(dlId == null ? info : undefined); };
    document.body.appendChild(d);
  }

  function check(manual) {
    var t = L(); if (manual) setMsg(t.checking);
    return latest().then(function (info) {
      if (info.tag && newer(info.tag, VERSION)) { if (manual) setMsg(t.newv + ": " + info.tag); dialog(info); }
      else if (manual) setMsg(t.latest);
    }).catch(function (e) { if (manual) setMsg(e === "none" ? t.none : t.failed); });
  }

  function init() {
    var cur = $("updCur"); if (cur) cur.textContent = VERSION;
    var inp = $("updRepo"); if (inp) { inp.value = repo(); inp.addEventListener("change", function () { ls(K_REPO, inp.value.trim()); }); }
    var au = $("updAuto"); if (au) { au.checked = ls(K_AUTO) !== "0"; au.addEventListener("change", function () { ls(K_AUTO, au.checked ? "1" : "0"); }); }
    var b = $("updCheck"); if (b) b.addEventListener("click", function () { if (inp) ls(K_REPO, inp.value.trim()); check(true); });
    if (ls(K_AUTO) !== "0" && repo() && navigator.onLine !== false) setTimeout(function () { check(false); }, 4000);
  }
  if (document.readyState === "loading") document.addEventListener("DOMContentLoaded", init); else init();
})();
