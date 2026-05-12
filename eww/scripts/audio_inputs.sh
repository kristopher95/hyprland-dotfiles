#!/usr/bin/env bash

default_source="$(pactl get-default-source 2>/dev/null)"

escape_yuck() {
    sed \
        -e 's/\\/\\\\/g' \
        -e 's/"/\\"/g' \
        -e 's/&/\&amp;/g' \
        -e 's/</\&lt;/g' \
        -e 's/>/\&gt;/g'
}

printf '(box :class "audio-device-list" :orientation "vertical" :space-evenly false :spacing 4 '

pactl list short sources | while IFS=$'\t' read -r id name driver sample state; do
    [[ "$name" == *.monitor ]] && continue

    description="$(
        pactl list sources | awk -v source_name="$name" '
            $1 == "Name:" && $2 == source_name { found=1 }
            found && $1 == "Description:" {
                sub(/^[[:space:]]*Description:[[:space:]]*/, "")
                print
                exit
            }
        '
    )"

    [[ -z "$description" ]] && description="$name"

    if [[ "$name" == "$default_source" ]]; then
        icon="●"
        class="audio-device active"
    else
        icon="○"
        class="audio-device"
    fi

    safe_description="$(printf '%s' "$description" | escape_yuck)"

    printf '(button :class "%s" :onclick "~/.config/eww/scripts/set_audio_input.sh '\''%s'\''" (label :text "%s %s")) ' \
        "$class" "$name" "$icon" "$safe_description"
done

printf ')'
