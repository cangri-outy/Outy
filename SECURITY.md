# Security policy

OutyDS is free and open-source software distributed under GNU GPL-3.0. Donations are voluntary and help support continued development. Support is provided on a best-effort basis, without guaranteed response times, fixes, updates or compatibility.

## Reporting a vulnerability
Security reports are handled on a **best-effort** basis. There is **no guaranteed response time** and **no promise that every report will receive a fix**.

- Please do **not** post vulnerability details in a public issue.
- GitHub's private vulnerability reporting was **not enabled** when last checked (2026-11-25). If the *Security* tab offers "Report a vulnerability", use it. Otherwise open a public issue that says only "security contact please", with no details, and the maintainer may arrange a private channel.
- Useful details: OutyDS version, Android version, steps to reproduce and impact.

## Supported versions
Only the latest published release (see the [Releases page](https://github.com/cangri-outy/Outy/releases)) is considered. The repository files are version 1.97.

## Vehicle communication scope
- The OBD part (Bluetooth or WiFi adapter) is intended for reading vehicle data. Manually typed console commands are filtered to read-only diagnostic services; the console cannot send the clear-fault commands. The only write-type operation is clearing fault codes, which the user starts from the diagnostics screens with a confirmation. It is refused above 5 km/h and also when the current speed is unknown or out of date.
- The Remote tab sends commands to the car over its own WiFi: climate control (including cancelling pre-heating), headlights and parking lights, and cancelling the charge timer.
- **Scheduled pre-heating can run automatically.** Once the user has configured and enabled it, the app starts the climate command at the planned time without asking for a further confirmation.

## Updates and signing
- APK updates are installed through Android's installer, which asks the user to confirm.
- Android only accepts an update signed with the **same signing certificate** and package name as the installed app. Releases are signed with a private key kept by the maintainer; the key is not in this repository.
- Verify downloads with the `SHA256SUMS` file attached to a release, when one is present.

## What has been reviewed
These points describe the **project files and the published v.1.97**. The older v.1.96 and v.1.95 do not include all of them.

- From 1.97, the in-app updater downloads the release's `SHA256SUMS` first (an update is refused if the release has none), then the APK into the app's private folder. Before the installer opens it checks the APK's SHA-256 against `SHA256SUMS`, the package name, a higher versionCode and the same signing certificate as the installed app. A failed check deletes the download. The checksum file comes from the same release as the APK, so it detects damaged or mismatched downloads but not a compromised release; the certificate check covers that case.
- From 1.97, `index.html` and `remote.html` carry a Content-Security-Policy (scripts only from the bundled files, network only to api.github.com and api.open-meteo.com). Checked in desktop Chromium, not in Android WebView.
- The WebView navigates only within the bundled pages, and the native bridge only opens `https://` links and only downloads updates from `https://github.com/`.
- Messages between the app's pages are checked for the expected source frame.
- Some dynamic values shown in the interface are escaped. **No blanket guarantee is made** that every dynamic value in every code path is escaped.

## Known limitations
- The car's WiFi password is stored unencrypted in the app's private storage (backup disabled).
- The WebView has access to the app's own bundled pages only (file access is disabled), but it exposes native bridge objects to those pages, so a flaw that lets foreign content run in them would reach the bridge.
- The Remote link to the car uses the car's own protocol on its private WiFi.
- The repository is an Apktool project with decompiled Smali and some minified JavaScript (see [SOURCE_STATUS.md](SOURCE_STATUS.md)), which makes independent review harder.
