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
// 7. source-availability wording: v.1.95 has no application source at its tag, so no document may say
//    that every / each release tag contains the source of its APK.
const sourceClaim = /(every|each) (release )?tag[^.]{0,80}(contains?|points at)[^.]{0,80}source/i;
for (const f of docs) {
  if (f === "CHANGELOG.md") continue;
  rd(f).split("\n").forEach((l, i) => {
    if (sourceClaim.test(l) && !/v\.1\.95/.test(l)) err(f + ":" + (i + 1) + " generic claim that release tags contain the APK source (not true for v.1.95)");
  });
}

// 8. the CHANGELOG marks a release as published with its tag; SOURCE_STATUS.md must then list that tag
const published = [...rd("CHANGELOG.md").matchAll(/^## [\d.]+ \(published as (v\.[\d.]+)/gm)].map((m) => m[1]);
for (const t of published) if (!rd("SOURCE_STATUS.md").includes("`" + t + "`")) err("SOURCE_STATUS.md does not list the tag " + t + " that CHANGELOG.md marks as published");
const tagDate = rd("SOURCE_STATUS.md").match(/Tag status \(checked (\d{4}-\d\d-\d\d)/);
if (!tagDate) err("SOURCE_STATUS.md has no 'Tag status (checked YYYY-MM-DD' line");
else if (new Date(tagDate[1] + "T00:00:00Z") > new Date()) err("SOURCE_STATUS.md tag-status date " + tagDate[1] + " is in the future");

// 9. version statements in the documents must equal the project version
for (const f of docs) {
  if (f === "CHANGELOG.md") continue;
  rd(f).split("\n").forEach((l, i) => {
    for (const m of l.matchAll(/(?:Project version: \*\*|(?:repository|project) files (?:in the repository )?are version |versionName )`?(\d+(?:\.\d+)*)/g)) {
      if (m[1] !== ver) err(f + ":" + (i + 1) + " states version " + m[1] + " but app/apktool.yml has " + ver);
    }
  });
}

// 10. release asset naming must agree between build.sh, BUILDING.md, the release report and the updater
if (!rd("build.sh").includes('OutyDS_${V1}.apk')) err("build.sh no longer names the output OutyDS_<version>.apk");
for (const f of ["build.sh", "BUILDING.md", "app/assets/update.js", ".github/workflows/release-report.yml"]) {
  if (!rd(f).includes("SHA256SUMS")) err(f + " does not mention the SHA256SUMS release asset");
}
for (const m of rd("BUILDING.md").matchAll(/dist\/OutyDS_([\d.]+)\.apk/g)) if (m[1] !== ver) err("BUILDING.md example APK name has version " + m[1] + " but the project is " + ver);

// 11. release tags are written v.X.YY in the documents (not vX.YY)
for (const f of docs) {
  if (f === "CHANGELOG.md") continue;
  rd(f).split("\n").forEach((l, i) => { if (/\bv\d+\.\d+/.test(l.replace(/https?:\/\/\S+/g, ""))) err(f + ":" + (i + 1) + " tag written as vX.YY; the project's tags are v.X.YY"); });
}

// 12. files referenced in backticks must exist: paths containing "/" (relative to the repository root, app/ or
//     .github/workflows) and documentation file names (*.md) outside lines that talk about tags
const exists = (r) => [".", "app", "app/assets", ".github/workflows"].some((b) => fs.existsSync(path.join(root, b, r)));
for (const f of docs) {
  if (f === "CHANGELOG.md") continue; // history
  rd(f).split("\n").forEach((l, i) => {
    for (const m of l.matchAll(/`([A-Za-z0-9_.\/-]+)`/g)) {
      const ref = m[1];
      const isPath = ref.includes("/") && /^(app|scripts|tests|data|\.github)\//.test(ref);
      const isDoc = /^[A-Z][A-Z_]*\.md$/.test(ref) && !/tag/i.test(l);
      if ((isPath || isDoc) && !exists(ref)) err(f + ":" + (i + 1) + " mentions `" + ref + "` which does not exist in the repository");
    }
  });
}

// 13. compatibility claim: model-year range must be the same everywhere it is stated
const yearSrc = { "readme.md": rd("readme.md"), "FAQ.md": rd("FAQ.md"), "i18n.js (About)": (i18n.match(/about:\[[^\]]*\]/) || [""])[0] };
for (const [f, t] of Object.entries(yearSrc)) {
  for (const m of t.matchAll(/(20\d\d)(?:–|\\u2013|-)(20\d\d)/g)) if (m[1] !== "2013" || m[2] !== "2018") err(f + " states model years " + m[0] + "; the targeted range is 2013–2018");
}

// 14. naming: OutyDS is the application, Outy the repository
for (const f of docs) {
  rd(f).split("\n").forEach((l, i) => { if (/OutyDS (repository|repo)\b|\bOuty (app|application)\b/i.test(l)) err(f + ":" + (i + 1) + " naming: use 'OutyDS' for the application and 'Outy' for the repository"); });
}

if (errors) { console.log(errors + " problem(s)"); process.exit(1); }
console.log("docs/text checks passed (version " + ver + ", " + Object.keys(table).length + " translations)");
