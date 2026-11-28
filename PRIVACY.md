# Privacy

OutyDS is free and open-source software distributed under GNU GPL-3.0. Donations are voluntary and help support continued development. Support is provided on a best-effort basis, without guaranteed response times, fixes, updates or compatibility.

This document describes what the application does, based on its Android manifest and code (re-reviewed on 2026-11-28 for version 1.97: manifest, native bridge, update mechanism, network destinations, storage, logs, services, WebView settings). The app has **no account system, no analytics or telemetry code and no server of its own**; no code was found that sends vehicle data to the maintainer. Data leaves the phone only to the destinations listed below. This is a review of the code, not a guarantee, and third-party services (GitHub, Open-Meteo, your browser) have their own policies.

## Permissions and what they are used for
| Permission(s) | Use |
|---|---|
| Bluetooth (`BLUETOOTH`, `BLUETOOTH_ADMIN` on Android 11 and older; `BLUETOOTH_CONNECT`) | Connect to a Bluetooth OBD-II adapter. |
| WiFi / network (`ACCESS_WIFI_STATE`, `CHANGE_WIFI_STATE`, `NEARBY_WIFI_DEVICES`, `ACCESS_NETWORK_STATE`, `CHANGE_NETWORK_STATE`) | Connect to a WiFi OBD adapter and to the car's own WiFi (Remote tab). |
| `INTERNET` | GitHub update check/download and optional Open-Meteo weather (see below); local connections to the adapter or car. |
| Location (`ACCESS_FINE_LOCATION`, `ACCESS_COARSE_LOCATION`) | Optional: GPS speed, altitude and, if enabled, weather. Android may also require it for the WiFi functions (finding and joining the car's WiFi network, reading its name), even though the app does not use your position for that. |
| `READ_CALENDAR` | Optional: read calendar events on the phone to schedule pre-heating (Remote tab). |
| `WRITE_EXTERNAL_STORAGE` (declared for Android 9 and older only) | Save logs and reports to the Downloads folder. |
| `FOREGROUND_SERVICE` (+ `CONNECTED_DEVICE`, `DATA_SYNC`), `POST_NOTIFICATIONS`, `WAKE_LOCK` | Background connection service and its notification. |
| `SCHEDULE_EXACT_ALARM`, `REQUEST_IGNORE_BATTERY_OPTIMIZATIONS` | Scheduled pre-heating and keeping the background connection alive. |
| `REQUEST_INSTALL_PACKAGES` | Let the update mechanism start the Android installer for a downloaded APK. Android asks you to confirm the installation. |

## Vehicle connections
- **Bluetooth / WiFi OBD adapter:** the app talks to the adapter directly (Bluetooth, or a plain TCP connection to the adapter's address). It reads vehicle data such as speed, battery, temperatures, tyre pressures, fault codes and the **VIN**.
- **Remote tab:** your phone joins the car's own WiFi and talks to the car directly.
These connections are local to the phone and the vehicle.

## What leaves the phone
- **GitHub (`api.github.com` and the release download):** an update check at start (can be switched off in Settings > Updates) and, only if you accept, the APK download (saved in the app's own storage folder, checked, and opened with the system installer). GitHub may redirect the download to its own content-delivery hosts. GitHub receives your IP address and the repository name being queried.
- **Open-Meteo (`api.open-meteo.com`):** only if you enable online weather (off by default). Your location **rounded to two decimals (about 1 km)** is sent in the request URL. Open-Meteo receives your IP address.
- **Links you tap** (for example donation pages) open in your browser, which then talks to those sites.
- Android's DownloadManager performs the update download.
No other network destination was found in the code. Exported files and logs are not uploaded by the app; if you share them, you decide where they go. The maintainer can see download counts that GitHub shows for releases.

## What stays on the phone
- **Settings, trip and charge history:** in the app's private storage.
- **Vehicle WiFi configuration (name and password, Remote tab):** in the app's private storage. It is **not additionally encrypted**; Android app backup is disabled for the app.
- **Calendar events:** read locally to plan pre-heating; the code does not send them anywhere.
- **Location:** used on the phone; only the rounded value above is sent, and only for weather. When online weather is on, the last known position (not rounded) and the last weather result are also kept in the app's private storage (the position for up to 7 days) so weather can still be shown without a fresh GPS fix.
- **Adapter and tyre settings:** the saved Bluetooth adapter (name and address), the WiFi adapter address, and tyre sensor IDs if you enter them, in the app's private storage.

## Logs and exports
The app can save CSV/JSON reports and OBD logs in your Downloads folder. They **can contain your location (GPS track)** and other vehicle data. From 1.97 the VIN written into CSV/JSON reports, the OBD console export header and the Remote log lines is shortened: the last 6 characters (the serial number) are replaced by `******` (or `**` in Remote log frames). The VIN is still shown in full on screen, and the `OutyDS-capture-*` files are not changed by this. The Remote tab writes its log automatically to an `OutyDS-log-*` file in Downloads while it is in use (no switch is needed); the file stops growing at about 2 MB per session. The "Clear" button only empties the log on the screen and does not delete that file. No code was found that writes the car's WiFi password into logs or reports; the WiFi name and password are visible on the Remote settings screen, so they can appear in screenshots. The optional "Diagnostic capture" switch in the Remote tab (off by default) additionally writes the Remote protocol traffic to `OutyDS-capture-*` files in Downloads. **Sanitise them before sharing** (see [SUPPORT.md](SUPPORT.md)). They stay on the phone until you delete them.

## Background service, alarms and notifications
- While connected, a foreground service keeps the vehicle connection alive and shows a persistent notification (including live values).
- If you configure and enable scheduled pre-heating, an exact alarm wakes the app at the planned time and a background service connects to the car and sends the command.
- The connection service and the scheduled pre-heating service hold a CPU wake lock while they run; the pre-heating service's lock is time-limited (about 21 minutes at most).
- Notifications are local.

## Uninstalling
Uninstalling removes the app's private data. Files in Downloads stay until you delete them.

Project version: **1.97** (`app/apktool.yml`). The current release is the one shown on the [Releases page](https://github.com/cangri-outy/Outy/releases); the tags `v.1.96` and `v.1.97` point at commits that contain the Apktool project of the corresponding APK (checked 2026-11-28), but the tag `v.1.95` does **not** contain the source of its APK (documented source-availability gap, see [SOURCE_STATUS.md](SOURCE_STATUS.md)). Release status is not otherwise repeated in this file so that it cannot become outdated.
