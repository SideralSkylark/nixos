#!/usr/bin/env bash
STATE=$(nmcli radio wifi)

if [ "$STATE" = "enabled" ]; then
    nmcli radio wifi off
    notify-send -a "WiFi" -u low -t 3000 "󰤮 WiFi" "Disabled"
else
    nmcli radio wifi on
    notify-send -a "WiFi" -u low -t 3000 "󰤨 WiFi" "Enabled"
fi
