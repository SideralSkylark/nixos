#!/usr/bin/env bash

if ! command -v jq &>/dev/null; then
    echo '{"text":"󰂜","tooltip":"jq not installed","class":"error"}'
    exit 1
fi

PAUSED=$(dunstctl is-paused)
COUNT=$(dunstctl count waiting)

if [[ "$PAUSED" == "true" ]]; then
    if (( COUNT > 0 )); then
        echo "{\"text\":\"󰂛\",\"tooltip\":\"DND · $COUNT waiting\",\"class\":\"dnd\"}"
    else
        echo "{\"text\":\"󰂛\",\"tooltip\":\"Do not disturb\",\"class\":\"dnd\"}"
    fi
else
    if (( COUNT > 0 )); then
        echo "{\"text\":\"󰂚\",\"tooltip\":\"$COUNT notification(s)\",\"class\":\"notification\"}"
    else
        echo "{\"text\":\"󰂜\",\"tooltip\":\"No notifications\",\"class\":\"none\"}"
    fi
fi
