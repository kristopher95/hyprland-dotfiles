#!/usr/bin/env bash

wp_dir="$HOME/Pictures/wallpapers/planets"
cache_file="/tmp/current_workspace_wallpaper"

workspace="$(hyprctl activeworkspace -j | jq -r '.id')"

case "$workspace" in
    1) wallpaper="$wp_dir/1-mercury.png" ;;
    2) wallpaper="$wp_dir/2-venus.png" ;;
    3) wallpaper="$wp_dir/3-earth.png" ;;
    4) wallpaper="$wp_dir/4-mars.png" ;;
    5) wallpaper="$wp_dir/5-jupiter.png" ;;
    6) wallpaper="$wp_dir/6-saturn.png" ;;
    7) wallpaper="$wp_dir/7-uranus.png" ;;
    8) wallpaper="$wp_dir/8-neptune.png" ;;
    *) wallpaper="$wp_dir/3-earth.png" ;;
esac

if [[ ! -f "$wallpaper" ]]; then
    notify-send "Wallpaper missing" "$wallpaper" 2>/dev/null
    exit 1
fi

# Avoid reloading the same wallpaper repeatedly.
if [[ -f "$cache_file" ]] && [[ "$(cat "$cache_file")" == "$wallpaper" ]]; then
    exit 0
fi

echo "$wallpaper" > "$cache_file"

# Instant wallpaper switch. No transition, no overlay, no fade.
awww img "$wallpaper" --transition-type none >/dev/null 2>&1
