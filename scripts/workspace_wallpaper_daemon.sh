#!/usr/bin/env bash

mkdir -p "$HOME/.cache/awww"

# Start awww daemon quietly if needed.
if ! pgrep -x awww-daemon >/dev/null; then
    awww-daemon >/tmp/awww-daemon.log 2>&1 &
    sleep 1
fi

# Set wallpaper immediately on login/start.
~/.scripts/set_workspace_wallpaper.sh >/dev/null 2>&1

socket="$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock"

# Listen for Hyprland workspace changes.
socat -U - UNIX-CONNECT:"$socket" | while read -r event; do
    case "$event" in
        workspace*|focusedmon*)
            ~/.scripts/set_workspace_wallpaper.sh >/dev/null 2>&1
            ;;
    esac
done
