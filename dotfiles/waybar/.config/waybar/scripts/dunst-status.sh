#!/usr/bin/env bash

PAUSED=$(dunstctl is-paused)
COUNT=$(dunstctl count waiting)

CLASS="idle"
ICON="󰂚"
TEXT="$ICON"

if [[ "$PAUSED" == "true" ]]; then
    CLASS="dnd"
    ICON="DND ON"

    if (( COUNT > 0 )); then
        TEXT="$ICON ($COUNT)"
    else
        TEXT="$ICON"
    fi
else
    ICON="NOTIF ON"
    if (( COUNT > 0 )); then
        CLASS="has-notifications"
        TEXT="$ICON ($COUNT)"
    else
        TEXT="$ICON"
    fi
fi

echo "{\"text\":\"$TEXT\",\"class\":\"$CLASS\",\"tooltip\":\"Notifications: $COUNT\"}"
