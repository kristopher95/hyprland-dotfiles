#!/usr/bin/env bash
set -euo pipefail

# CPU temperature script for Waybar.
# Works best with AMD k10temp / Tctl sensors.

temp="$(
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
            if (!found) {
                exit 1
            }
        }
    '
)"

if [[ -z "${temp:-}" ]]; then
    echo "[CPU:TEMP?]"
    exit 0
fi

echo "[TEMP:${temp}°C]"
