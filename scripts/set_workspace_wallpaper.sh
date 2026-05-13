#!/usr/bin/env bash

wp_dir="$HOME/Pictures/wallpapers/planets"
cache_dir="/tmp/workspace_wallpaper_cache"
mkdir -p "$cache_dir"

cursor_pos="$(hyprctl cursorpos)"
cursor_x="${cursor_pos%%,*}"

# Monitor layout:
# DP-1 = 2560x1440 at x=0
# DP-3 = 3440x1440 at x=2560

if (( cursor_x < 2560 )); then
    monitor="DP-1"
else
    monitor="DP-3"
fi

workspace="$(
    hyprctl monitors -j |
    jq -r --arg mon "$monitor" '.[] | select(.name == $mon) | .activeWorkspace.id'
)"

case "$workspace" in
    1|11) wallpaper="$wp_dir/1-mercury.png" ;;
    2|12) wallpaper="$wp_dir/2-venus.png" ;;
    3|13) wallpaper="$wp_dir/3-earth.png" ;;
    4|14) wallpaper="$wp_dir/4-mars.png" ;;
    5|15) wallpaper="$wp_dir/5-jupiter.png" ;;
    6|16) wallpaper="$wp_dir/6-saturn.png" ;;
    7|17) wallpaper="$wp_dir/7-uranus.png" ;;
    8|18) wallpaper="$wp_dir/8-neptune.png" ;;
    *) wallpaper="$wp_dir/3-earth.png" ;;
esac

if [[ ! -f "$wallpaper" ]]; then
    notify-send "Wallpaper missing" "$wallpaper" 2>/dev/null
    exit 1
fi

cache_file="$cache_dir/$monitor"

if [[ -f "$cache_file" ]] && [[ "$(cat "$cache_file")" == "$wallpaper" ]]; then
    exit 0
fi

echo "$wallpaper" > "$cache_file"

# Apply wallpaper only to the monitor under the mouse.
awww img "$wallpaper" --outputs "$monitor" --transition-type none >/dev/null 2>&1
