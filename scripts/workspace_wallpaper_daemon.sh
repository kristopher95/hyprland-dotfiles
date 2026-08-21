#!/usr/bin/env bash

# Only one copy of this daemon may run.
lock="${XDG_RUNTIME_DIR:-/tmp}/workspace_wallpaper_daemon.lock"
exec 9>"$lock"

if ! flock -n 9; then
    exit 0
fi

apply_wallpapers() {
    "$HOME/.scripts/set_workspace_wallpaper.sh" >/dev/null 2>&1
}

# Apply the correct wallpapers immediately.
apply_wallpapers

socket="$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock"

# Reconnect automatically if the Hyprland event socket is interrupted.
while true; do
    if [[ -S "$socket" ]]; then
        socat -U - UNIX-CONNECT:"$socket" | while IFS= read -r event; do
            case "$event" in
                workspace*|focusedmon*|monitoradded*|monitorremoved*)
                    apply_wallpapers
                    ;;
            esac
        done
    fi

    sleep 1
done
