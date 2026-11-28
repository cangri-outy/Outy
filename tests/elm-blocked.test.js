"use strict";
const test = require("node:test");
const assert = require("node:assert");
const fs = require("node:fs");
const path = require("node:path");
const vm = require("node:vm");

const src = fs.readFileSync(path.join(__dirname, "../app/assets/elm.js"), "utf8");
const win = {};
vm.runInNewContext(src, { window: win, console, setTimeout, clearTimeout, Date });
const Elm = win.OutyElm.Elm;

test("read-only services are allowed without the write flag", () => {
  for (const c of ["010C", "0902", "03", "07", "0A", "2101", "220E25", "1902FF", "ATZ", "ATSH7DF"]) {
    assert.strictEqual(Elm.blocked(c), null, c);
  }
});

test("clear-fault commands need the internal write flag", () => {
  for (const c of ["04", "14FFFFFF"]) {
    assert.ok(Elm.blocked(c), c + " must be refused from the console path");
    assert.strictEqual(Elm.blocked(c, undefined, true), null, c + " allowed with write flag");
  }
});

test("other write services stay refused even with the write flag", () => {
  for (const c of ["2E0101", "3101", "1003", "1101", "2F0101", "2701", "04FF", "14FFFF00"]) {
    assert.ok(Elm.blocked(c, undefined, true), c);
  }
});

test("adapter reprogramming and bad characters are refused", () => {
  for (const c of ["ATPP01", "ATBR1", "ATMA", "01 0C;", "ZZ", ""]) {
    assert.ok(Elm.blocked(c), JSON.stringify(c));
  }
});
