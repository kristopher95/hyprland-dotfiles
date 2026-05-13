# Hyprland Dotfiles — Full Install Guide From Zero / When my PC explodes

This repo is my full Hyprland desktop setup for Arch/CachyOS-style systems.

It includes:

- Hyprland config
- Waybar top panels for dual monitors
- Eww calendar/volume popups
- Independent monitor workspaces
- Per-workspace planet wallpapers
- Spotify controls + visualizer in Waybar
- Audio input/output selector popup
- Power menu with lock/sleep/restart/shutdown
- Hyprlock config
- Helper scripts

This guide assumes you are starting from a blank-ish Arch/CachyOS install and want to recreate the full layout.

Repo:

https://github.com/kristopher95/hyprland-dotfiles

=====================================================================
1. SYSTEM REQUIREMENTS
=====================================================================

Recommended base:

- Arch Linux / CachyOS / EndeavourOS
- Hyprland session
- PipeWire audio
- NVIDIA or AMD GPU
- Two-monitor setup recommended:
  - DP-3 = main ultrawide 3440x1440
  - DP-1 = secondary 2560x1440

This setup is currently tuned for:

Main monitor:
  DP-3, 3440x1440, positioned to the right

Secondary monitor:
  DP-1, 2560x1440, positioned to the left

If your monitor names differ, you must edit:

~/.config/hypr/hyprland.conf
~/.config/waybar/config-main.jsonc
~/.config/waybar/config-secondary.jsonc
~/.scripts/switch_workspace_by_monitor.sh
~/.scripts/move_window_to_workspace_by_monitor.sh
~/.scripts/set_workspace_wallpaper.sh
~/.scripts/toggle_calendar.sh

Check your monitor names with:

hyprctl monitors

=====================================================================
2. INSTALL REQUIRED PACKAGES
=====================================================================

Run:

sudo pacman -Syu

sudo pacman -S \
  hyprland \
  hyprlock \
  hypridle \
  waybar \
  eww \
  rofi \
  kitty \
  alacritty \
  dolphin \
  kate \
  jq \
  socat \
  playerctl \
  cava \
  pamixer \
  pavucontrol \
  pipewire \
  pipewire-pulse \
  wireplumber \
  pipewire-alsa \
  pipewire-jack \
  mako \
  notify-send \
  lm_sensors \
  git \
  curl \
  wget \
  unzip \
  brightnessctl \
  network-manager-applet \
  bluez \
  bluez-utils \
  papirus-icon-theme \
  ttf-jetbrains-mono-nerd \
  ttf-font-awesome \
  awww

If notify-send is not found, install libnotify:

sudo pacman -S libnotify

If eww is not available from pacman on your system, install it from AUR:

yay -S eww

If awww is not available from pacman:

yay -S awww

Spotify support requires Spotify. On CachyOS/Arch, install one of these:

sudo pacman -S spotify-launcher

or:

yay -S spotify

This config expects:

spotify-launcher

Check:

command -v spotify-launcher

=====================================================================
3. ENABLE BASIC SERVICES
=====================================================================

Enable Bluetooth if you use it:

sudo systemctl enable --now bluetooth

Enable NetworkManager if needed:

sudo systemctl enable --now NetworkManager

PipeWire should usually already be handled by your user session, but you can check:

systemctl --user status pipewire pipewire-pulse wireplumber

=====================================================================
4. CLONE THE REPO
=====================================================================

Go to your home folder:

cd ~

Clone the repo:

git clone https://github.com/kristopher95/hyprland-dotfiles.git

Enter it:

cd ~/Hyprland-dotfiles

=====================================================================
5. BACK UP EXISTING CONFIGS
=====================================================================

Run this before copying anything:

mkdir -p ~/dotfiles-backup

cp -r ~/.config/hypr ~/dotfiles-backup/hypr 2>/dev/null
cp -r ~/.config/waybar ~/dotfiles-backup/waybar 2>/dev/null
cp -r ~/.config/eww ~/dotfiles-backup/eww 2>/dev/null
cp -r ~/.config/mako ~/dotfiles-backup/mako 2>/dev/null
cp -r ~/.scripts ~/dotfiles-backup/scripts 2>/dev/null

=====================================================================
6. CREATE NEEDED DIRECTORIES
=====================================================================

mkdir -p ~/.config/hypr
mkdir -p ~/.config/waybar/scripts
mkdir -p ~/.config/eww/scripts
mkdir -p ~/.config/mako
mkdir -p ~/.scripts
mkdir -p ~/Pictures/wallpapers/planets
mkdir -p ~/.cache/awww

=====================================================================
7. COPY CONFIG FILES
=====================================================================

From inside the repo:

cd ~/Hyprland-dotfiles

Copy Hyprland config:

cp hypr/hyprland.conf ~/.config/hypr/hyprland.conf
cp hypr/hyprlock.conf ~/.config/hypr/hyprlock.conf 2>/dev/null

Copy Waybar configs:

cp waybar/config-main.jsonc ~/.config/waybar/config-main.jsonc
cp waybar/config-secondary.jsonc ~/.config/waybar/config-secondary.jsonc
cp waybar/config.jsonc ~/.config/waybar/config.jsonc 2>/dev/null
cp waybar/style.css ~/.config/waybar/style.css

Copy Waybar scripts:

cp waybar/scripts/* ~/.config/waybar/scripts/ 2>/dev/null

Copy Eww configs:

cp eww/eww.yuck ~/.config/eww/eww.yuck
cp eww/eww.scss ~/.config/eww/eww.scss

Copy Eww scripts:

cp eww/scripts/* ~/.config/eww/scripts/ 2>/dev/null

Copy general scripts:

cp scripts/* ~/.scripts/ 2>/dev/null

Make scripts executable:

chmod +x ~/.config/waybar/scripts/* 2>/dev/null
chmod +x ~/.config/eww/scripts/* 2>/dev/null
chmod +x ~/.scripts/* 2>/dev/null

=====================================================================
8. WALLPAPERS
=====================================================================

This setup expects 8 planet wallpapers here:

~/Pictures/wallpapers/planets/

The required filenames are:

1-mercury.png
2-venus.png
3-earth.png
4-mars.png
5-jupiter.png
6-saturn.png
7-uranus.png
8-neptune.png

Create the folder:

mkdir -p ~/Pictures/wallpapers/planets

Put your wallpapers in that folder and make sure the names are exactly:

~/Pictures/wallpapers/planets/1-mercury.png
~/Pictures/wallpapers/planets/2-venus.png
~/Pictures/wallpapers/planets/3-earth.png
~/Pictures/wallpapers/planets/4-mars.png
~/Pictures/wallpapers/planets/5-jupiter.png
~/Pictures/wallpapers/planets/6-saturn.png
~/Pictures/wallpapers/planets/7-uranus.png
~/Pictures/wallpapers/planets/8-neptune.png

Check:

ls -lh ~/Pictures/wallpapers/planets

=====================================================================
9. MONITOR SETUP
=====================================================================

Check your monitor names:

hyprctl monitors

This setup expects:

DP-1 = secondary monitor
DP-3 = main ultrawide monitor

In ~/.config/hypr/hyprland.conf, the monitor section should look like this:

monitor = DP-1,2560x1440@59.95,0x0,1
monitor = DP-3,3440x1440@143.97,2560x0,1

If your monitor names or resolutions are different, edit them.

Open:

kate ~/.config/hypr/hyprland.conf

Then adjust the monitor lines.

=====================================================================
10. INDEPENDENT MONITOR WORKSPACES
=====================================================================

This config uses separate workspace sets per monitor:

Main ultrawide DP-3:
  Workspaces 1-8

Secondary DP-1:
  Workspaces 11-18

Visually, Waybar still shows 1-8 on both monitors.

The scripts that handle this are:

~/.scripts/switch_workspace_by_monitor.sh
~/.scripts/move_window_to_workspace_by_monitor.sh

The logic assumes:

DP-1 is on the left:
  x < 2560

DP-3 is on the right:
  x >= 2560

If your layout is different, edit these scripts.

Test current cursor position:

hyprctl cursorpos

Test monitors:

hyprctl monitors

=====================================================================
11. WAYBAR SETUP
=====================================================================

This layout uses two Waybar instances:

Main monitor:

~/.config/waybar/config-main.jsonc

Secondary monitor:

~/.config/waybar/config-secondary.jsonc

Start both manually:

pkill waybar

waybar -c ~/.config/waybar/config-main.jsonc -s ~/.config/waybar/style.css &
waybar -c ~/.config/waybar/config-secondary.jsonc -s ~/.config/waybar/style.css &

If Waybar fails, test one at a time:

waybar -c ~/.config/waybar/config-main.jsonc -s ~/.config/waybar/style.css

or:

waybar -c ~/.config/waybar/config-secondary.jsonc -s ~/.config/waybar/style.css

Common JSON error:
  Missing comma before a module block
  Extra comma before final }

=====================================================================
12. EWW POPUPS
=====================================================================

This setup uses Eww for:

- Calendar popup
- Volume popup
- Audio output/input selector

Start Eww:

eww daemon &

Reload Eww:

eww reload

Test windows:

eww open fancy_calendar
eww close fancy_calendar

eww open volume_popup
eww close volume_popup

If Eww complains about primary monitor, open explicitly:

eww open fancy_calendar --screen 0
eww open fancy_calendar --screen 1

The click scripts are:

~/.scripts/toggle_calendar.sh
~/.scripts/toggle_volume.sh

These are used by Waybar.

=====================================================================
13. AUDIO POPUP SETUP
=====================================================================

The audio popup uses:

pamixer
pavucontrol
pactl

Scripts:

~/.config/eww/scripts/audio_outputs.sh
~/.config/eww/scripts/audio_inputs.sh
~/.config/eww/scripts/set_audio_output.sh
~/.config/eww/scripts/set_audio_input.sh

Test:

~/.config/eww/scripts/audio_outputs.sh
~/.config/eww/scripts/audio_inputs.sh

You should see Eww markup with your audio devices.

Open the popup by clicking the volume module in Waybar.

Right-click volume opens:

pavucontrol

=====================================================================
14. SPOTIFY WIDGET
=====================================================================

The Waybar Spotify widget includes:

- Spotify open/hide button
- Previous track
- Play/pause
- Next track
- Spotify volume down
- Spotify volume display
- Spotify volume up
- Scrolling song title
- CAVA audio bars

Required packages:

playerctl
cava
spotify-launcher

Install:

sudo pacman -S playerctl cava spotify-launcher

Test Spotify metadata:

playerctl -p spotify metadata --format '{{ artist }} - {{ title }}'

Test CAVA:

cava

Press q to quit.

Test scripts:

~/.config/waybar/scripts/spotify_status.sh
~/.config/waybar/scripts/spotify_title.sh
~/.config/waybar/scripts/spotify_volume.sh

Test audio bars:

~/.config/waybar/scripts/audio_bars.sh

Press CTRL+C to stop.

The Spotify show/hide script is:

~/.scripts/toggle_spotify.sh

Test:

~/.scripts/toggle_spotify.sh

Expected behavior:

- If Spotify is closed, it opens Spotify
- If Spotify is open but hidden, it brings it back
- If Spotify is focused, it hides it to special:spotify

If Spotify does not launch, check:

command -v spotify-launcher

The script expects:

/usr/bin/spotify-launcher

=====================================================================
15. POWER MENU
=====================================================================

Waybar power button uses:

~/.config/waybar/power_menu.xml

Expected actions:

- Lock
- Sleep
- Restart
- Shutdown

Lock uses:

hyprlock

Test:

hyprlock

If the power menu does not show Lock, check:

grep -RIn "menu-actions\|lock\|hyprlock" ~/.config/waybar

=====================================================================
16. NOTIFICATION DAEMON
=====================================================================

This setup uses mako.

Check:

pgrep -a mako

If not installed:

sudo pacman -S mako libnotify

Enable/start:

systemctl --user enable --now mako

Test:

notify-send "Test notification" "Mako is working."

If Dunst conflicts with Mako:

systemctl --user disable --now dunst 2>/dev/null
systemctl --user enable --now mako

=====================================================================
17. CPU/RAM/GPU TRACKERS
=====================================================================

Waybar uses custom scripts for system tracking.

Scripts are in:

~/.config/waybar/scripts/

Main monitor usually uses full versions:

ram.sh
cpu.sh
gpu.sh

Secondary monitor usually uses compact versions:

ram_compact.sh
cpu_compact.sh
gpu_compact.sh

CPU temperature requires lm_sensors:

sudo pacman -S lm_sensors

Run detection:

sudo sensors-detect

Accept defaults.

Test:

sensors

CPU script:

~/.config/waybar/scripts/cpu.sh

RAM script:

~/.config/waybar/scripts/ram.sh

GPU script:

~/.config/waybar/scripts/gpu.sh

For NVIDIA GPU process monitoring:

nvidia-smi
nvidia-smi pmon -c 1

Optional better live GPU monitor:

sudo pacman -S nvtop
nvtop

=====================================================================
18. AUTOSTART
=====================================================================

Your Hyprland config should launch important pieces using exec-once.

Check:

grep -n "exec-once" ~/.config/hypr/hyprland.conf

You generally want things like:

exec-once = mako
exec-once = eww daemon
exec-once = waybar -c ~/.config/waybar/config-main.jsonc -s ~/.config/waybar/style.css
exec-once = waybar -c ~/.config/waybar/config-secondary.jsonc -s ~/.config/waybar/style.css
exec-once = ~/.scripts/workspace_wallpaper_daemon.sh

If Waybar duplicates after reloads, kill and restart:

pkill waybar

waybar -c ~/.config/waybar/config-main.jsonc -s ~/.config/waybar/style.css &
waybar -c ~/.config/waybar/config-secondary.jsonc -s ~/.config/waybar/style.css &

=====================================================================
19. WALLPAPER DAEMON
=====================================================================

This setup uses awww.

Check:

command -v awww
command -v awww-daemon

Start manually:

pkill awww-daemon 2>/dev/null
pkill -f workspace_wallpaper_daemon.sh 2>/dev/null

awww-daemon &
sleep 1

~/.scripts/workspace_wallpaper_daemon.sh &

Test one wallpaper manually:

awww img ~/Pictures/wallpapers/planets/1-mercury.png

If workspace wallpapers do not change, restart:

rm -rf /tmp/workspace_wallpaper_cache
rm -f /tmp/current_workspace_wallpaper

pkill -f workspace_wallpaper_daemon.sh 2>/dev/null
pkill -f "socat -U - UNIX-CONNECT" 2>/dev/null

~/.scripts/workspace_wallpaper_daemon.sh &

=====================================================================
20. HYPRLAND RELOAD
=====================================================================

Reload Hyprland:

hyprctl reload

If something breaks badly, log out and log back in.

If Hyprland config has errors:

hyprctl reload

Then read the error popup or run:

hyprctl monitors

=====================================================================
21. OPTIONAL ICLOUD CALENDAR / THUNDERBIRD
=====================================================================

The Eww scheduler popup was removed.

Recommended calendar app:

Thunderbird Calendar

For iCloud Calendar, use CalDAV, not ICS.

CalDAV = two-way sync
ICS = read-only

Thunderbird setup:

Calendar → New Calendar → On the Network

Use exact iCloud CalDAV URLs if auto-discovery fails.

Example Home calendar URL:

https://pXX-caldav.icloud.com/ACCOUNT_ID/calendars/home/

Username:

your-icloud-email@example.com

Password:

Apple app-specific password

Do not use your normal Apple password.

If Thunderbird fails, clear saved bad passwords:

Thunderbird:
Settings → Privacy & Security → Passwords → Saved Passwords

Delete anything related to:

icloud
caldav
pXX-caldav.icloud.com
caldav.icloud.com

Then restart Thunderbird:

pkill thunderbird

If using vdirsyncer/khal separately, do not commit secrets to GitHub.

Never commit:

~/.config/vdirsyncer/secrets/icloud_password
~/.config/vdirsyncer/config
~/.vdirsyncer/
~/.calendars/

=====================================================================
22. CLEAN RESTART COMMANDS
=====================================================================

Full panel/widget restart:

pkill waybar
pkill eww

eww daemon &
sleep 1
eww reload

waybar -c ~/.config/waybar/config-main.jsonc -s ~/.config/waybar/style.css &
waybar -c ~/.config/waybar/config-secondary.jsonc -s ~/.config/waybar/style.css &

Restart wallpaper daemon:

pkill awww-daemon 2>/dev/null
pkill -f workspace_wallpaper_daemon.sh 2>/dev/null
pkill -f "socat -U - UNIX-CONNECT" 2>/dev/null

awww-daemon &
sleep 1
~/.scripts/workspace_wallpaper_daemon.sh &

Reload Hyprland:

hyprctl reload

=====================================================================
23. COMMON FIXES
=====================================================================

Problem:
Waybar does not start.

Run:

waybar -c ~/.config/waybar/config-main.jsonc -s ~/.config/waybar/style.css

Fix JSON commas/brackets.

Problem:
Eww popup opens on wrong monitor.

Edit:

~/.scripts/toggle_calendar.sh
~/.scripts/toggle_volume.sh

Eww screen IDs may be reversed compared to Hyprland monitor IDs.

Problem:
Spotify button does not open Spotify.

Check:

command -v spotify-launcher

Make sure toggle script uses:

spotify-launcher

Problem:
Spotify metadata does not show.

Make sure Spotify is running and playing/paused:

playerctl -p spotify status
playerctl -p spotify metadata --format '{{ artist }} - {{ title }}'

Problem:
Audio bars spam broken pipe.

Use the fixed audio_bars.sh with:

trap 'exit 0' PIPE

Problem:
Wrong planet on workspace.

Rename wallpapers:

1-mercury.png
2-venus.png
3-earth.png
4-mars.png
5-jupiter.png
6-saturn.png
7-uranus.png
8-neptune.png

Then clear cache:

rm -rf /tmp/workspace_wallpaper_cache
rm -f /tmp/current_workspace_wallpaper

Problem:
Secondary monitor shows workspace 18 on main bar.

Make sure Waybar has:

"all-outputs": false

in both config-main.jsonc and config-secondary.jsonc.

Problem:
Workspaces switch on wrong monitor.

Check:

hyprctl cursorpos
hyprctl monitors

Then edit:

~/.scripts/switch_workspace_by_monitor.sh
~/.scripts/move_window_to_workspace_by_monitor.sh

=====================================================================
24. UPDATE THIS REPO AFTER CHANGES
=====================================================================

After changing local configs, copy them back into the repo:

cd ~/Hyprland-dotfiles

cp ~/.config/hypr/hyprland.conf hypr/hyprland.conf
cp ~/.config/hypr/hyprlock.conf hypr/hyprlock.conf 2>/dev/null

cp ~/.config/waybar/config-main.jsonc waybar/config-main.jsonc
cp ~/.config/waybar/config-secondary.jsonc waybar/config-secondary.jsonc
cp ~/.config/waybar/config.jsonc waybar/config.jsonc 2>/dev/null
cp ~/.config/waybar/style.css waybar/style.css
cp ~/.config/waybar/scripts/* waybar/scripts/ 2>/dev/null

cp ~/.config/eww/eww.yuck eww/eww.yuck
cp ~/.config/eww/eww.scss eww/eww.scss
cp ~/.config/eww/scripts/* eww/scripts/ 2>/dev/null

cp ~/.scripts/* scripts/ 2>/dev/null

git status

git add .

git commit -m "Update Hyprland dotfiles"

git push

Confirm:

git status

Expected:

nothing to commit, working tree clean

=====================================================================
25. DO NOT COMMIT SECRETS
=====================================================================

Do not add these to GitHub:

~/.config/vdirsyncer/secrets/
~/.config/vdirsyncer/config
~/.vdirsyncer/
~/.calendars/
~/.ssh/
~/.gnupg/
~/.config/Element/
~/.mozilla/
~/.local/share/keyrings/

If unsure, check before committing:

git status

=====================================================================
26. QUICK INSTALL SUMMARY
=====================================================================

For a fresh setup, the minimum flow is:

sudo pacman -Syu

sudo pacman -S hyprland hyprlock waybar eww rofi kitty jq socat playerctl cava pamixer pavucontrol pipewire pipewire-pulse wireplumber mako libnotify lm_sensors git awww spotify-launcher ttf-jetbrains-mono-nerd papirus-icon-theme

cd ~
git clone https://github.com/kristopher95/hyprland-dotfiles.git
cd ~/Hyprland-dotfiles

mkdir -p ~/.config/hypr ~/.config/waybar/scripts ~/.config/eww/scripts ~/.scripts ~/Pictures/wallpapers/planets ~/.cache/awww

cp hypr/hyprland.conf ~/.config/hypr/hyprland.conf
cp hypr/hyprlock.conf ~/.config/hypr/hyprlock.conf 2>/dev/null

cp waybar/config-main.jsonc ~/.config/waybar/config-main.jsonc
cp waybar/config-secondary.jsonc ~/.config/waybar/config-secondary.jsonc
cp waybar/style.css ~/.config/waybar/style.css
cp waybar/scripts/* ~/.config/waybar/scripts/ 2>/dev/null

cp eww/eww.yuck ~/.config/eww/eww.yuck
cp eww/eww.scss ~/.config/eww/eww.scss
cp eww/scripts/* ~/.config/eww/scripts/ 2>/dev/null

cp scripts/* ~/.scripts/ 2>/dev/null

chmod +x ~/.config/waybar/scripts/* 2>/dev/null
chmod +x ~/.config/eww/scripts/* 2>/dev/null
chmod +x ~/.scripts/* 2>/dev/null

systemctl --user enable --now mako

eww daemon &
eww reload

waybar -c ~/.config/waybar/config-main.jsonc -s ~/.config/waybar/style.css &
waybar -c ~/.config/waybar/config-secondary.jsonc -s ~/.config/waybar/style.css &

awww-daemon &
~/.scripts/workspace_wallpaper_daemon.sh &

hyprctl reload

Then add your wallpapers into:

~/Pictures/wallpapers/planets/

with the exact names:

1-mercury.png
2-venus.png
3-earth.png
4-mars.png
5-jupiter.png
6-saturn.png
7-uranus.png
8-neptune.png
