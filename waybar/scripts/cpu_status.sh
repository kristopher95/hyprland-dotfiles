#!/usr/bin/env bash
set -euo pipefail

# Combined CPU usage + CPU temperature for Waybar.
# Output example: [CPU:12% 54°C]

read_cpu() {
    awk '/^cpu / {
        idle=$5
        total=0
        for (i=2; i<=NF; i++) total += $i
        print idle, total
    }' /proc/stat
}

read idle1 total1 < <(read_cpu)
sleep 0.2
read idle2 total2 < <(read_cpu)

idle_delta=$((idle2 - idle1))
total_delta=$((total2 - total1))

if (( total_delta > 0 )); then
    cpu_usage=$((100 * (total_delta - idle_delta) / total_delta))
else
    cpu_usage=0
fi

cpu_temp="$(
    sensors 2>/dev/null | awk '
        /Tctl:/ {
            gsub(/[+°C]/, "", $2)
            printf "%d", $2
            found=1
            exit
        }

        /Package id 0:/ {
            gsub(/[+°C]/, "", $4)
            printf "%d", $4
            found=1
            exit
        }

        /CPU:/ {
            gsub(/[+°C]/, "", $2)
            printf "%d", $2
            found=1
            exit
        }

        END {
            if (!found) exit 1
        }
    ' || true
)"

if [[ -z "${cpu_temp:-}" ]]; then
    echo "[CPU:${cpu_usage}% ?°C]"
else
    echo "[CPU:${cpu_usage}% ${cpu_temp}°C]"
fi
