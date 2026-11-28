# Source status and known limitations

## What the repository contains
- `app/` is an **apktool project** (smali, resources, manifest, assets). `./build.sh` rebuilds the APK from it. On 2026-11-24 an APK built with `build.sh` was decoded and compared with `app/`: assets, resources and manifest were identical and the smali re-assembled to the identical `classes.dex`. This only shows that the APK matches these files; it does not establish GPL compliance.
- There is **no original Java/Kotlin source**. The app's native part exists in this repository only as smali.

## Where the code comes from (as stated by the maintainer)
- **OBD part:** written from scratch for this project directly in the files of this repository (smali, JavaScript, HTML). No separate original Java/Kotlin or Gradle project exists for it; these repository files are the form it is edited in.
- **WiFi / Remote part:** derived from phev2mqtt by buxtronix (GPL-3.0). The original upstream source is at https://github.com/buxtronix/phev2mqtt. See `THIRD_PARTY_NOTICES.md` for which files are derived from it.

## Minified JavaScript (important)
These files are minified and have no readable original in this repository: `app/assets/app.js`, `elm.js`, `data.js`, `i18n.js` (plus `obdb.js`, which is data). They are what the app runs and what is edited today, but they are hard to read. Readable, commented sources for them are **not available here**. GPLv3 defines source as the preferred form for making modifications, so this is a known gap. Readable files: `phev-engine.js`, `phev-ui.js`, `update.js`, `remote-*.js`, `index.html`, `style.css`.

## Other limits
- Built APKs are not bit-for-bit reproducible (signing adds timestamps). Use `SHA256SUMS` from the release.
- The 1.96 changes (WiFi OBD adapter, new tyre-pressure decoding, charge statistics, regrouped pages) were tested only in a browser mock. Logs from the maintainer's car were used to analyse tyre pressure and connection problems, but no real-car or real-adapter verification of these changes is documented. The 1.97 changes were checked with unit tests, a browser mock and a simulated adapter; the native (smali) changes were only assembled, not run on Android, and the batched adapter set-up was not tried on a real adapter. Other model years are untested.
- WiFi OBD dongle, tyre-pressure (TPMS) and the Remote tab depend on the car/adapter and may not work on every vehicle.

## Unresolved GPL question
Whether this repository satisfies the GPL-3.0 Corresponding Source requirements (preferred form for making modifications, given the missing Java/Kotlin source and the minified JavaScript) is **unresolved**. It has not been legally established.

Tag status (checked 2026-11-28: tags fetched from GitHub and their trees listed with git, release assets listed through the GitHub API): the tag `v.1.95` points to commit `f50b348`, whose tree contains only `README.md` and `readme.md`. The published `OutyDS_1.95.apk` therefore has **no corresponding application source at its tag** (open GPL source-availability gap for v.1.95, not fixable without changing that tag or publishing matching source). The tag `v.1.96` points to commit `5b24a27`, which contains the Apktool project, build script and licence of the published `OutyDS_1.96.apk`. The tag `v.1.97` points to commit `d56f80a`, which contains the Apktool project, build script and licence of the published `OutyDS_1.97.apk`. This does not settle the Corresponding Source question described above.

Project version: **1.97** (`app/apktool.yml`). The current release is the one shown on the [Releases page](https://github.com/cangri-outy/Outy/releases); the tags `v.1.96` and `v.1.97` point at commits that contain the Apktool project of the corresponding APK (checked 2026-11-28), but the tag `v.1.95` does **not** contain the source of its APK (documented source-availability gap, see [SOURCE_STATUS.md](SOURCE_STATUS.md)). Release status is not otherwise repeated in this file so that it cannot become outdated.
