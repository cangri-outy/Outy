"use strict";
const test = require("node:test");
const assert = require("node:assert");
const fs = require("node:fs");
const path = require("node:path");
const vm = require("node:vm");

const src = fs.readFileSync(path.join(__dirname, "../app/assets/elm.js"), "utf8");
const win = { setTimeout, clearTimeout };
vm.runInNewContext(src, { window: win, console, setTimeout, clearTimeout, Date, Promise }, { filename: "elm.js" });
const Elm = win.OutyElm.Elm;

// Minimal ELM327 + CAN model. mode: "good" handles several commands per write;
// "first" processes only the first command of a write (a clone that drops the rest);
// "unknown" answers "?" to every command after the first one in a write.
function makeAdapter(mode) {
  const ad = { writes: 0, cmds: 0, header: "7DF", cra: "", onData: null, log: [] };
  const replyFor = (c) => {
    ad.cmds++;
    if (c.startsWith("ATSH")) { ad.header = c.slice(4); return "OK"; }
    if (c.startsWith("ATCRA")) { ad.cra = c.slice(5); return "OK"; }
    if (c.startsWith("AT")) return "OK";
    const want = { "7E0": "7E8", "761": "762", "755": "756" }[ad.header];
    if (!want || ad.cra !== want) return "NO DATA";
    if (c === "010D" || c === "010D1") return "41 0D 32";
    if (c === "010C" || c === "010C1") return "41 0C 0F A0";
    if (c === "2101") return "03F\r0: 61 01 11 22 33 44\r1: 55 66 77 88 99 AA BB";
    return "NO DATA";
  };
  ad.write = (s) => {
    ad.writes++;
    const cmds = s.split("\r").filter((x) => x.length);
    ad.log.push(cmds.join("|"));
    const run = mode === "first" ? cmds.slice(0, 1) : cmds;
    setTimeout(() => {
      run.forEach((c, i) => {
        const out = mode === "unknown" && i > 0 ? "?" : replyFor(c);
        ad.onData(out + "\r\r>");
      });
    }, 1);
    return true;
  };
  return ad;
}

async function drive(mode) {
  const ad = makeAdapter(mode);
  const e = new Elm(ad, () => {});
  const out = [];
  for (let n = 0; n < 6; n++) {
    out.push(await e.request("7E0", "7E8", "010D", 300).catch(() => "ERR"));
    out.push(await e.request("7E0", "7E8", "010C", 300).catch(() => "ERR"));
    out.push(await e.request("761", "762", "2101", 300).catch(() => "ERR"));
    out.push(await e.request("755", "756", "2101", 300).catch(() => "ERR"));
  }
  return { ad, e, out };
}

test("batched set-up returns the same data as one command at a time, in fewer writes", async () => {
  const good = await drive("good");
  assert.ok(good.e.batch, "batching stays on with a well-behaved adapter");
  assert.ok(good.out.every((x) => x && x !== "ERR"), JSON.stringify(good.out));
  assert.ok(good.ad.log.some((l) => l.includes("ATSH761|ATFCSH761")), good.ad.log.join(" / "));
  const seq = await (async () => {
    const ad = makeAdapter("good");
    const e = new Elm(ad, () => {});
    e.batch = false;
    for (let n = 0; n < 6; n++) {
      await e.request("7E0", "7E8", "010D", 300); await e.request("7E0", "7E8", "010C", 300);
      await e.request("761", "762", "2101", 300); await e.request("755", "756", "2101", 300);
    }
    return ad;
  })();
  assert.ok(good.ad.writes < seq.writes, good.ad.writes + " vs " + seq.writes);
  assert.strictEqual(good.ad.cmds, seq.cmds, "same commands reach the adapter");
});

test("an adapter that drops the extra commands is detected and batching turns off", async () => {
  const r = await drive("first");
  assert.strictEqual(r.e.batch, false);
  const last = r.out.slice(-4);
  assert.ok(last.every((x) => x && x !== "ERR"), "later requests work one command at a time: " + JSON.stringify(last));
});

test("an adapter that answers ? to the extra commands is detected", async () => {
  const r = await drive("unknown");
  assert.strictEqual(r.e.batch, false);
  const last = r.out.slice(-4);
  assert.ok(last.every((x) => x && x !== "ERR"), JSON.stringify(last));
});
