#!/usr/bin/env bash

PAUSED=$(dunstctl is-paused)
COUNT=$(dunstctl count waiting)

if [[ "$PAUSED" == "true" ]]; then
    CLASS="dnd"
    TEXT="DND"
    [[ $COUNT -gt 0 ]] && TEXT="DND ($COUNT)"
else
    CLASS="idle"
    TEXT="󰂚"
    if (( COUNT > 0 )); then
        CLASS="has-notifications"
        TEXT="󰂚 $COUNT"
    fi
fi

echo "{\"text\":\"$TEXT\",\"class\":\"$CLASS\",\"tooltip\":\"$(dunstctl count waiting) waiting\"}"
