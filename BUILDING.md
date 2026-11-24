# OutyDS

Android OBD app for the Mitsubishi Outlander PHEV (MY2013–MY2018), with a built-in **Remote** tab
(WiFi remote: climate, charging, lights, scheduled pre-heat).

- Package: `ro.outyds.app` (can be installed next to other apps)
- Version: 1.96

## Layout
- `app/` – apktool project: `AndroidManifest.xml`, `res/`, `smali/` (`ro.outy.app.*` and `ro.outyds.remote.*`), `assets/` (WebView UI)
- `app/assets/` – `index.html`, `app.js` (minified), `style.css`, `i18n.js`, Remote tab in `remote.html` + `phev-*.js` (loaded in an iframe, bridged by `remote-bridge.js`)
- `build.sh` – build + sign

## Build
```
KS=/path/outyds.jks KS_ALIAS=outyds KS_PASS=... ./build.sh
```
Output: `dist/OutyDS.apk`. Never commit the keystore; updates only install over the same signing key.

## Notes
- Internal storage keys stay `outy.*` for compatibility with existing exports.
- Credits: OBDb (CC BY-SA 4.0). Unofficial, not affiliated with Mitsubishi.
- Add a LICENSE of your choice.

## In-app updates
OutyDS checks `https://api.github.com/repos/<owner>/<repo>/releases/latest` at start (Settings > Updates; repo is set there, or in `app/assets/update.js` as `DEFAULT_REPO`).
To publish an update: bump `versionCode`/`versionName` in `app/apktool.yml` and `VERSION` in `app/assets/update.js`, build, sign with the SAME keystore,
then create a GitHub release tagged `vX.Y` (e.g. `v1.96`) with the signed `.apk` attached. Public repos only. Android asks the user to confirm the install.

## Connection

- **Bluetooth**: pair the OBD adapter in Android, then Conectare → Bluetooth.
- **WiFi dongle (ELM327)**: join the dongle's WiFi in Android, then Conectare → WiFi (or Setări → Conexiune). Address is `IP:port`, default `192.168.0.10:35000`. The saved WiFi address is used for auto-reconnect until a Bluetooth adapter is picked again.
