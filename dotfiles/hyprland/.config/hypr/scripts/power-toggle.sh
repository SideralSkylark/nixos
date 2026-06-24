#!/usr/bin/env bash

CURRENT=$(powerprofilesctl get | tr -d ' ')

case "$CURRENT" in
  balanced)
    powerprofilesctl set performance
    MSG="Performance mode ON"
    ;;
  performance)
    powerprofilesctl set power-saver
    MSG="Power Saver mode ON"
    ;;
  power-saver)
    powerprofilesctl set balanced
    MSG="Balanced mode ON"
    ;;
  *)
    powerprofilesctl set balanced
    MSG="Defaulting to Balanced"
    ;;
esac

notify-send "Power Profile" "$MSG"
