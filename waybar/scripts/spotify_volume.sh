#!/usr/bin/env bash

vol="$(playerctl -p spotify volume 2>/dev/null)"

if [[ -z "$vol" ]]; then
    echo ""
    exit 0
fi

percent="$(awk -v v="$vol" 'BEGIN { printf "%.0f", v * 100 }')"

echo "${percent}%"
