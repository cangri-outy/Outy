# Changelog

## 1.96
- Bluetooth or WiFi OBD adapter, chosen from the Conectare button (WiFi: plain TCP, default port 35000).
- Data regrouped: Baterie page (energy, charging, trip energy, cells, battery temperatures) and Motor page (trip, engine, ECU signals, electric motors, climate).
- Charge statistics and cost, altitude climb/descent, motor share, SoC and cell alerts.
- TPMS: dead sources are skipped, ECU 600 layout decoded, values expire after 3 minutes, no values kept between sessions.
- In-app updates from GitHub (default repo `cangri-outy/Outy`).
- GPL-3.0 notice, disclaimer and source published; security hardening (message source checks, escaping).
