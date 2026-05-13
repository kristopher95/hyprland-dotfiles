#!/usr/bin/env bash

# Exit quietly if Waybar closes the pipe.
trap 'exit 0' PIPE

config="/tmp/waybar_cava_config"

cat > "$config" <<'EOF'
[general]
bars = 10
framerate = 18
autosens = 1
sensitivity = 100

[input]
method = pulse
source = auto

[output]
method = raw
raw_target = /dev/stdout
data_format = ascii
ascii_max_range = 7
bar_delimiter = 0
EOF

cava -p "$config" 2>/dev/null | while read -r line; do
    [[ -z "$line" ]] && continue

    out=""

    for (( i=0; i<${#line}; i++ )); do
        char="${line:i:1}"

        case "$char" in
            0) out="${out}▁" ;;
            1) out="${out}▂" ;;
            2) out="${out}▃" ;;
            3) out="${out}▄" ;;
            4) out="${out}▅" ;;
            5) out="${out}▆" ;;
            6) out="${out}▇" ;;
            7) out="${out}█" ;;
            *) out="${out}▁" ;;
        esac
    done

    echo "$out" || exit 0
done
