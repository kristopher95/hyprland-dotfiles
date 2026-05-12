#!/usr/bin/env bash

sink="$1"

[[ -z "$sink" ]] && exit 1

pactl set-default-sink "$sink"

pactl list short sink-inputs | awk '{print $1}' | while read -r input_id; do
    pactl move-sink-input "$input_id" "$sink" 2>/dev/null
done

eww update audio_outputs="$(~/.config/eww/scripts/audio_outputs.sh)" 2>/dev/null
eww update audio_inputs="$(~/.config/eww/scripts/audio_inputs.sh)" 2>/dev/null
