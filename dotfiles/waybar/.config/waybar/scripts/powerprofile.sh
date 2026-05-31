#!/usr/bin/env bash

update() {
    cur=$(tuned-adm active | awk -F': ' '{print $2}' | head -n1)

    icon_for() {
        case "$1" in
            powersave) echo "󰾆" ;;
            balanced) echo "󰾅" ;;
            throughput-performance|latency-performance|performance) echo "󰓅" ;;
            *) echo "󰾅" ;;
        esac
    }

    tooltip_for() {
        case "$1" in
            powersave) echo "Tuned Profile: Powersave\nBattery saving mode" ;;
            balanced) echo "Tuned Profile: Balanced\nDefault mode" ;;
            throughput-performance) echo "Tuned Profile: Throughput Performance" ;;
            latency-performance) echo "Tuned Profile: Latency Performance" ;;
            *) echo "Tuned Profile: $1" ;;
        esac
    }

    icon=$(icon_for "$cur")
    tooltip=$(tooltip_for "$cur")

    printf '{"text":"%s","tooltip":"%s"}\n' "$icon" "$tooltip"
}

# Waybar signal support
if [[ "$1" == "signal" ]]; then
    update
    exit
fi

while true; do
    update
    sleep 30
done
