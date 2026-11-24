# Source status and known limitations

## What the repository contains
- `app/` is an **apktool project** (smali, resources, manifest, assets). `./build.sh` rebuilds the APK from it. On 2026-11-24 an APK built with `build.sh` was decoded and compared with `app/`: assets, resources and manifest were identical and the smali re-assembled to the identical `classes.dex`. This only shows that the APK matches these files; it does not establish GPL compliance.
- There is **no original Java/Kotlin source**. The app's native part exists in this repository only as smali.

## Minified JavaScript (important)
These files are minified and have no readable original in this repository: `app/assets/app.js`, `elm.js`, `data.js`, `i18n.js` (plus `obdb.js`, which is data). They are what the app runs and what is edited today, but they are hard to read. Readable, commented sources for them are **not available here**. GPLv3 defines source as the preferred form for making modifications, so this is a known gap. Readable files: `phev-engine.js`, `phev-ui.js`, `update.js`, `remote-*.js`, `index.html`, `style.css`.

## Other limits
- Built APKs are not bit-for-bit reproducible (signing adds timestamps). Use `SHA256SUMS` from the release.
- The 1.96 changes (WiFi OBD adapter, new tyre-pressure decoding, charge statistics, regrouped pages) were tested only in a browser mock. Logs from the maintainer's car were used to analyse tyre pressure and connection problems, but no real-car or real-adapter verification of these changes is documented. Other model years are untested.
- WiFi OBD dongle, tyre-pressure (TPMS) and the Remote tab depend on the car/adapter and may not work on every vehicle.

## Unresolved GPL question
Whether this repository satisfies the GPL-3.0 Corresponding Source requirements (preferred form for making modifications, given the missing Java/Kotlin source and the minified JavaScript) is **unresolved**. It has not been legally established.

Tag status (checked 2026-11-24 through the GitHub API): the tag `v.1.95` points to commit `f50b348`, whose tree contains only `README.md` and `readme.md`. The published `OutyDS_1.95.apk` therefore has **no corresponding application source at its tag**. Source for 1.96 is on `main`; a `v.1.96` tag/release should be created from a commit that contains the exact source of the attached APK. This is an open GPL source-availability gap for v.1.95 that cannot be fixed without changing the tag or publishing the source that matches that APK.

Version status (checked 2026-11-24): the project files in this repository are version **1.96**. The latest **published** GitHub Release is **v.1.95** (`OutyDS_1.95.apk`). Version 1.96 has not been released yet.
