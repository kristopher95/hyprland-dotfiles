#!/usr/bin/env bash

wp_dir="$HOME/Pictures/wallpapers/planets"

# Make sure Hyprpaper exists.
if ! pgrep -x hyprpaper >/dev/null; then
    hyprpaper >/tmp/hyprpaper.log 2>&1 &
fi

# Wait briefly for Hyprpaper IPC to become available.
for _ in {1..30}; do
    if hyprctl hyprpaper listactive >/dev/null 2>&1; then
        break
    fi
    sleep 0.1
done

if ! hyprctl hyprpaper listactive >/dev/null 2>&1; then
    exit 1
fi

monitors_json="$(hyprctl monitors -j)" || exit 1
active_wallpapers="$(hyprctl hyprpaper listactive 2>/dev/null || true)"

for monitor in DP-1 DP-3; do
    workspace="$(
        jq -r --arg mon "$monitor" \
        '.[] | select(.name == $mon) | .activeWorkspace.id' \
        <<< "$monitors_json"
    )"

    if [[ -z "$workspace" || "$workspace" == "null" ]]; then
        continue
    fi

    case "$workspace" in
        1|11) wallpaper="$wp_dir/1-mercury.png" ;;
        2|12) wallpaper="$wp_dir/2-venus.png" ;;
        3|13) wallpaper="$wp_dir/3-earth.png" ;;
        4|14) wallpaper="$wp_dir/4-mars.png" ;;
        5|15) wallpaper="$wp_dir/5-jupiter.png" ;;
        6|16) wallpaper="$wp_dir/6-saturn.png" ;;
        7|17) wallpaper="$wp_dir/7-uranus.png" ;;
        8|18) wallpaper="$wp_dir/8-neptune.png" ;;
        *) continue ;;
    esac

    [[ -f "$wallpaper" ]] || continue

    current="$(
        awk -F": " -v mon="$monitor" \
            '$1 == mon { print $2 }' \
            <<< "$active_wallpapers"
    )"

    if [[ "$current" != "$wallpaper" ]]; then
        hyprctl hyprpaper wallpaper \
            "$monitor, $wallpaper, cover" \
            >/dev/null 2>&1
    fi
done
