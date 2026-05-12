#!/usr/bin/env bash

# Convert KiB to human-readable GiB/MiB
format_kib() {
    local kib="$1"

    awk -v kib="$kib" '
        BEGIN {
            mib = kib / 1024
            gib = mib / 1024

            if (gib >= 1)
                printf "%.1fG", gib
            else
                printf "%.0fM", mib
        }
    '
}

# RAM totals from /proc/meminfo
mem_total_kib="$(awk '/MemTotal:/ {print $2}' /proc/meminfo)"
mem_available_kib="$(awk '/MemAvailable:/ {print $2}' /proc/meminfo)"

mem_used_kib=$((mem_total_kib - mem_available_kib))
mem_percent=$((100 * mem_used_kib / mem_total_kib))

mem_used="$(format_kib "$mem_used_kib")"
mem_total="$(format_kib "$mem_total_kib")"

# Filter out script/shell/system noise.
FILTER='^(ps|awk|bash|sh|fish|zsh|ram.sh|waybar|systemd|dbus-daemon|pipewire|wireplumber|Isolated|Privileged|Web|WebExtensions|Utility|RDD|Socket|UVM|kworker|migration|idle|rcu_|irq|watchdog|cpuhp)$'

# Top RAM process for panel
top_proc="$(
    ps -eo comm=,rss= --sort=-rss |
    awk -v filter="$FILTER" '
        $2 > 0 &&
        $1 !~ filter {
            rss = $2
            mib = rss / 1024
            gib = mib / 1024

            if (gib >= 1)
                printf "%s %.1fG", $1, gib
            else
                printf "%s %.0fM", $1, mib

            exit
        }
    '
)"

[[ -z "$top_proc" ]] && top_proc="none"

# Top RAM processes for tooltip
top_processes="$(
    ps -eo comm=,rss= --sort=-rss |
    awk -v filter="$FILTER" '
        $2 > 0 &&
        $1 !~ filter {
            rss = $2
            mib = rss / 1024
            gib = mib / 1024

            if (gib >= 1)
                printf "%s %.1fG\n", $1, gib
            else
                printf "%s %.0fM\n", $1, mib

            count++
            if (count == 8) exit
        }
    '
)"

[[ -z "$top_processes" ]] && top_processes="No RAM-heavy processes"

text="[RAM: ${mem_used}/${mem_total} | ${top_proc}]"
tooltip="$(printf "RAM Usage: %s/%s (%s%%)\n\nTop RAM Processes:\n%s" "$mem_used" "$mem_total" "$mem_percent" "$top_processes")"

python3 -c '
import json
import sys

text = sys.argv[1]
tooltip = sys.argv[2]

print(json.dumps({
    "text": text,
    "tooltip": tooltip
}))
' "$text" "$tooltip"
