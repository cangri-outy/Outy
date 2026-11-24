# Security policy

## Reporting a vulnerability
Please report security problems **privately** using GitHub's "Report a vulnerability" button (Security tab of this repository). If that button is not available, open a public issue that says only "security contact please" (no details) and a private channel will be arranged.
Include the app version, Android version, steps to reproduce and the impact. You will get a first answer within 7 days.

## Supported versions
Only the latest release receives fixes.

## Scope notes
- The app talks to a vehicle adapter (Bluetooth or WiFi OBD) and, for the Remote tab, to the car's own WiFi network. Commands that write to the vehicle are limited and confirmed by the user.
- The WebView loads only the app's bundled pages; messages between pages are accepted only from the app's own frames; stored values shown in the UI are escaped.
- The native bridge only opens `https://` links and only downloads updates from `https://github.com/`; the installer is always confirmed by the user in Android.
- Known limitations: the car WiFi password is stored unencrypted in the app sandbox (backup disabled); the WebView has file access enabled for bundled assets; the Remote link to the car uses the car's own unencrypted-by-design protocol on its private WiFi.
- The repository never contains signing keys. Releases are signed with a private key kept by the maintainer; updates only install over the same signature.
- Verify downloads with the published `SHA256SUMS` file.
