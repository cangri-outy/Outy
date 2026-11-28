OutyDS – Frequently Asked Questions (FAQ)

OutyDS is an unofficial Android companion app for the Mitsubishi Outlander PHEV, designed to provide access to vehicle information, battery data and remote-control functions.

1. General

What is OutyDS?

OutyDS is an Android app for Mitsubishi Outlander PHEV owners. It provides access to vehicle information, battery monitoring and supported remote-control functions.

Is OutyDS an official Mitsubishi application?

No. OutyDS is an independent community project and is not affiliated with, endorsed by or supported by Mitsubishi Motors.

Is OutyDS free?

Yes. OutyDS is free and open-source software distributed under GNU GPL-3.0, through its GitHub repository. It is distributed by an individual, not a company.

Are donations required? Do they unlock anything?

No. Donations are optional and voluntary. They do not unlock paid features, do not give priority support and create no service or support contract. See DONATIONS.md.

Where can I download OutyDS?

Download the latest available version here:

https://github.com/cangri-outy/Outy/releases/latest

Where can I find instructions and documentation?

Visit the project Wiki:

https://github.com/cangri-outy/Outy/wiki

2. Compatibility and installation

Which Mitsubishi Outlander PHEV models are supported?

OutyDS is aimed at Outlander PHEV model years 2013–2018 (the maintainer's target; not verified on every model year). It has been checked only with logs from one 2016 car and a Bluetooth OBD adapter. The WiFi OBD adapter, the Remote tab and the 1.96 tyre-pressure decoding have not been verified on a real vehicle. Signals for 2021 and newer models are experimental. Compatibility depends on the vehicle generation, model year and electronic systems, and not every function is necessarily available on every model.

Check the Wiki for compatibility information. If you are unsure, provide your vehicle's model year and generation.

Does OutyDS work on every Android phone?

OutyDS is designed for Android phones. Compatibility can depend on the Android version, phone hardware and available wireless features.

How do I install OutyDS?

1. Download the latest APK from the Releases page.
2. Open the downloaded APK on your Android phone.
3. Allow installation from that source if Android asks.
4. Complete the installation and open OutyDS.

Only download APK files from the official project repository.

3. Vehicle connection

How does OutyDS communicate with the car?

The local remote-control connection uses the vehicle's WiFi system. Your phone needs to connect to the vehicle's WiFi network when using functions that communicate directly with the car.

The car's WiFi says "No internet". Is that normal?

Yes. The vehicle's WiFi is used for communication with the car and does not necessarily provide internet access.

Can I use the internet while connected to the car?

This depends on your phone's Android version and network configuration. The car's WiFi connection and mobile data connection serve different purposes.

Can I control my car from anywhere over the internet?

Do not assume that local WiFi remote-control functions are available remotely over the internet. Remote access requires a separately supported communication solution.

4. Vehicle information and battery monitoring

What vehicle information can OutyDS display?

Depending on vehicle compatibility and available data, OutyDS can display vehicle and battery information.

What battery information is available?

Depending on the vehicle and supported data, this can include:

- Battery state of charge (SOC)
- Battery voltage and current
- Battery capacity
- Individual cell voltage information
- Battery temperature information

Why can the battery percentage differ from the dashboard?

The vehicle may provide different battery measurements, such as raw battery SOC and displayed SOC. These values do not always represent exactly the same measurement.

Are battery readings real-time?

Readings depend on the vehicle's communication state and when the data was received. They should not be treated as laboratory-grade battery measurements.

Is the fuel consumption exact?

No, it is an estimate. OutyDS calculates it from engine data (air flow, load) assuming petrol, so it can differ from the real figure. On cars with an aftermarket LPG system the estimate is not valid while running on LPG, and the car can switch between LPG and petrol at any time, which OutyDS cannot detect.

5. Remote-control functions

Can I operate the vehicle's heating and air conditioning?

Remote climate functions depend on the vehicle generation and the commands supported by its control system. Availability and successful operation may vary.

Why does a remote command sometimes do nothing?

Possible reasons include:

- The phone is not connected to the vehicle's WiFi.
- The vehicle is not responding.
- The selected function is unsupported by that vehicle.
- The vehicle's control system has rejected the command.
- The communication session has failed.

If a command does not work, report the vehicle model year, the function you tried and any available app logs.

Does every remote-control function work on every model?

No. Different Outlander PHEV generations use different electronic systems and communication protocols. Function availability must be checked for each generation.

6. Troubleshooting

OutyDS cannot connect to the vehicle.

Check that:

1. The vehicle is switched on or in the appropriate remote-control state.
2. Your phone is connected to the vehicle's WiFi.
3. Android has not switched to another WiFi network.
4. You are within range of the vehicle.

The app displays missing or incorrect information.

Some data may not be supported by every vehicle generation. Check the connection and provide an app log when reporting the problem.

The app installs but crashes.

Please report:

- Your phone model
- Android version
- OutyDS version
- What you were doing when the crash occurred

How do I report a bug or request a feature?

Use the project's GitHub repository to report issues and provide details:

https://github.com/cangri-outy/Outy/issues

7. Updates and support

How do I update OutyDS?

Check the Releases page for new versions:

https://github.com/cangri-outy/Outy/releases/latest

Will I lose my settings when updating?

Back up any important app data before updating. Whether settings are preserved depends on the update and installation method.

Where can I get help?

Check this FAQ and the Wiki first. If you still need help, report the issue through GitHub and include your vehicle model year, phone model, Android version and relevant logs. Remove your VIN and GPS coordinates from logs before posting, and hide the car's WiFi name and password if they are visible in a screenshot. See SUPPORT.md.

Is support guaranteed?

No. Support is provided on a best-effort basis, without guaranteed response times, fixes, updates or compatibility. Donations do not change this.

What is the current version?

The project files in the repository are version 1.97. The Releases page always shows the current release and what it contains.

8. Source code

Does the repository contain the original Java/Kotlin source?

No. It contains an Apktool project: AndroidManifest.xml, apktool.yml, decompiled Smali files, WebView application files (some JavaScript is minified) and Android resources, plus build.sh. There is no original Java/Kotlin source tree. Whether this satisfies the GPL Corresponding Source requirements is an unresolved question. See SOURCE_STATUS.md and THIRD_PARTY_NOTICES.md.

---

Disclaimer: OutyDS is an independent project. Use remote-control functions responsibly. Always check that the vehicle is in a safe condition before sending commands.
