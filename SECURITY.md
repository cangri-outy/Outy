# Security policy

## Reporting a vulnerability
Please report security problems **privately** using GitHub's "Report a vulnerability" button (Security tab of this repository), not in a public issue.
Include the app version, Android version, steps to reproduce and the impact. You will get a first answer within 7 days.

## Supported versions
Only the latest release receives fixes.

## Scope notes
- The app talks to a vehicle adapter (Bluetooth or WiFi OBD) and, for the Remote tab, to the car's own WiFi network. Commands that write to the vehicle are limited and confirmed by the user.
- The WebView accepts messages only from the app's own pages; stored values shown in the UI are escaped.
- The repository never contains signing keys. Releases are signed with a private key kept by the maintainer; updates only install over the same signature.
- Verify downloads with the published `SHA256SUMS` file.
