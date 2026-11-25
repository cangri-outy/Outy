#!/usr/bin/env node
// Documentation / text consistency checks. No dependencies.
const fs = require("fs"), path = require("path");
const root = path.join(__dirname, "..");
const rd = (p) => fs.readFileSync(path.join(root, p), "utf8");
let errors = 0;
const err = (m) => { console.log("ERROR: " + m); errors++; };

// 1. single source of truth for the version: app/apktool.yml
const ver = (rd("app/apktool.yml").match(/^\s*versionName:\s*['"]?([\d.]+)/m) || [])[1];
if (!ver) err("versionName not found in app/apktool.yml");

// 2. version in update.js and in the About text (i18n.js + index.html fallback)
if (!rd("app/assets/update.js").includes('VERSION = "' + ver + '"')) err("update.js VERSION differs from " + ver);
const i18n = rd("app/assets/i18n.js");
const about = i18n.match(/about:\["OutyDS ([\d.]+)/);
if (!about || about[1] !== ver) err("About text (i18n.js) version differs from " + ver);
if (!rd("app/assets/index.html").includes(">OutyDS " + ver + " ")) err("About fallback text (index.html) version differs from " + ver);

// 3. translations: every entry has non-empty RO and EN, every data-i18n key exists
const body = i18n.slice(i18n.indexOf("const o={") + 8);
let depth = 0, end = 0;
for (let i = 0; i < body.length; i++) { if (body[i] === "{") depth++; else if (body[i] === "}" && --depth === 0) { end = i; break; } }
let table;
try { table = new Function("return " + body.slice(0, end + 1))(); } catch (e) { err("cannot parse i18n table: " + e.message); table = {}; }
for (const [k, v] of Object.entries(table)) {
  if (!Array.isArray(v) || v.length !== 2 || !v[0] || !v[1]) err("i18n key '" + k + "' needs a non-empty [RO, EN] pair");
  else if (/[şţŞŢ]/.test(v[0])) err("i18n key '" + k + "' uses cedilla letters; use comma-below ș/ț");
}
const html = rd("app/assets/index.html");
for (const m of html.matchAll(/data-i18n(?:-[a-z]+)?="([^"]+)"/g)) if (!table[m[1]]) err("index.html uses missing i18n key '" + m[1] + "'");

// 4. documentation must not contain release-status statements that go stale
const docs = fs.readdirSync(root).filter((f) => f.endsWith(".md"));
const stale = /not yet (been )?(released|published)|(has|have) not (yet )?been (released|published)|(1\.9\d|release|tag)[^.]{0,40}unreleased|the unreleased \d|latest published (github )?release (is|at)|still needs to be (created|published)/i;
for (const f of docs) {
  if (f === "CHANGELOG.md") continue; // history
  rd(f).split("\n").forEach((l, i) => { if (stale.test(l)) err(f + ":" + (i + 1) + " release-status wording that can go stale: " + l.trim().slice(0, 80)); });
}

// 5. spelling used consistently in the docs
for (const f of docs) if (/Wi-Fi/.test(rd(f))) err(f + " uses 'Wi-Fi'; the project writes 'WiFi'");

// 6. relative Markdown links must point to existing files
for (const f of docs) {
  for (const m of rd(f).matchAll(/\]\((?!https?:|mailto:|#)([^)#\s]+)(#[^)]*)?\)/g)) {
    if (!fs.existsSync(path.join(root, m[1]))) err(f + " links to missing file " + m[1]);
  }
}
if (errors) { console.log(errors + " problem(s)"); process.exit(1); }
console.log("docs/text checks passed (version " + ver + ", " + Object.keys(table).length + " translations)");
