#!/usr/bin/env bash
# Repository checks run by CI (and locally): forbidden files, secrets, version consistency, required docs, JS syntax.
set -u
cd "$(dirname "$0")/.."
fail=0; err() { echo "FAIL: $*"; fail=1; }

# 1. forbidden files (keys, binaries, logs)
bad=$(git ls-files | grep -iE '\.(jks|keystore|p12|pfx|pem|key|apk|aab|idsig)$|(^|/)(\.env|local\.properties)$|(^|/)OutyDS-(log|capture)-' || true)
[ -z "$bad" ] || err "forbidden files tracked: $bad"
bad=$(git ls-files | grep -iE '\.csv$' | grep -v '^data/downloads\.csv$' || true)
[ -z "$bad" ] || err "unexpected CSV files (vehicle logs?): $bad"

# 2. secrets / personal data patterns
pat='BEGIN (RSA |EC |OPENSSH |)PRIVATE KEY|ghp_[A-Za-z0-9]{30,}|github_pat_[A-Za-z0-9_]{30,}|AKIA[0-9A-Z]{16}|xox[baprs]-[A-Za-z0-9-]{10,}|(ksPass|storepass|KS_PASS)=[^ $"\x27.]+'
hits=$(git grep -nIE "$pat" -- . ':!scripts/check-repo.sh' ':!.github' || true)
[ -z "$hits" ] || err "possible secrets: $hits"
vin=$(git grep -nIE '\b[A-HJ-NPR-Z0-9]{17}\b' -- ':!LICENSE' ':!*.smali' ':!app/assets/obdb.js' ':!app/assets/i18n.js' ':!app/assets/app.js' ':!app/res' ':!*.md' ':!app/apktool.yml' | grep -E '\b[A-HJ-NPR-Z0-9]{17}\b' | grep -E '[0-9]' | grep -E '[A-HJ-NPR-Z]' || true)
[ -z "$vin" ] || err "possible VIN in source: $vin"

# 3. versions must agree: apktool.yml, update.js, CHANGELOG, app text
v_yml=$(sed -n 's/^  versionName: *//p' app/apktool.yml | tr -d "'\" ")
v_js=$(sed -n 's/.*var VERSION = "\([^"]*\)".*/\1/p' app/assets/update.js)
v_log=$(sed -n 's/^## *\([0-9][0-9.]*\).*/\1/p' CHANGELOG.md | head -1)
v_i18n=$(grep -o 'about:\["OutyDS [0-9.]*' app/assets/i18n.js | grep -o '[0-9.]*$')
v_vc=$(sed -n 's/^  versionCode: *//p' app/apktool.yml | tr -d "'\" ")
case "$v_vc" in ''|*[!0-9]*) err "versionCode in apktool.yml is not a number: '$v_vc'" ;; esac
echo "versions: apktool.yml=$v_yml update.js=$v_js changelog=$v_log about=$v_i18n"
for v in "$v_js" "$v_log" "$v_i18n"; do [ "$v" = "$v_yml" ] || err "version mismatch ($v vs $v_yml)"; done

# 4. required documents
for f in LICENSE THIRD_PARTY_NOTICES.md SECURITY.md PRIVACY.md CHANGELOG.md BUILDING.md SOURCE_STATUS.md readme.md build.sh; do [ -f "$f" ] || err "missing $f"; done
grep -q 'GNU GENERAL PUBLIC LICENSE' LICENSE && grep -q 'Version 3' LICENSE || err "LICENSE is not GPLv3"
grep -qi 'phev2mqtt' THIRD_PARTY_NOTICES.md && grep -qi 'OBDb' THIRD_PARTY_NOTICES.md || err "third-party notices incomplete"
! grep -rniE 'MIT licen[cs]e|, MIT\)' app/assets/phev-engine.js THIRD_PARTY_NOTICES.md || err "phev2mqtt must not be described as MIT"

# 5. JS syntax and unit tests
for f in app/assets/*.js; do node --check "$f" || err "syntax error in $f"; done
node scripts/check-docs.js || err "documentation/text consistency check failed"
node --test tests/*.test.js || err "unit tests failed"
if command -v javac >/dev/null 2>&1; then
  d=$(mktemp -d)
  javac -d "$d" tests/native/RxBufferTest.java && java -cp "$d" RxBufferTest || err "native framing reference test failed"
else
  echo "javac not found: native framing reference test skipped"
fi

[ "$fail" = 0 ] && echo "All repository checks passed." || { echo "Checks failed."; exit 1; }
