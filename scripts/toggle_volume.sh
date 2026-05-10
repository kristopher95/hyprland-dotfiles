#!/usr/bin/env bash

if eww active-windows | grep -q '^volume_popup:'; then
    eww close volume_popup
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
        print(monitor["id"])
        break
else:
    print(0)
EOF
)

eww open calendar_backdrop --screen 0 --id backdrop0
eww open calendar_backdrop --screen 1 --id backdrop1
sleep 0.05
eww open volume_popup --screen "$screen"
