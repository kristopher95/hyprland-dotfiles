#!/usr/bin/env bash
set -euo pipefail

# GPU usage/temperature display for Waybar.
# Output examples:
# [GPU:42% 55°C]
# [GPU:55°C]
# [GPU:N/A]

# NVIDIA path
if command -v nvidia-smi >/dev/null 2>&1; then
    output="$(
        nvidia-smi \
            --query-gpu=utilization.gpu,temperature.gpu \
            --format=csv,noheader,nounits 2>/dev/null | head -n 1
    )"

    if [[ -n "${output:-}" ]]; then
        usage="$(echo "$output" | awk -F',' '{gsub(/ /, "", $1); print $1}')"
        temp="$(echo "$output" | awk -F',' '{gsub(/ /, "", $2); print $2}')"

        if [[ -n "${usage:-}" && -n "${temp:-}" ]]; then
            echo "[GPU:${usage}% ${temp}°C]"
            exit 0
        fi
    fi
fi

# AMD/Intel fallback using sensors
temp="$(
    sensors 2>/dev/null | awk '
        /edge:/ {
            gsub(/[+°C]/, "", $2)
            printf "%d", $2
            found=1
            exit
        }

        /junction:/ {
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

if [[ -n "${temp:-}" ]]; then
    echo "[GPU:${temp}°C]"
else
    echo "[GPU:N/A]"
fi
