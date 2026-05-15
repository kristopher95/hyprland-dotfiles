#!/usr/bin/env bash
set -euo pipefail

num="${1:-}"

case "$num" in
  1|2|3|4|5|6|7|8) ;;
  *)
    echo "Usage: $0 <1-8>"
    exit 1
    ;;
esac

active_monitor="$(
  hyprctl monitors | awk '
    /^Monitor / {
      current = $2
    }

    /focused: yes/ {
      print current
      exit
    }
  '
)"

if [[ "$active_monitor" == "DP-1" ]]; then
  target_ws=$((10 + num))
else
  target_ws="$num"
fi

# IMPORTANT:
# This moves the active window only.
# This should only be called by SUPER + SHIFT + number.
hyprctl dispatch "hl.dsp.window.move({ workspace = \"$target_ws\", follow = false })"

# Instantly refresh Waybar workspace buttons.
pkill -RTMIN+8 waybar 2>/dev/null || true
