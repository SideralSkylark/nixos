#!/usr/bin/env bash

HISTORY=$(dunstctl history)

# Check if history is empty
COUNT=$(echo "$HISTORY" | jq '.data[0] | length')
if (( COUNT == 0 )); then
    notify-send -a "dunst" -u low "󰂜 No history" "Notification history is empty"
    exit 0
fi

# Build fuzzel input: "icon  summary — body" per entry, newest first
ENTRIES=$(echo "$HISTORY" | jq -r '
  .data[0][] |
  [
    .appname.data,
    .summary.data,
    .body.data
  ] | 
  "\(.[0])  \(.[1])\(if .[2] != "" then " — \(.[2])" else "" end)"
' | head -20)

# Show in fuzzel
CHOICE=$(echo "$ENTRIES" | fuzzel \
    --dmenu \
    --prompt "history › " \
    --lines 10)

# If something was selected, pop it back (shows the most recent matching)
if [[ -n "$CHOICE" ]]; then
    dunstctl history-pop
fi
