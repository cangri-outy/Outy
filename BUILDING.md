# Building OutyDS

OutyDS is free and open-source software distributed under GNU GPL-3.0. Donations are voluntary and help support continued development. Support is provided on a best-effort basis, without guaranteed response times, fixes, updates or compatibility.

## What this repository is
An **Apktool project** (`app/`): `AndroidManifest.xml`, `apktool.yml`, decompiled **Smali** (`app/smali/`), WebView application files (`app/assets/`) and Android resources (`app/res/`). There is **no original Java/Kotlin source tree**. See [SOURCE_STATUS.md](SOURCE_STATUS.md).

## Project facts
- Package name: `ro.outyds.app`
- Project version: `versionName 1.96`, `versionCode 100` (`app/apktool.yml`)
- Version status (checked 2026-11-24): the project files in this repository are version **1.96**. The latest **published** GitHub Release is **v.1.95** (`OutyDS_1.95.apk`). Version 1.96 has not been released yet.

## Requirements
Java 11+ and `curl`. `build.sh` downloads and checks the tools:

| Tool | Version | SHA-256 |
|---|---|---|
| Apktool | 2.10.0 | `c0350abbab5314248dfe2ee0c907def4edd14f6faef1f5d372d3d4abd28f0431` |
| uber-apk-signer | 1.3.0 | `e1299fd6fcf4da527dd53735b56127e8ea922a321128123b9c32d619bba1d835` |

The script stops if a checksum does not match. It also stops if the version in `app/apktool.yml` and `app/assets/update.js` differ.

## Build
```
KS=/path/outyds.jks KS_ALIAS=outyds KS_PASS=... ./build.sh
```
Output: `dist/OutyDS_<version>.apk` (e.g. `dist/OutyDS_1.96.apk`). The script also writes **`dist/SHA256SUMS`** locally (`sha256sum` of the APK). It is generated on your machine and is not stored in the repository.

## Release checksum
When a release is published, attach `SHA256SUMS` to the **GitHub Release** next to the APK. The file refers to the APK by its file name, so the checksum is only valid if the APK keeps the name it had when the file was generated (rename before generating, or regenerate).

## Signing key and updates
- **Never commit the keystore.**
- Android only installs an update over an existing installation if the APK has the same package name and is signed with the **same original signing key**.
- **A newly generated signing key cannot update an existing installation.** Users would have to uninstall first, which deletes the app's data.
- The signing certificate of the published v.1.95 APK has SHA-256 `b78b45c953b03302d941797170215f6a9f45b1c46c5a923cc2c28de0a241c372` (checked 2026-11-24). An APK built with the maintainer's current key shows the same certificate, so it can update v.1.95. If that key is ever lost, no update can be installed over existing installations. The release-report workflow checks this fingerprint.
- Builds are not bit-for-bit reproducible (signing adds timestamps).

## In-app updates
OutyDS checks `https://api.github.com/repos/<owner>/<repo>/releases/latest` (Settings > Updates; default repository `cangri-outy/Outy`). To publish an update: bump `versionCode`/`versionName` in `app/apktool.yml` and `VERSION` in `app/assets/update.js`, build, sign with the same keystore, then create a GitHub Release tagged like `v.X.YY` with the signed `.apk` and `SHA256SUMS` attached. Public repositories only.

## Notes
- Internal storage keys stay `outy.*` for compatibility with existing exports.
- License: GPL-3.0 (`LICENSE`). Third-party notices: [THIRD_PARTY_NOTICES.md](THIRD_PARTY_NOTICES.md).
- Unofficial, not affiliated with Mitsubishi Motors.
