#!/usr/bin/env bash

iface=$(ip route | awk '/default/ {print $5; exit}')

if [[ -z "$iface" || ! -d "/sys/class/net/$iface" ]]; then
    echo "[NET: ↓ 0KB/s | ↑ 0KB/s]"
    exit 0
fi

rx1=$(cat "/sys/class/net/$iface/statistics/rx_bytes")
tx1=$(cat "/sys/class/net/$iface/statistics/tx_bytes")

sleep 1

rx2=$(cat "/sys/class/net/$iface/statistics/rx_bytes")
tx2=$(cat "/sys/class/net/$iface/statistics/tx_bytes")

down_kb=$(((rx2 - rx1) / 1024))
up_kb=$(((tx2 - tx1) / 1024))

format_speed() {
    local kb=$1

    if (( kb >= 1024 )); then
        awk -v kb="$kb" 'BEGIN {printf "%.1fMB/s", kb/1024}'
    else
        printf "%dKB/s" "$kb"
    fi
}

echo "[NET: ↓ $(format_speed "$down_kb") | ↑ $(format_speed "$up_kb")]"
