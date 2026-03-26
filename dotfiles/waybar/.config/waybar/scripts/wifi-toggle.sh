#!/usr/bin/env bash
IFACE="wlan0"
ADAPTER="phy0"

STATE=$(iwctl device "$IFACE" show | awk '/Powered/ {print $NF}')

if [ "$STATE" = "on" ]; then
    iwctl station "$IFACE" disconnect
    iwctl adapter "$ADAPTER" set-property Powered off
    notify-send \
        -a "WiFi" \
        -u low \
        -t 3000 \
        "󰤮 WiFi" "Disabled"
else
    iwctl adapter "$ADAPTER" set-property Powered on
    iwctl station "$IFACE" scan
    notify-send \
        -a "WiFi" \
        -u low \
        -t 3000 \
        "󰤨 WiFi" "Enabled"
fi
