# Third-party notices

OutyDS is licensed under GPL-3.0 (see `LICENSE`). It includes or uses the following external work.

| Component | Where | License | Notes |
|---|---|---|---|
| phev2mqtt (buxtronix) — https://github.com/buxtronix/phev2mqtt | `app/assets/phev-engine.js` (protocol port used by the Remote tab) | GPL-3.0 | Derived work, therefore OutyDS is distributed under GPL-3.0 with full source. |
| OBDb Mitsubishi-Outlander-PHEV signal set — https://github.com/OBDb | `app/assets/obdb.js` | CC BY-SA 4.0 | Modified: converted to a compact JavaScript array. CC BY-SA 4.0 is one-way compatible with GPL-3.0. Attribution is also shown in the app. |
| Open-Meteo — https://open-meteo.com | Optional online weather (off by default) | CC BY 4.0 (data) | Only approximate coordinates are sent, and only when the user turns online weather on. |
| Apktool 2.10.0 — https://github.com/iBotPeaches/Apktool | Build tool, not distributed | Apache-2.0 | Version and SHA-256 are pinned in `build.sh`. |
| uber-apk-signer 1.3.0 — https://github.com/patrickfav/uber-apk-signer | Build tool, not distributed | Apache-2.0 | Version and SHA-256 are pinned in `build.sh`. |
| Android platform / WebView | Runtime | Apache-2.0 / Chromium | Provided by the device. |

## Icons and resources

- Launcher icon (`app/res/mipmap-*`, `app/res/drawable/ic_launcher_*.xml`): drawn for this project.
- UI icons are inline SVG paths in `app/assets/index.html` and `style.css` (data URIs). No icon font or icon library is bundled. They were written for this project with AI assistance; their shapes resemble common icon sets and have not been compared against any specific library.
- No web fonts, no JavaScript libraries (no jQuery, chart or UI frameworks) and no native `.so` libraries are bundled.

## Own and AI-assisted work

- All other code was written by the project author with AI assistance (Claude). Parts of the Remote logic follow behaviour first developed in the author's own SIDMonitor experiments (not published separately).
- Images in `app/assets/` (`car_top.jpg`, `car3d.jpg`, `car-photo.jpg`, `engine_on.png`, `engine_on2.png`) were generated with AI (Gemini) by the author.

## What is not included

No signing keys, passwords, tokens, VINs or vehicle logs. Build with your own keystore (see `BUILDING.md`).

## Trademarks

Mitsubishi and Outlander are trademarks of their owners. OutyDS is unofficial and not affiliated with Mitsubishi Motors.
