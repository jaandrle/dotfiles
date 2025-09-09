#!/usr/bin/env bash
set -eou pipefail
dbus-monitor "interface=org.kde.KWin.VirtualDesktopManager" "member=currentChanged" | xargs -e -I {} kde6-workarounds.mjs desktops-last-save {}
