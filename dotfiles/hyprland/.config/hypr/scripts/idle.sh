#!/usr/bin/env bash
SWAYLOCK=$(which swaylock)

exec swayidle -w \
    # Lock screen after 5 minutes of inactivity
    timeout 300  "exec $SWAYLOCK -f" \
    \
    # Turn displays off 30s after locking (gives swaylock time to fully start)
    timeout 330  'hyprctl dispatch dpms off' \
    \
    # Turn displays back on when activity resumes from DPMS timeout
    resume       'hyprctl dispatch dpms on' \
    \
    # Suspend after 30 minutes of inactivity
    timeout 1800 'systemctl suspend' \
    \
    # Lock before sleep — critical for security on suspend
    before-sleep "exec $SWAYLOCK -f" \
    \
    # On resume from suspend: force DPMS on twice with delays to win the
    # race against swaylock/compositor initialization after long suspends
    after-resume  'sleep 1 && hyprctl dispatch dpms on && sleep 2 && hyprctl dispatch dpms on && sleep 1 && hyprctl dispatch dpms on'
