#!/usr/bin/env bash
COUNT=$(dunstctl count history)
if (( COUNT == 0 )); then
    notify-send -a "dunst" -u low "󰂜 No history" "Notification history is empty"
    exit 0
fi

ENTRIES=$(dunstctl history | jq -r '
  .data[0][] |
  "\(.appname.data)  \(.summary.data)\(if .body.data != "" then " — \(.body.data)" else "" end)"
' | head -20)

echo "$ENTRIES" | fuzzel --dmenu --prompt "history › " --lines 10 > /dev/null

if (( $? == 0 )); then
    dunstctl history-pop
fi
