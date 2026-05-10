#!/usr/bin/env bash

default_sink="$(pactl get-default-sink)"

pactl list short sinks | while IFS=$'\t' read -r id name driver sample state; do
    description="$(pactl list sinks | awk -v sink_name="$name" '
        $1 == "Name:" && $2 == sink_name { found=1 }
        found && $1 == "Description:" {
            sub(/^[[:space:]]*Description:[[:space:]]*/, "")
            print
            exit
        }
    ')"

    if [[ "$name" == "$default_sink" ]]; then
        icon="●"
        class="audio-device active"
    else
        icon="○"
        class="audio-device"
    fi

    safe_description="${description//\"/\\\"}"

    printf '(button :class "%s" :onclick "pactl set-default-sink %s" (label :text "%s %s"))\n' \
        "$class" "$name" "$icon" "$safe_description"
done
