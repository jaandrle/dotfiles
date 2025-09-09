#!/usr/bin/env bash
if bluetoothctl show | grep -q 'Powered: no'; then
	bluetoothctl power on
else
	bluetoothctl power off
fi
