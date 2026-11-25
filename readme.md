# Outy – Mitsubishi Outlander PHEV

Outy is an Android application designed for the Mitsubishi Outlander PHEV.

Monitor vehicle information, access diagnostic features and explore data from your vehicle using a compatible Bluetooth OBD-II adapter (1.96 also supports WiFi OBD adapters; this is not yet verified with a real adapter).

## 📥 Download Outy

**[Download the latest OutyDS APK](https://github.com/cangri-outy/Outy/releases/latest)**

Always download the latest version from the official OutyDS GitHub Releases page.

## 📱 Installation

1. Open the [latest release page](https://github.com/cangri-outy/Outy/releases/latest).
2. Find the **Assets** section.
3. Download the `OutyDS_x.xx.apk` file.
4. Open the downloaded APK on your Android phone.
5. If Android asks, allow installation from this source.
6. Follow the Android installation instructions.
7. Open OutyDS.

For detailed instructions, visit the [Installation Wiki](https://github.com/cangri-outy/Outy/wiki/Installation).

## 🔄 Updating Outy

OutyDS supports an integrated update checker that connects to GitHub.

To check for updates:

1. Open OutyDS.
2. Navigate to **Settings → Updates**.
3. Configure the repository as:

   `cangri-outy/Outy`

4. Enable update checking at startup, if available.
5. Tap **Check now** to check manually.

When a newer version is available, follow the update instructions displayed by the application.

Android requires user approval to install APK updates. OutyDS cannot silently install updates without special system privileges.

**Important:** Install updates over your existing OutyDS installation. Do not uninstall the previous version.

For more information, see the [Automatic Updates Wiki](https://github.com/cangri-outy/Outy/wiki/Automatic-Updates).

## 🔐 Application Compatibility

OutyDS updates must meet the following requirements:

- Retain the same application package name.
- Be signed with the original application signing certificate.

## 📄 License, source and version

OutyDS is free and open-source software distributed under GNU GPL-3.0. Donations are voluntary and help support continued development. Support is provided on a best-effort basis, without guaranteed response times, fixes, updates or compatibility.

- **License:** GNU GPL-3.0 (see `LICENSE`).
- **What the repository contains:** an [Apktool](https://apktool.org) project in `app/`: `AndroidManifest.xml`, `apktool.yml`, decompiled **Smali** files (`app/smali/`), the WebView application files (`app/assets/`) and Android resources (`app/res/`), plus `build.sh`. It does **not** contain an original Java/Kotlin source tree, and some JavaScript files are minified. Details: [SOURCE_STATUS.md](SOURCE_STATUS.md).
- **GPL Corresponding Source:** whether this repository fully satisfies the GPL Corresponding Source requirements is an **unresolved question**; it has not been legally established.
- **Third-party components:** [THIRD_PARTY_NOTICES.md](THIRD_PARTY_NOTICES.md). **Build instructions:** [BUILDING.md](BUILDING.md).
- Version status (checked 2026-11-24): the project files in this repository are version **1.96**. The latest **published** GitHub Release is **v.1.96** (`OutyDS_1.96.apk`, published 2026-11-24; its tag `v.1.96` points to commit `5b24a27`, which contains the exact source of that APK; the release APK's SHA-256 was checked to equal the build from that source). The previous release is v.1.95.

## ❤️ Donations and support

- Donations are voluntary and do not unlock features or priority support. See [DONATIONS.md](DONATIONS.md).
- Support is best effort, with no guaranteed response time. See [SUPPORT.md](SUPPORT.md) and the [FAQ](FAQ.md).
- Privacy: [PRIVACY.md](PRIVACY.md). Security: [SECURITY.md](SECURITY.md).

## ⚠️ Disclaimer

Outy / OutyDS is an unofficial community project, not affiliated with or endorsed by Mitsubishi Motors. It is provided **without any warranty**, under the GNU GPL v3. Use at your own risk: commands sent to the vehicle (climate, lights, charging) and any write operation are your responsibility. Do not use the app while driving in a way that distracts you.
