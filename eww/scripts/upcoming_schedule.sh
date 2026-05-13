#!/usr/bin/env bash

# Sync quietly first so the popup is reasonably fresh.
vdirsyncer sync >/dev/null 2>&1

schedule="$(
    khal list today 7d 2>/dev/null |
    sed '/^[[:space:]]*$/d' |
    head -n 12
)"

if [[ -z "$schedule" ]]; then
    echo "No upcoming events"
else
    echo "$schedule"
fi
