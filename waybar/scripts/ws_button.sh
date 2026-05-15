#!/usr/bin/env bash
set -euo pipefail

ws="${1:-}"
label="${2:-$ws}"

case "$ws" in
  1|2|3|4|5|6|7|8)
    monitor="DP-3"
    ;;
  11|12|13|14|15|16|17|18)
    monitor="DP-1"
    ;;
  *)
    printf '{"text":"?","tooltip":"Invalid workspace"}\n'
    exit 0
    ;;
esac

active_ws="$(
  hyprctl monitors | awk -v target="$monitor" '
    /^Monitor / {
      current = $2
    }

    current == target && /active workspace:/ {
      print $3
      exit
    }
  '
)"

if [[ "$active_ws" == "$ws" ]]; then
  text="<span foreground='#11111b' background='#89b4fa' weight='bold'> $label </span>"
else
  text="<span foreground='#a6adc8'> $label </span>"
fi

printf '{"text":"%s","tooltip":"Workspace %s"}\n' "$text" "$ws"
