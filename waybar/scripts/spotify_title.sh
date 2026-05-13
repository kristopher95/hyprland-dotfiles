#!/usr/bin/env bash

track="$(
    playerctl -p spotify metadata --format '{{ artist }} - {{ title }}' 2>/dev/null
)"

status="$(playerctl -p spotify status 2>/dev/null)"

if [[ -z "$track" ]]; then
    python3 -c 'import json; print(json.dumps({"text": "", "tooltip": "Spotify not running"}))'
    exit 0
fi

max_len=34

if (( ${#track} <= max_len )); then
    display="$track"
else
    padded="$track     •     "
    len=${#padded}
    offset=$(( $(date +%s) % len ))

    display="${padded:offset:max_len}"

    if (( ${#display} < max_len )); then
        remaining=$((max_len - ${#display}))
        display="$display${padded:0:remaining}"
    fi
fi

tooltip="$(printf "Spotify\nStatus: %s\nTrack: %s" "$status" "$track")"

python3 -c '
import json
import sys

print(json.dumps({
    "text": sys.argv[1],
    "tooltip": sys.argv[2]
}))
' "$display" "$tooltip"
