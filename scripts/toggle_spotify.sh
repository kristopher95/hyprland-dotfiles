#!/usr/bin/env bash

spotify_cmd="spotify-launcher"
special_ws="special:spotify"

# Get Spotify window address, if it exists.
spotify_addr="$(
    hyprctl clients -j |
    jq -r '.[] | select(.class | ascii_downcase == "spotify") | .address' |
    head -n1
)"

# If no Spotify window exists, launch Spotify.
if [[ -z "$spotify_addr" || "$spotify_addr" == "null" ]]; then
    "$spotify_cmd" >/dev/null 2>&1 &
    exit 0
fi

# Get active window address.
active_addr="$(
    hyprctl activewindow -j 2>/dev/null |
    jq -r '.address // empty'
)"

# If Spotify is currently focused, hide it.
if [[ "$active_addr" == "$spotify_addr" ]]; then
    hyprctl dispatch movetoworkspacesilent "$special_ws,address:$spotify_addr" >/dev/null
    exit 0
fi

# Determine monitor under cursor.
cursor="$(hyprctl cursorpos -j)"
cursor_x="$(echo "$cursor" | jq -r '.x')"
cursor_y="$(echo "$cursor" | jq -r '.y')"

target_ws="$(
    hyprctl monitors -j |
    jq -r --argjson x "$cursor_x" --argjson y "$cursor_y" '
        .[] |
        select(
            ($x >= .x) and
            ($x < (.x + .width)) and
            ($y >= .y) and
            ($y < (.y + .height))
        ) |
        .activeWorkspace.id
    ' |
    head -n1
)"

# Fallback if cursor detection fails.
if [[ -z "$target_ws" || "$target_ws" == "null" ]]; then
    target_ws="$(hyprctl activeworkspace -j | jq -r '.id')"
fi

# Bring Spotify to the workspace under the mouse and focus it.
hyprctl dispatch movetoworkspacesilent "$target_ws,address:$spotify_addr" >/dev/null
sleep 0.05
hyprctl dispatch focuswindow "address:$spotify_addr" >/dev/null
