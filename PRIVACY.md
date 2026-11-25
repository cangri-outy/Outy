# Privacy

OutyDS is free and open-source software distributed under GNU GPL-3.0. Donations are voluntary and help support continued development. Support is provided on a best-effort basis, without guaranteed response times, fixes, updates or compatibility.

This document describes what the application does, based on its Android manifest and code (reviewed 2026-11-24). The app has **no account system, no analytics or telemetry code and no server of its own**; no code was found that sends vehicle data to the maintainer. Data leaves the phone only to the destinations listed below. This is a review of the code, not a guarantee, and third-party services (GitHub, Open-Meteo, your browser) have their own policies.

## Permissions and what they are used for
| Permission(s) | Use |
|---|---|
| Bluetooth (`BLUETOOTH`, `BLUETOOTH_ADMIN`, `BLUETOOTH_CONNECT`) | Connect to a Bluetooth OBD-II adapter. |
| WiFi / network (`ACCESS_WIFI_STATE`, `CHANGE_WIFI_STATE`, `NEARBY_WIFI_DEVICES`, `ACCESS_NETWORK_STATE`, `CHANGE_NETWORK_STATE`) | Connect to a WiFi OBD adapter and to the car's own WiFi (Remote tab). |
| `INTERNET` | GitHub update check/download and optional Open-Meteo weather (see below); local connections to the adapter or car. |
| Location (`ACCESS_FINE_LOCATION`, `ACCESS_COARSE_LOCATION`) | Optional: GPS speed, altitude and, if enabled, weather. |
| `READ_CALENDAR` | Optional: read calendar events on the phone to schedule pre-heating (Remote tab). |
| `WRITE_EXTERNAL_STORAGE` | Save logs and reports to the Downloads folder. |
| `FOREGROUND_SERVICE` (+ `CONNECTED_DEVICE`, `DATA_SYNC`), `POST_NOTIFICATIONS`, `WAKE_LOCK` | Background connection service and its notification. |
| `SCHEDULE_EXACT_ALARM`, `REQUEST_IGNORE_BATTERY_OPTIMIZATIONS` | Scheduled pre-heating and keeping the background connection alive. |
| `REQUEST_INSTALL_PACKAGES` | Let the update mechanism start the Android installer for a downloaded APK. Android asks you to confirm the installation. |

## Vehicle connections
- **Bluetooth / WiFi OBD adapter:** the app talks to the adapter directly (Bluetooth, or a plain TCP connection to the adapter's address). It reads vehicle data such as speed, battery, temperatures, tyre pressures, fault codes and the **VIN**.
- **Remote tab:** your phone joins the car's own WiFi and talks to the car directly.
These connections are local to the phone and the vehicle.

## What leaves the phone
- **GitHub (`api.github.com` and the release download):** an update check at start (can be switched off in Settings > Updates) and, only if you accept, the APK download. GitHub receives your IP address and the repository name being queried.
- **Open-Meteo (`api.open-meteo.com`):** only if you enable online weather (off by default). Your location **rounded to two decimals (about 1 km)** is sent in the request URL. Open-Meteo receives your IP address.
- **Links you tap** (for example donation pages) open in your browser, which then talks to those sites.
- Android's DownloadManager performs the update download.
No other network destination was found in the code. Exported files and logs are not uploaded by the app; if you share them, you decide where they go. The maintainer can see download counts that GitHub shows for releases.

## What stays on the phone
- **Settings, trip and charge history:** in the app's private storage.
- **Vehicle WiFi configuration (name and password, Remote tab):** in the app's private storage. It is **not additionally encrypted**; Android app backup is disabled for the app.
- **Calendar events:** read locally to plan pre-heating; the code does not send them anywhere.
- **Location:** used on the phone; only the rounded value above is sent, and only for weather.

## Logs and exports
The app can save CSV/JSON reports and OBD logs in your Downloads folder. They **can contain your VIN and location (GPS track)** and other vehicle data. **Sanitise them before sharing** (see [SUPPORT.md](SUPPORT.md)). They stay on the phone until you delete them.

## Background service, alarms and notifications
- While connected, a foreground service keeps the vehicle connection alive and shows a persistent notification (including live values).
- If you configure and enable scheduled pre-heating, an exact alarm wakes the app at the planned time and a background service connects to the car and sends the command.
- Notifications are local.

## Uninstalling
Uninstalling removes the app's private data. Files in Downloads stay until you delete them.

Version status (checked 2026-11-24): the project files in this repository are version **1.96**. The latest **published** GitHub Release is **v.1.96** (`OutyDS_1.96.apk`, published 2026-11-24; its tag `v.1.96` points to commit `5b24a27`, which contains the exact source of that APK; the release APK's SHA-256 was checked to equal the build from that source). The previous release is v.1.95.
