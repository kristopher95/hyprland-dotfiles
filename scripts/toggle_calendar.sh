#!/usr/bin/env bash

eww daemon >/dev/null 2>&1 &

if eww active-windows | grep -q '^fancy_calendar:'; then
    eww close fancy_calendar
    eww close backdrop0
    eww close backdrop1
    exit 0
fi

screen=$(
python3 <<'EOF'
import json
import subprocess

cursor = json.loads(subprocess.check_output(["hyprctl", "cursorpos", "-j"]))
monitors = json.loads(subprocess.check_output(["hyprctl", "monitors", "-j"]))

x = cursor["x"]
y = cursor["y"]

for monitor in monitors:
    left = monitor["x"]
    top = monitor["y"]
    right = left + monitor["width"]
    bottom = top + monitor["height"]

    if left <= x < right and top <= y < bottom:
        name = monitor["name"]

        # Eww screen numbers are reversed on this setup.
        if name == "DP-1":
            print(1)
        elif name == "DP-3":
            print(0)
        else:
            print(0)

        break
else:
    print(0)
EOF
)

eww open calendar_backdrop --screen 0 --id backdrop0
eww open calendar_backdrop --screen 1 --id backdrop1
eww open fancy_calendar --screen "$screen"
