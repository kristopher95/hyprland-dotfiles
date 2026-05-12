#!/usr/bin/env bash

cache_file="/tmp/waybar_cpu_prev"

# CPU usage from /proc/stat
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

# CPU temperature from sensors
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
        /SMBUSMASTER 0:/ {
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

# Current average CPU clock speed in GHz
freq="$(
    awk '
        /cpu MHz/ {
            total += $4
            count++
        }
        END {
            if (count > 0) printf "%.1f", total / count / 1000
            else print "N/A"
        }
    ' /proc/cpuinfo
)"

# Hide shell/script noise, kernel workers, Waybar itself, and Firefox helper labels.
FILTER='^(ps|awk|bash|sh|fish|zsh|cpu.sh|waybar|Isolated|kworker|migration|idle|rcu_|irq|watchdog|cpuhp|systemd|Privileged|Web|WebExtensions|Utility|RDD|Socket|UVM)$'

# Top CPU process for the panel
top_proc="$(
    ps -eo pid=,comm=,%cpu= --sort=-%cpu |
    awk -v filter="$FILTER" '
        ($3 + 0) >= 0.5 &&
        $2 !~ filter {
            printf "%s %.0f%%", $2, $3
            exit
        }
    '
)"

[[ -z "$top_proc" ]] && top_proc="idle"

# Simple tooltip list of more CPU processes
top_processes="$(
    ps -eo pid=,comm=,%cpu= --sort=-%cpu |
    awk -v filter="$FILTER" '
        ($3 + 0) >= 0.5 &&
        $2 !~ filter {
            printf "%s %.1f%%\n", $2, $3
            count++
            if (count == 8) exit
        }
    '
)"

[[ -z "$top_processes" ]] && top_processes="No active CPU-heavy processes"

# Panel text includes #1 process. Tooltip is simple process list.
if [[ "$temp" == "N/A" ]]; then
    text="[CPU: ${usage}% | ${freq}G | ${top_proc}]"
else
    text="[CPU: ${usage}% | ${temp}°C | ${freq}G | ${top_proc}]"
fi

tooltip="$(printf "Top CPU Processes:\n%s" "$top_processes")"

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
