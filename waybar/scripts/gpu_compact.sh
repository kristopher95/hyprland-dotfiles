#!/usr/bin/env bash

if ! command -v nvidia-smi >/dev/null 2>&1; then
    echo "[G: N/A]"
    exit 0
fi

gpu_info="$(
    nvidia-smi --query-gpu=utilization.gpu,temperature.gpu --format=csv,noheader,nounits 2>/dev/null |
    head -n1
)"

if [[ -z "$gpu_info" ]]; then
    echo "[G: N/A]"
    exit 0
fi

usage="$(echo "$gpu_info" | awk -F',' '{gsub(/ /, "", $1); print $1}')"
temp="$(echo "$gpu_info" | awk -F',' '{gsub(/ /, "", $2); print $2}')"

echo "[G: ${usage}% ${temp}°]"
