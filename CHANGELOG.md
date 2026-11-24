# Changelog

## 1.96 (current project version, not yet published as a release)
- Bluetooth or WiFi OBD adapter, chosen from the Conectare button (WiFi: plain TCP, default port 35000; not yet tested with a real WiFi adapter).
- Data regrouped: Baterie page (energy, charging, trip energy, cells, battery temperatures) and Motor page (trip, engine, ECU signals, electric motors, climate).
- Charge statistics and cost, altitude climb/descent, motor share, SoC and cell alerts.
- TPMS: dead sources are skipped, ECU 600 layout decoded, values expire after 3 minutes, no values kept between sessions (tested in a simulation based on a car log; not yet verified on a car).
- In-app updater (present since 1.95): default repository now set to `cangri-outy/Outy`.
- Trip duration now counts real elapsed time from connection (it was cut to 3 s per OBD pass) and a trip that has not moved yet is no longer reset by the idle auto-split. Checked in a browser simulation only.
- TPMS: the route that answered last time (ECU 600) is remembered and tried first on the next connection. Checked by reading the code and a syntax check; not verified on a car.
- Fix: location permission check in `MainActivity.askLocation()` was inverted (it asked when already granted and marked it granted when denied). Verified by reading the code; not tested on a device.
- Fix: scheduled pre-heating (`PhevBackgroundService`) now uses a persistent receive buffer (`PhevRxBuffer`): partial frames are completed across reads, several frames per read are all processed, leftover bytes are kept and `SecurityKey.update()` receives only the exact 14-byte (or 18/24-byte) start frame. The protocol itself is unchanged. Covered by a Java reference-model test; the smali was assembled but has not been run on a device or a car.
- About screen: copyright/GPL-3.0/redistribution notice, phev2mqtt, OBDb and Open-Meteo attribution; "Weather data by Open-Meteo.com" next to the weather option.
- Release workflows: report takes a tag input and checks package name, version, signing certificate and alignment; download statistics count only `.apk` assets and the dashboard no longer shows multi-day gaps as daily growth; checksum file is generated after the final `OutyDS_<version>.apk` name is chosen.
- GPL-3.0 notice, disclaimer and source published; security hardening (message source checks, escaping, https-only links, updates only from github.com).

## 1.95 (published as v.1.95, `OutyDS_1.95.apk`)
- Published release. No changelog was kept for it in this repository.

The latest published GitHub Release is v.1.95 (checked 2026-11-24).
