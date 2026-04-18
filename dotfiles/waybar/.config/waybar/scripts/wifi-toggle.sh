#!/usr/bin/env bash
IFACE=$(iwctl device list | awk '/wlan|wlp/ {print $2; exit}')
ADAPTER=$(iwctl device "$IFACE" show | awk '/Adapter/ {print $NF; exit}')

STATE=$(iwctl device "$IFACE" show | awk '/Powered/ {print $NF}')

if [ "$STATE" = "on" ]; then
    iwctl station "$IFACE" disconnect
    iwctl adapter "$ADAPTER" set-property Powered off
    notify-send -a "WiFi" -u low -t 3000 "󰤮 WiFi" "Disabled"
else
    iwctl adapter "$ADAPTER" set-property Powered on
    iwctl station "$IFACE" scan
    notify-send -a "WiFi" -u low -t 3000 "󰤨 WiFi" "Enabled"
fi
