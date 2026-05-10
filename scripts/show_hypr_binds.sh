#!/usr/bin/env bash

if pgrep -f 'rofi -dmenu -i -p Search shortcuts' >/dev/null; then
    pkill -f 'rofi -dmenu -i -p Search shortcuts'
    exit 0
fi

hyprctl binds -j | python3 -c '
import json
import sys

binds = json.load(sys.stdin)

MODS = [
    (1, "SHIFT"),
    (4, "CTRL"),
    (8, "ALT"),
    (64, "SUPER"),
]

KEY_NAMES = {
    "slash": "/",
    "left": "LEFT",
    "right": "RIGHT",
    "up": "UP",
    "down": "DOWN",
    "mouse_down": "MOUSE WHEEL DOWN",
    "mouse_up": "MOUSE WHEEL UP",
}

rows = []

for bind in binds:
    if not bind.get("has_description"):
        continue

    description = bind.get("description", "").strip()
    key = bind.get("key", "").strip()
    modmask = bind.get("modmask", 0)

    if not description or not key:
        continue

    mods = [name for bit, name in MODS if modmask & bit]
    key_display = KEY_NAMES.get(key, key.upper())

    shortcut = " + ".join(mods + [key_display]) if mods else key_display
    rows.append(f"{shortcut:<28} {description}")

print("\n".join(rows))
' | rofi -dmenu -i -p "Search shortcuts"
