#!/usr/bin/env bash

key="$1"

cursor_pos="$(hyprctl cursorpos)"
cursor_x="${cursor_pos%%,*}"

# Monitor layout:
# DP-1 = 2560x1440 at x=0
# DP-3 = 3440x1440 at x=2560

if (( cursor_x < 2560 )); then
    monitor="DP-1"
    target="$((key + 10))"
else
    monitor="DP-3"
    target="$key"
fi

# Force Hyprland to operate on the monitor under the mouse.
hyprctl dispatch focusmonitor "$monitor" >/dev/null
hyprctl dispatch workspace "$target"
