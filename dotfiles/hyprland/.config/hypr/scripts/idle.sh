#!/usr/bin/env bash
SWAYLOCK=$(which swaylock)

# Lock screen after 5 minutes of inactivity
# Turn displays off 30s after locking (gives swaylock time to fully start)
# Turn displays back on when activity resumes from DPMS timeout
# Suspend after 30 minutes of inactivity
# Lock before sleep — critical for security on suspend
# On resume from suspend: force DPMS on twice with delays to win the
# race against swaylock/compositor initialization after long suspends
exec swayidle -w \
    timeout 300  "exec $SWAYLOCK -f" \
    timeout 330  'hyprctl dispatch dpms off' \
    resume       'hyprctl dispatch dpms on' \
    timeout 1800 'systemctl suspend' \
    before-sleep "exec $SWAYLOCK -f" \
    after-resume 'sleep 1 && hyprctl dispatch dpms on && sleep 2 && hyprctl dispatch dpms on && sleep 1 && hyprctl dispatch dpms on'
