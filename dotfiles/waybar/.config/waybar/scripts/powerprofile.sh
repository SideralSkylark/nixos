#!/usr/bin/env bash

get_current_profile() {
    tuned-adm active | awk -F': ' '{print $2}' | head -n1
}

icon_for() {
    case "$1" in
        powersave)              printf "󰾆" ;;
        balanced)               printf "󰾅" ;;
        throughput-performance|latency-performance|performance)  printf "󰓅" ;;
        *)                      printf "󰾅" ;;
    esac
}

tooltip_for() {
    case "$1" in
        powersave)              printf "Tuned Profile: Powersave\nOptimized for battery life" ;;
        balanced)               printf "Tuned Profile: Balanced\nPerformance and efficiency" ;;
        throughput-performance) printf "Tuned Profile: Throughput Performance\nMaximum throughput" ;;
        latency-performance)    printf "Tuned Profile: Latency Performance\nMinimum latency" ;;
        *)                      printf "Tuned Profile: %s" "$1" ;;
    esac
}

escape_json() {
    local s="$1"
    s="${s//\\/\\\\}"
    s="${s//\"/\\\"}"
    s="${s//$'\n'/\\n}"
    printf '%s' "$s"
}

cur=$(get_current_profile)
et=$(escape_json "$(icon_for "$cur")")
etool=$(escape_json "$(tooltip_for "$cur")")
printf '{"text":"%s","tooltip":"%s"}\n' "$et" "$etool"
