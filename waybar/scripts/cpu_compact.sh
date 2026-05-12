#!/usr/bin/env bash

cache_file="/tmp/waybar_cpu_compact_prev"

read -r _ user nice system idle iowait irq softirq steal guest guest_nice < /proc/stat

idle_all=$((idle + iowait))
non_idle=$((user + nice + system + irq + softirq + steal))
total=$((idle_all + non_idle))

if [[ -f "$cache_file" ]]; then
    read -r prev_total prev_idle < "$cache_file"
    total_diff=$((total - prev_total))
    idle_diff=$((idle_all - prev_idle))

    if [[ "$total_diff" -gt 0 ]]; then
        usage=$((100 * (total_diff - idle_diff) / total_diff))
    else
        usage=0
    fi
else
    usage=0
fi

echo "$total $idle_all" > "$cache_file"

temp="$(
    sensors 2>/dev/null |
    awk '
        /Tctl:/ {
            gsub(/[+°C]/, "", $2)
            printf "%.0f", $2
            found=1
            exit
        }
        /TSI0_TEMP:/ {
            gsub(/[+°C]/, "", $2)
            printf "%.0f", $2
            found=1
            exit
        }
        END {
            if (!found) print "N/A"
        }
    '
)"

if [[ "$temp" == "N/A" ]]; then
    echo "[C: ${usage}%]"
else
    echo "[C: ${usage}% ${temp}°]"
fi
