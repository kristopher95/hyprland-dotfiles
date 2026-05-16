#!/usr/bin/env bash
set -euo pipefail

# Spotify-only smooth wave indicator for Waybar.
# This is NOT system audio.
# It only shows animation when Spotify is playing.
# It reads Spotify status/volume using playerctl.

levels=("▁" "▂" "▃" "▄" "▅" "▆" "▇" "█")

status="Stopped"
volume_percent=0
tick=0

get_spotify_state() {
    if ! playerctl -p spotify status >/dev/null 2>&1; then
        status="Stopped"
        volume_percent=0
        return
    fi

    status="$(playerctl -p spotify status 2>/dev/null || echo "Stopped")"
    volume_raw="$(playerctl -p spotify volume 2>/dev/null || echo 0)"

    volume_percent="$(awk -v v="$volume_raw" 'BEGIN { printf "%d", v * 100 }')"

    if (( volume_percent < 0 )); then
        volume_percent=0
    elif (( volume_percent > 100 )); then
        volume_percent=100
    fi
}

make_wave() {
    if [[ "$status" != "Playing" ]]; then
        printf '{"text":"▁▁▁▁▁▁▁▁","tooltip":"Spotify paused/stopped"}\n'
        return
    fi

    if (( volume_percent <= 10 )); then
        max_level=2
    elif (( volume_percent <= 25 )); then
        max_level=3
    elif (( volume_percent <= 45 )); then
        max_level=4
    elif (( volume_percent <= 65 )); then
        max_level=5
    elif (( volume_percent <= 85 )); then
        max_level=6
    else
        max_level=7
    fi

    wave=""

    for i in {1..10}; do
        n=$(( RANDOM % (max_level + 1) ))

        if (( n == 0 && volume_percent > 15 )); then
            n=1
        fi

        wave+="${levels[$n]}"
    done

    printf '{"text":"%s","tooltip":"Spotify volume: %s%%"}\n' "$wave" "$volume_percent"
}

get_spotify_state

while true; do
    # Refresh Spotify state every ~1 second, but animate faster between checks.
    if (( tick % 8 == 0 )); then
        get_spotify_state
    fi

    make_wave

    tick=$((tick + 1))

    # Lower = smoother but more CPU.
    # 0.12 = about 8 updates/sec.
    sleep 0.12
done
