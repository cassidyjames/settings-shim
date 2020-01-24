# settings-shim

Simple shim to launch GNOME Control Center from the [settings spec](https://github.com/elementary/switchboard/wiki/System-Settings-Schema-Specification). Ideal for Pop!\_OS or other GNOME-based desktops using apps that use the settings spec (like those originally made for elementary OS).

## Install

Ideally this will be packaged and included by your OS. To give it a shot on a recent Ubuntu-based GNOME system:

1. Make sure you have `libgtk-3-dev`, `meson`, and `valac` installed
2. Run `meson build --prefix=/usr`
3. In the build directory (`cd build`) run `ninja`
4. Install with `ninja install`. Enter your password, and you're good to go!
