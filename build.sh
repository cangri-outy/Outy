#!/usr/bin/env bash
# Build + sign OutyDS. Needs: java 11+, curl.
# Usage: KS=/path/outyds.jks KS_ALIAS=outyds KS_PASS=... ./build.sh
set -euo pipefail
cd "$(dirname "$0")"
: "${KS:?path to keystore}"; : "${KS_ALIAS:?}"; : "${KS_PASS:?}"
mkdir -p tools dist
[ -f tools/apktool.jar ] || curl -sSL -o tools/apktool.jar https://github.com/iBotPeaches/Apktool/releases/download/v2.10.0/apktool_2.10.0.jar
[ -f tools/uber-apk-signer.jar ] || curl -sSL -o tools/uber-apk-signer.jar https://github.com/patrickfav/uber-apk-signer/releases/download/v1.3.0/uber-apk-signer-1.3.0.jar
java -jar tools/apktool.jar b -o dist/unsigned.apk app
java -jar tools/uber-apk-signer.jar -a dist/unsigned.apk --ks "$KS" --ksAlias "$KS_ALIAS" --ksPass "$KS_PASS" --ksKeyPass "$KS_PASS" -o dist/signed
cp dist/signed/unsigned-aligned-signed.apk dist/OutyDS.apk
echo "OK -> dist/OutyDS.apk"
