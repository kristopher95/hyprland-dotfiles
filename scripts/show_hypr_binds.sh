#!/usr/bin/env bash

if pgrep -f 'rofi -dmenu -i -p Search shortcuts' >/dev/null; then
    pkill -f 'rofi -dmenu -i -p Search shortcuts'
    exit 0
fi

cat <<'EOF' | rofi -dmenu -i -p "Search shortcuts"
SUPER + /                         Show this cheatsheet

SUPER + Q                         Open terminal
SUPER + C                         Close window
SUPER + M                         Power / exit menu
SUPER + E                         Open file manager
SUPER + B                         Open Firefox
SUPER + R                         Open app launcher
SUPER + L                         Lock screen

SUPER + F                         Toggle fullscreen
SUPER + V                         Toggle floating
SUPER + P                         Toggle pseudotile
SUPER + J                         Toggle split

SUPER + LEFT                      Focus left
SUPER + RIGHT                     Focus right
SUPER + UP                        Focus up
SUPER + DOWN                      Focus down

SUPER + SHIFT + LEFT              Resize window smaller width
SUPER + SHIFT + RIGHT             Resize window larger width
SUPER + SHIFT + UP                Resize window shorter height
SUPER + SHIFT + DOWN              Resize window taller height

SUPER + 1                         Switch workspace 1
SUPER + 2                         Switch workspace 2
SUPER + 3                         Switch workspace 3
SUPER + 4                         Switch workspace 4
SUPER + 5                         Switch workspace 5
SUPER + 6                         Switch workspace 6
SUPER + 7                         Switch workspace 7
SUPER + 8                         Switch workspace 8

SUPER + SHIFT + 1                 Move window to workspace 1
SUPER + SHIFT + 2                 Move window to workspace 2
SUPER + SHIFT + 3                 Move window to workspace 3
SUPER + SHIFT + 4                 Move window to workspace 4
SUPER + SHIFT + 5                 Move window to workspace 5
SUPER + SHIFT + 6                 Move window to workspace 6
SUPER + SHIFT + 7                 Move window to workspace 7
SUPER + SHIFT + 8                 Move window to workspace 8

SUPER + MOUSE WHEEL DOWN          Next workspace
SUPER + MOUSE WHEEL UP            Previous workspace
SUPER + LEFT CLICK                Move window with mouse
SUPER + RIGHT CLICK               Resize window with mouse

SUPER + SHIFT + S                 Screenshot selected area

VOLUME UP                         Raise volume
VOLUME DOWN                       Lower volume
VOLUME MUTE                       Mute volume
MIC MUTE                          Mute microphone
BRIGHTNESS UP                     Raise brightness
BRIGHTNESS DOWN                   Lower brightness

MEDIA NEXT                        Next track
MEDIA PLAY / PAUSE                Play or pause
MEDIA PREVIOUS                    Previous track
EOF
