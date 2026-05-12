#!/usr/bin/env bash

source="$1"

[[ -z "$source" ]] && exit 1

pactl set-default-source "$source"

pactl list short source-outputs | awk '{print $1}' | while read -r output_id; do
    pactl move-source-output "$output_id" "$source" 2>/dev/null
done

eww update audio_outputs="$(~/.config/eww/scripts/audio_outputs.sh)" 2>/dev/null
eww update audio_inputs="$(~/.config/eww/scripts/audio_inputs.sh)" 2>/dev/null
