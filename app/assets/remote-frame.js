try { var _l = localStorage.getItem("outy.lang"); if (_l === "ro" || _l === "en") document.documentElement.lang = _l; } catch (e) {}
/* Native -> page callbacks are evaluated on the top window; the top page forwards them here via postMessage. */
window.addEventListener("message", function (e) {
  var d = e.data;
  if (e.source !== window.parent || !d || d.phevCb !== true) return;
  var f = window[d.fn];
  if (typeof f === "function") { try { f.apply(window, d.args || []); } catch (x) { } }
});
