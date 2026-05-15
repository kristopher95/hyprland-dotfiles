#!/usr/bin/env bash
set -euo pipefail

SIGNAL=8

socket="${XDG_RUNTIME_DIR}/hypr/${HYPRLAND_INSTANCE_SIGNATURE}/.socket2.sock"

if [[ ! -S "$socket" ]]; then
  exit 1
fi

socat -U - UNIX-CONNECT:"$socket" | while read -r event; do
  case "$event" in
    workspace*|focusedmon*|moveworkspace*|renameworkspace*|destroyworkspace*|createworkspace*)
      pkill -RTMIN+"$SIGNAL" waybar 2>/dev/null || true
      ;;
  esac
done
