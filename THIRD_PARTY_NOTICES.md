# Third-party notices

OutyDS is licensed under GPL-3.0 (see `LICENSE`). It includes or uses the following external work.

| Component | Where | License | Notes |
|---|---|---|---|
| phev2mqtt (buxtronix) — https://github.com/buxtronix/phev2mqtt | `app/assets/phev-engine.js` (its header states it is a port of phev2mqtt's protocol and client) | GPL-3.0 | OutyDS is published under GPL-3.0 because of this derived file. Whether the repository fully meets the GPL Corresponding Source requirements is unresolved (see `SOURCE_STATUS.md`). |
| OBDb Mitsubishi-Outlander-PHEV signal set — https://github.com/OBDb | `app/assets/obdb.js` | CC BY-SA 4.0 | Modified: converted to a compact JavaScript array. CC BY-SA 4.0 is one-way compatible with GPL-3.0. Attribution is also shown in the app. |
| Open-Meteo — https://open-meteo.com (attribution "Weather data by Open-Meteo.com" is shown in Settings next to the weather option and in About) | Optional online weather (off by default) | CC BY 4.0 (data) | Only approximate coordinates are sent, and only when the user turns online weather on. |
| Apktool 2.10.0 — https://github.com/iBotPeaches/Apktool | Build tool, not distributed | Apache-2.0 | Version and SHA-256 are pinned in `build.sh`. |
| uber-apk-signer 1.3.0 — https://github.com/patrickfav/uber-apk-signer | Build tool, not distributed | Apache-2.0 | Version and SHA-256 are pinned in `build.sh`. |
| Android platform / WebView | Runtime | Android Open Source Project (Apache-2.0); WebView is based on Chromium | Provided by the device, not distributed with OutyDS. |

## Scope of the phev2mqtt-derived code
- `app/assets/phev-engine.js` is the file identified as the phev2mqtt-derived protocol implementation.
- The other Remote tab files (`app/assets/phev-ui.js`, `remote-bridge.js`, `remote-frame.js`, `remote.html`, and the Smali under `app/smali/ro/outyds/remote/`) implement the Remote tab around it. Whether they contain further phev2mqtt-derived code has **not been audited**.

## Source availability
The original Java/Kotlin source tree is **not available** in this repository. The repository is an Apktool project (Smali, resources, WebView assets); some JavaScript is minified. See `SOURCE_STATUS.md`. No legal clearance of any component is claimed here, and no copyright holders or permissions are stated beyond what the upstream projects publish.

## Icons and resources

- Launcher icon (`app/res/mipmap-*`, `app/res/drawable/ic_launcher_*.xml`): simple vector shapes and PNG renderings; their authorship is not documented in this repository.
- UI icons are inline SVG paths in `app/assets/index.html` and `style.css` (data URIs). No icon font or icon library is bundled. Their origin is not documented here; no comparison against any specific icon library has been made.
- No web fonts, no JavaScript libraries (no jQuery, chart or UI frameworks) and no native `.so` libraries are bundled.

## Own and AI-assisted work

- According to the maintainer, all other code was written with AI assistance (Claude). According to the maintainer, parts of the Remote logic follow behaviour first developed in the maintainer's own SIDMonitor experiments (not published separately); this has not been independently verified.
- Images in `app/assets/` (`car_top.jpg`, `car3d.jpg`, `car-photo.jpg`, `engine_on.png`, `engine_on2.png`) were, according to the maintainer, generated with AI (Gemini). The rights status of such images has not been legally assessed.

## What is not included

No signing keys, passwords, tokens, VINs or vehicle logs. Build with your own keystore (see `BUILDING.md`).

## Trademarks

Mitsubishi and Outlander are trademarks of their owners. OutyDS is unofficial and not affiliated with Mitsubishi Motors.
