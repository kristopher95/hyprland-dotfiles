#!/usr/bin/env bash

default_source="$(pactl get-default-source)"

pactl list short sources | while IFS=$'\t' read -r id name driver sample state; do
    # Skip monitor sources, because those are output loopbacks, not real microphones
    [[ "$name" == *.monitor ]] && continue

    description="$(pactl list sources | awk -v source_name="$name" '
        $1 == "Name:" && $2 == source_name { found=1 }
        found && $1 == "Description:" {
            sub(/^[[:space:]]*Description:[[:space:]]*/, "")
            print
            exit
        }
    ')"

    if [[ "$name" == "$default_source" ]]; then
        icon="●"
        class="audio-device active"
    else
        icon="○"
        class="audio-device"
    fi

    safe_description="${description//\"/\\\"}"

    printf '(button :class "%s" :onclick "pactl set-default-source %s" (label :text "%s %s"))\n' \
        "$class" "$name" "$icon" "$safe_description"
done
