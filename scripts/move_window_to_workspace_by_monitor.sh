#!/usr/bin/env bash

key="$1"

cursor_pos="$(hyprctl cursorpos)"
cursor_x="${cursor_pos%%,*}"

# Monitor layout:
# DP-1 = 2560x1440 at x=0
# DP-3 = 3440x1440 at x=2560
#
# x < 2560  = DP-1
# x >= 2560 = DP-3

if (( cursor_x < 2560 )); then
    # Secondary monitor: workspaces 11-18
    target="$((key + 10))"
else
    # Main ultrawide: workspaces 1-8
    target="$key"
fi

hyprctl dispatch movetoworkspace "$target"
