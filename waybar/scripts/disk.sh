#!/usr/bin/env bash

root_dev=$(findmnt -n -o SOURCE /)
disk_dev=$(lsblk -no PKNAME "$root_dev" 2>/dev/null)

if [[ -z "$disk_dev" ]]; then
    disk_dev=$(basename "$root_dev")
fi

read r1 w1 < <(awk -v dev="$disk_dev" '$3 == dev {print $6, $10}' /proc/diskstats)

sleep 1

read r2 w2 < <(awk -v dev="$disk_dev" '$3 == dev {print $6, $10}' /proc/diskstats)

read_kb=$(((r2 - r1) / 2))
write_kb=$(((w2 - w1) / 2))

format_speed() {
    local kb=$1

    if (( kb >= 1024 )); then
        awk -v kb="$kb" 'BEGIN {printf "%.1fMB/s", kb/1024}'
    else
        printf "%dKB/s" "$kb"
    fi
}

echo "[DISK: R $(format_speed "$read_kb") | W $(format_speed "$write_kb")]"
