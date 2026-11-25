# OutyDS – Mitsubishi Outlander PHEV

OutyDS is an Android application for the Mitsubishi Outlander PHEV (repository name: Outy).

Monitor vehicle information, access diagnostic features and explore data from your vehicle using a compatible Bluetooth OBD-II adapter (1.96 also supports WiFi OBD adapters; this is not yet verified with a real adapter).

## 📥 Download OutyDS

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

## 🔄 Updating OutyDS

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

## 🚗 Vehicle compatibility

- OutyDS is intended for the Mitsubishi Outlander PHEV. The model years it is aimed at are **2013–2018** (the maintainer's target, also shown on the About screen). This range has **not** been verified on every model year.
- **What has been checked on a real vehicle:** logs from **one 2016 Outlander PHEV**, read with a Bluetooth OBD adapter, were used to analyse battery, tyre-pressure and connection behaviour. Nothing else has been tested on a real vehicle by the maintainer.
- **Not verified on a real vehicle:** WiFi OBD adapter connection, the Remote tab (climate, lights, charge timer, scheduled pre-heating), the 1.96 tyre-pressure decoding and the 1.96 trip and charge statistics. An earlier report said interactive heating/cooling commands in the Remote tab did not work; that has not been resolved or re-tested.
- **Experimental:** signals for 2021 and newer models (Settings, off by default).
- No claim is made that every function works on every model or phone.

## 🔐 Update compatibility

OutyDS updates must meet the following requirements:

- Retain the same application package name.
- Be signed with the original application signing certificate.

## 📄 License, source and version

OutyDS is free and open-source software distributed under GNU GPL-3.0. Donations are voluntary and help support continued development. Support is provided on a best-effort basis, without guaranteed response times, fixes, updates or compatibility.

- **License:** GNU GPL-3.0 (see `LICENSE`).
- **What the repository contains:** an [Apktool](https://apktool.org) project in `app/`: `AndroidManifest.xml`, `apktool.yml`, decompiled **Smali** files (`app/smali/`), the WebView application files (`app/assets/`) and Android resources (`app/res/`), plus `build.sh`. It does **not** contain an original Java/Kotlin source tree, and some JavaScript files are minified. Details: [SOURCE_STATUS.md](SOURCE_STATUS.md).
- **GPL Corresponding Source:** whether this repository fully satisfies the GPL Corresponding Source requirements is an **unresolved question**; it has not been legally established.
- **Third-party components:** [THIRD_PARTY_NOTICES.md](THIRD_PARTY_NOTICES.md). **Build instructions:** [BUILDING.md](BUILDING.md).
- Project version: **1.96** (`app/apktool.yml`). The current release is the one shown on the [Releases page](https://github.com/cangri-outy/Outy/releases) (the `v.1.96` tag points at the commit that contains the source of the published APK). Release status is not repeated in this file so that it cannot become outdated.

## ❤️ Donations and support

- Donations are voluntary and do not unlock features or priority support. See [DONATIONS.md](DONATIONS.md).
- Support is best effort, with no guaranteed response time. See [SUPPORT.md](SUPPORT.md) and the [FAQ](FAQ.md).
- Privacy: [PRIVACY.md](PRIVACY.md). Security: [SECURITY.md](SECURITY.md).

## ⚠️ Disclaimer

OutyDS is an unofficial community project, not affiliated with or endorsed by Mitsubishi Motors. It is provided **without any warranty**, under the GNU GPL v3. Use at your own risk: commands sent to the vehicle (climate, lights, charging) and any write operation are your responsibility. Do not use the app while driving in a way that distracts you.
