#!/usr/bin/env bash
# Build + sign OutyDS. Needs: java 11+, curl.
# Usage: KS=/path/outyds.jks KS_ALIAS=outyds KS_PASS=... ./build.sh
set -euo pipefail
cd "$(dirname "$0")"
: "${KS:?path to keystore}"; : "${KS_ALIAS:?}"; : "${KS_PASS:?}"
mkdir -p tools dist
APKTOOL_SHA256=c0350abbab5314248dfe2ee0c907def4edd14f6faef1f5d372d3d4abd28f0431
SIGNER_SHA256=e1299fd6fcf4da527dd53735b56127e8ea922a321128123b9c32d619bba1d835
[ -f tools/apktool.jar ] || curl -sSL -o tools/apktool.jar https://github.com/iBotPeaches/Apktool/releases/download/v2.10.0/apktool_2.10.0.jar
[ -f tools/uber-apk-signer.jar ] || curl -sSL -o tools/uber-apk-signer.jar https://github.com/patrickfav/uber-apk-signer/releases/download/v1.3.0/uber-apk-signer-1.3.0.jar
echo "$APKTOOL_SHA256  tools/apktool.jar" | sha256sum -c -
echo "$SIGNER_SHA256  tools/uber-apk-signer.jar" | sha256sum -c -
V1=$(sed -n 's/^  versionName: *//p' app/apktool.yml | tr -d "'\" ")
V2=$(sed -n 's/.*var VERSION = "\([^"]*\)".*/\1/p' app/assets/update.js)
[ "$V1" = "$V2" ] || { echo "Version mismatch: apktool.yml=$V1 update.js=$V2"; exit 1; }
VC=$(sed -n 's/^  versionCode: *//p' app/apktool.yml | tr -d "'\" ")
case "$VC" in ''|*[!0-9]*) echo "versionCode in apktool.yml is missing or not a number: '$VC'"; exit 1 ;; esac
java -jar tools/apktool.jar b -o dist/unsigned.apk app
java -jar tools/uber-apk-signer.jar -a dist/unsigned.apk --ks "$KS" --ksAlias "$KS_ALIAS" --ksPass "$KS_PASS" --ksKeyPass "$KS_PASS" -o dist/signed
APK="OutyDS_${V1}.apk"
cp dist/signed/unsigned-aligned-signed.apk "dist/$APK"
# checksum is generated only after the final release filename is chosen
(cd dist && sha256sum "$APK" > SHA256SUMS)
echo "OK -> dist/$APK (version $V1, versionCode $VC), checksum in dist/SHA256SUMS"
