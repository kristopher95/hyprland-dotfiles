#!/usr/bin/env bash

# Toggle Spotify on Hyprland:
# - launch if not running
# - focus if open
# - hide to special workspace if currently focused

spotify_class="Spotify"
special_ws="special:spotify"

# Launch Spotify if not running
if ! pgrep -x spotify >/dev/null 2>&1 && ! pgrep -f "spotify" >/dev/null 2>&1; then
    spotify >/dev/null 2>&1 &
    exit 0
fi

active_class="$(
    hyprctl activewindow -j 2>/dev/null | jq -r '.class // empty'
)"

# If Spotify is currently focused, hide it
if [[ "$active_class" == "$spotify_class" ]]; then
    hyprctl dispatch movetoworkspacesilent "$special_ws"
    exit 0
fi

# Try to find Spotify window address
spotify_addr="$(
    hyprctl clients -j |
    jq -r --arg cls "$spotify_class" '.[] | select(.class == $cls) | .address' |
    head -n1
)"

# If no window exists yet, launch again
if [[ -z "$spotify_addr" ]]; then
    spotify >/dev/null 2>&1 &
    exit 0
fi

# Bring Spotify to current workspace and focus it
current_ws="$(
    hyprctl activeworkspace -j |
    jq -r '.id'
)"

hyprctl dispatch movetoworkspacesilent "$current_ws,address:$spotify_addr"
hyprctl dispatch focuswindow "address:$spotify_addr"
