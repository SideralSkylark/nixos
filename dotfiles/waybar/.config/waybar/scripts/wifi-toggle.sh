#!/usr/bin/env bash
STATE=$(iwctl station wlan0 show | awk '/Powered/ {print $2}')
if [ "$STATE" = "on" ]; then
    iwctl station wlan0 disconnect && \
    iwctl adapter wlan0 set-property Powered off && \
    notify-send "WiFi" "WiFi disabled" -i network-wireless-off
else
    iwctl adapter wlan0 set-property Powered on && \
    iwctl station wlan0 scan && \
    notify-send "WiFi" "WiFi enabled" -i network-wireless
fi
