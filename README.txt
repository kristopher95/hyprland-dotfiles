# Hyprland Dotfiles — Zero Install Guide

This repository contains my personal Hyprland desktop setup for an Arch/CachyOS/EndeavourOS-style Linux system.

The purpose of this README is simple: if I reinstall Linux from zero, these instructions should let me restore the full Hyprland setup from scratch.

This setup includes Hyprland Lua configuration, dual-monitor Waybar panels, independent monitor workspaces, custom clickable Waybar workspace buttons, active workspace highlighting, CPU usage and temperature, RAM, GPU, disk and network on the main monitor, volume, tray, power menu, Rofi, Kitty, Mako, Eww, Hyprlock, Hypridle, and helper scripts.

---

# Target System

This setup is intended for:

```text
CachyOS / Arch / EndeavourOS
Hyprland 0.55+
Wayland
NVIDIA GPU
Dual monitor desktop
```

This is not a universal Hyprland framework. It is personalized for my monitor layout, scripts, keybinds, and workflow.

---

# Monitor Layout

This setup expects this monitor layout:

```text
DP-1 = secondary monitor
Resolution: 2560x1440
Position: left
Workspaces: 11-18

DP-3 = main ultrawide monitor
Resolution: 3440x1440
Position: right
Workspaces: 1-8
```

Hyprland monitor positioning:

```text
DP-1 starts at 0x0
DP-3 starts at 2560x0
```

If monitor names are different on a fresh install, check them with:

```bash
hyprctl monitors
```

Then update these files:

```text
~/.config/hypr/hyprland.lua
~/.config/waybar/config-main.jsonc
~/.config/waybar/config-secondary.jsonc
~/.scripts/switch_workspace_by_monitor.sh
~/.scripts/move_window_to_workspace_by_monitor.sh
~/.config/waybar/scripts/ws_button.sh
```

---

# Repository Structure

```text
hyprland-dotfiles/
├── hypr/
│   ├── hyprland.lua
│   ├── hypridle.conf
│   ├── hyprlock.conf
│   ├── hyprpaper.conf
│   └── hyprland.conf.legacy
├── waybar/
│   ├── config-main.jsonc
│   ├── config-secondary.jsonc
│   ├── style.css
│   ├── power_menu.xml
│   └── scripts/
│       ├── ws_button.sh
│       ├── cpu_status.sh
│       ├── gpu_compact.sh
│       ├── ram_compact.sh
│       └── cpu_compact.sh
├── scripts/
│   ├── switch_workspace_by_monitor.sh
│   ├── move_window_to_workspace_by_monitor.sh
│   ├── show_hypr_binds.sh
│   ├── toggle_rofi_drun.sh
│   ├── toggle_calendar.sh
│   └── toggle_volume.sh
├── rofi/
├── kitty/
├── mako/
└── eww/
```

---

# 1. Update the System

On CachyOS, Arch, or EndeavourOS:

```bash
sudo pacman -Syu
```

---

# 2. Install Required Packages

Install the core packages:

```bash
sudo pacman -S \
  git \
  base-devel \
  hyprland \
  hyprlock \
  hypridle \
  waybar \
  rofi \
  kitty \
  dolphin \
  kate \
  jq \
  socat \
  playerctl \
  pamixer \
  pavucontrol \
  pipewire \
  pipewire-pulse \
  pipewire-alsa \
  pipewire-jack \
  wireplumber \
  mako \
  libnotify \
  lm_sensors \
  curl \
  wget \
  unzip \
  brightnessctl \
  network-manager-applet \
  grim \
  slurp \
  wl-clipboard \
  papirus-icon-theme \
  ttf-jetbrains-mono-nerd \
  ttf-font-awesome \
  nvidia-utils
```

If a package is unavailable, install the rest first and handle the missing package afterward.

---

# 3. Install yay If Needed

If `yay` is not installed:

```bash
cd ~

git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
```

Then install Eww if it is not available in the normal repos:

```bash
yay -S eww
```

If Eww is available through pacman, this may work instead:

```bash
sudo pacman -S eww
```

---

# 4. Enable PipeWire Audio

Enable PipeWire services:

```bash
systemctl --user enable --now pipewire pipewire-pulse wireplumber
```

Check audio:

```bash
pactl info
```

Open the audio mixer:

```bash
pavucontrol
```

---

# 5. Set Up CPU Temperature Sensors

Install sensors:

```bash
sudo pacman -S lm_sensors
```

Detect sensors:

```bash
sudo sensors-detect --auto
```

Test:

```bash
sensors
```

The CPU module expects sensors output such as:

```text
Tctl
Package id 0
CPU
```

The script will try to read from those common labels.

---

# 6. Check NVIDIA Tools

For NVIDIA GPU stats, check:

```bash
nvidia-smi
```

If missing:

```bash
sudo pacman -S nvidia-utils
```

The Waybar GPU script expects `nvidia-smi` on NVIDIA systems.

---

# 7. Clone This Repo

Clone the repo:

```bash
cd ~

git clone https://github.com/kristopher95/hyprland-dotfiles.git
```

Enter the repo:

```bash
cd ~/hyprland-dotfiles
```

Optional: rename it to my usual folder name:

```bash
cd ~
mv ~/hyprland-dotfiles ~/Hyprland-dotfiles
cd ~/Hyprland-dotfiles
```

---

# 8. Back Up Existing Configs

Before installing, back up any existing config files:

```bash
mkdir -p ~/dotfiles-backup

cp -r ~/.config/hypr ~/dotfiles-backup/hypr 2>/dev/null || true
cp -r ~/.config/waybar ~/dotfiles-backup/waybar 2>/dev/null || true
cp -r ~/.config/eww ~/dotfiles-backup/eww 2>/dev/null || true
cp -r ~/.config/rofi ~/dotfiles-backup/rofi 2>/dev/null || true
cp -r ~/.config/kitty ~/dotfiles-backup/kitty 2>/dev/null || true
cp -r ~/.config/mako ~/dotfiles-backup/mako 2>/dev/null || true
cp -r ~/.scripts ~/dotfiles-backup/scripts 2>/dev/null || true
```

---

# 9. Create Required Folders

Create the required config folders:

```bash
mkdir -p ~/.config/hypr
mkdir -p ~/.config/waybar/scripts
mkdir -p ~/.config/eww
mkdir -p ~/.config/rofi
mkdir -p ~/.config/kitty
mkdir -p ~/.config/mako
mkdir -p ~/.scripts
mkdir -p ~/Pictures/Screenshots
mkdir -p ~/Pictures/wallpapers
```

---

# 10. Install the Dotfiles

From inside the repo:

```bash
cd ~/Hyprland-dotfiles
```

Copy Hyprland files:

```bash
cp hypr/hyprland.lua ~/.config/hypr/hyprland.lua
cp hypr/hypridle.conf ~/.config/hypr/hypridle.conf 2>/dev/null || true
cp hypr/hyprlock.conf ~/.config/hypr/hyprlock.conf 2>/dev/null || true
cp hypr/hyprpaper.conf ~/.config/hypr/hyprpaper.conf 2>/dev/null || true
```

Copy Waybar files:

```bash
cp waybar/config-main.jsonc ~/.config/waybar/config-main.jsonc
cp waybar/config-secondary.jsonc ~/.config/waybar/config-secondary.jsonc
cp waybar/style.css ~/.config/waybar/style.css
cp waybar/power_menu.xml ~/.config/waybar/power_menu.xml 2>/dev/null || true
cp -r waybar/scripts/. ~/.config/waybar/scripts/
```

Copy helper scripts:

```bash
cp -r scripts/. ~/.scripts/
```

Copy Rofi files:

```bash
cp -r rofi/. ~/.config/rofi/ 2>/dev/null || true
```

Copy Kitty files:

```bash
cp -r kitty/. ~/.config/kitty/ 2>/dev/null || true
```

Copy Mako files:

```bash
cp -r mako/. ~/.config/mako/ 2>/dev/null || true
```

Copy Eww files:

```bash
cp -r eww/. ~/.config/eww/ 2>/dev/null || true
```

Make scripts executable:

```bash
chmod +x ~/.scripts/* 2>/dev/null || true
chmod +x ~/.config/waybar/scripts/* 2>/dev/null || true
chmod +x ~/.config/eww/scripts/* 2>/dev/null || true
```

---

# 11. Start Hyprland

Log out and choose Hyprland from the display manager.

If already inside Hyprland, reload:

```bash
hyprctl reload
hyprctl configerrors
```

Expected result:

```text
ok
```

If the Lua config breaks Hyprland, go to a TTY:

```text
CTRL + ALT + F3
```

Log in and disable the Lua config:

```bash
mv ~/.config/hypr/hyprland.lua ~/.config/hypr/hyprland.lua.broken
```

Then restart the display manager or reboot:

```bash
sudo systemctl restart sddm
```

or:

```bash
sudo reboot
```

---

# 12. Check Monitor Names

After logging into Hyprland, run:

```bash
hyprctl monitors
```

Expected monitor names:

```text
DP-1
DP-3
```

If your monitor names are different, edit:

```bash
kate ~/.config/hypr/hyprland.lua \
     ~/.config/waybar/config-main.jsonc \
     ~/.config/waybar/config-secondary.jsonc \
     ~/.scripts/switch_workspace_by_monitor.sh \
     ~/.scripts/move_window_to_workspace_by_monitor.sh \
     ~/.config/waybar/scripts/ws_button.sh &
```

Replace `DP-1` and `DP-3` with the actual names.

---

# 13. Hyprland Config

Main config:

```text
~/.config/hypr/hyprland.lua
```

This setup uses Hyprland’s Lua configuration format.

Important sections:

```text
Programs
Environment variables
Monitors
Workspace rules
Hyprland settings
Animations
Autostart
Keybinds
Window rules
```

Check config errors:

```bash
hyprctl configerrors
```

Reload:

```bash
hyprctl reload
```

---

# 14. Workspace Layout

Main monitor:

```text
DP-3
Workspaces: 1-8
```

Secondary monitor:

```text
DP-1
Workspaces: 11-18
```

Waybar visually shows both bars as:

```text
1 2 3 4 5 6 7 8
```

But internally:

```text
Main DP-3:      1  2  3  4  5  6  7  8
Secondary DP-1: 11 12 13 14 15 16 17 18
```

---

# 15. Workspace Keybinds

Switch workspace on the focused monitor:

```text
SUPER + 1
SUPER + 2
SUPER + 3
SUPER + 4
SUPER + 5
SUPER + 6
SUPER + 7
SUPER + 8
```

Move active window to a workspace on the focused monitor:

```text
SUPER + SHIFT + 1
SUPER + SHIFT + 2
SUPER + SHIFT + 3
SUPER + SHIFT + 4
SUPER + SHIFT + 5
SUPER + SHIFT + 6
SUPER + SHIFT + 7
SUPER + SHIFT + 8
```

Scripts used:

```text
~/.scripts/switch_workspace_by_monitor.sh
~/.scripts/move_window_to_workspace_by_monitor.sh
```

Manual workspace switch test:

```bash
~/.scripts/switch_workspace_by_monitor.sh 1
~/.scripts/switch_workspace_by_monitor.sh 2
```

Manual move-window test:

```bash
~/.scripts/move_window_to_workspace_by_monitor.sh 1
```

---

# 16. Main Keybinds

```text
SUPER + Q            Open Kitty
SUPER + C            Close active window
SUPER + R            Toggle Rofi launcher
SUPER + E            Open Dolphin
SUPER + B            Open Firefox
SUPER + V            Toggle floating
SUPER + F            Toggle fullscreen
SUPER + L            Lock screen
SUPER + /            Show shortcut cheat sheet
SUPER + SHIFT + S    Screenshot selected area
SUPER + mouse left   Move window
SUPER + mouse right  Resize window
```

---

# 17. Waybar Setup

This setup uses two Waybar configs:

```text
~/.config/waybar/config-main.jsonc
~/.config/waybar/config-secondary.jsonc
```

Main bar:

```text
config-main.jsonc
Output: DP-3
```

Secondary bar:

```text
config-secondary.jsonc
Output: DP-1
```

Restart both bars:

```bash
pkill waybar

waybar -c ~/.config/waybar/config-main.jsonc -s ~/.config/waybar/style.css &
waybar -c ~/.config/waybar/config-secondary.jsonc -s ~/.config/waybar/style.css &
```

---

# 18. Waybar Modules

Main monitor includes:

```text
Workspaces
Clock
CPU usage + CPU temperature
RAM
GPU
Disk
Network
Volume
Tray
Power
```

Secondary monitor includes:

```text
Workspaces
Clock
CPU usage + CPU temperature
RAM
GPU
Volume
Tray
Power
```

Secondary intentionally leaves out:

```text
Disk
Network
```

---

# 19. Waybar Workspace Buttons

This setup does not use the default Waybar `hyprland/workspaces` module.

Instead, it uses custom Waybar modules and this script:

```text
~/.config/waybar/scripts/ws_button.sh
```

This provides:

```text
Clickable workspace buttons
Active workspace highlighting
Independent monitor state
Hover styling
Compatibility with Hyprland Lua dispatchers
```

Manual test:

```bash
~/.config/waybar/scripts/ws_button.sh 1 1
~/.config/waybar/scripts/ws_button.sh 11 1
```

Expected active output example:

```json
{"text":"<span foreground='#11111b' background='#89b4fa' weight='bold'> 1 </span>","tooltip":"Workspace 1"}
```

Expected inactive output example:

```json
{"text":"<span foreground='#a6adc8'> 1 </span>","tooltip":"Workspace 11"}
```

---

# 20. CPU Module

The combined CPU usage and temperature module is:

```text
~/.config/waybar/scripts/cpu_status.sh
```

Expected output:

```text
[CPU:8% 52°C]
```

Test it:

```bash
~/.config/waybar/scripts/cpu_status.sh
```

If temperature does not show:

```bash
sensors
sudo sensors-detect --auto
```

---

# 21. GPU Module

The GPU module is:

```text
~/.config/waybar/scripts/gpu_compact.sh
```

Expected output:

```text
[GPU:12% 47°C]
```

Test it:

```bash
~/.config/waybar/scripts/gpu_compact.sh
```

For NVIDIA, test:

```bash
nvidia-smi
```

---

# 22. Rofi

Rofi is launched through:

```text
~/.scripts/toggle_rofi_drun.sh
```

Keybind:

```text
SUPER + R
```

Manual launch:

```bash
~/.scripts/toggle_rofi_drun.sh
```

Rofi config:

```text
~/.config/rofi/
```

---

# 23. Kitty

Kitty config:

```text
~/.config/kitty/
```

Keybind:

```text
SUPER + Q
```

Manual launch:

```bash
kitty
```

---

# 24. Eww

Eww is used for popups such as:

```text
Calendar
Volume popup
```

Start Eww:

```bash
eww daemon &
```

Reload Eww:

```bash
eww reload
```

Calendar script:

```text
~/.scripts/toggle_calendar.sh
```

Volume script:

```text
~/.scripts/toggle_volume.sh
```

---

# 25. Audio

Waybar uses the `pulseaudio` module.

Left click:

```text
toggle volume popup
```

Right click:

```text
pavucontrol
```

Useful commands:

```bash
pavucontrol
pamixer --get-volume
pamixer --toggle-mute
```

---

# 26. Screenshots

Screenshot keybind:

```text
SUPER + SHIFT + S
```

Screenshots save to:

```text
~/Pictures/Screenshots/
```

Required tools:

```bash
sudo pacman -S grim slurp wl-clipboard
```

---

# 27. Notifications

Mako config:

```text
~/.config/mako/
```

Restart Mako:

```bash
pkill mako
mako &
```

---

# 28. Lock and Idle

Hyprlock config:

```text
~/.config/hypr/hyprlock.conf
```

Hypridle config:

```text
~/.config/hypr/hypridle.conf
```

Lock manually:

```bash
hyprlock
```

---

# 29. Power Menu

Waybar power menu file:

```text
~/.config/waybar/power_menu.xml
```

Power menu actions:

```text
Lock
Suspend
Reboot
Shutdown
```

---

# 30. Manual Reload Commands

Reload Hyprland:

```bash
hyprctl reload
hyprctl configerrors
```

Restart Waybar:

```bash
pkill waybar

waybar -c ~/.config/waybar/config-main.jsonc -s ~/.config/waybar/style.css &
waybar -c ~/.config/waybar/config-secondary.jsonc -s ~/.config/waybar/style.css &
```

Restart Eww:

```bash
pkill eww
eww daemon &
```

Restart Mako:

```bash
pkill mako
mako &
```

---

# 31. Full Install Command After Cloning

After cloning the repo, this command installs the config files into the correct places:

```bash
cd ~/Hyprland-dotfiles

mkdir -p ~/.config/hypr
mkdir -p ~/.config/waybar/scripts
mkdir -p ~/.config/eww
mkdir -p ~/.config/rofi
mkdir -p ~/.config/kitty
mkdir -p ~/.config/mako
mkdir -p ~/.scripts
mkdir -p ~/Pictures/Screenshots
mkdir -p ~/Pictures/wallpapers

cp hypr/hyprland.lua ~/.config/hypr/hyprland.lua
cp hypr/hypridle.conf ~/.config/hypr/hypridle.conf 2>/dev/null || true
cp hypr/hyprlock.conf ~/.config/hypr/hyprlock.conf 2>/dev/null || true
cp hypr/hyprpaper.conf ~/.config/hypr/hyprpaper.conf 2>/dev/null || true

cp waybar/config-main.jsonc ~/.config/waybar/config-main.jsonc
cp waybar/config-secondary.jsonc ~/.config/waybar/config-secondary.jsonc
cp waybar/style.css ~/.config/waybar/style.css
cp waybar/power_menu.xml ~/.config/waybar/power_menu.xml 2>/dev/null || true
cp -r waybar/scripts/. ~/.config/waybar/scripts/

cp -r scripts/. ~/.scripts/
cp -r rofi/. ~/.config/rofi/ 2>/dev/null || true
cp -r kitty/. ~/.config/kitty/ 2>/dev/null || true
cp -r mako/. ~/.config/mako/ 2>/dev/null || true
cp -r eww/. ~/.config/eww/ 2>/dev/null || true

chmod +x ~/.scripts/* 2>/dev/null || true
chmod +x ~/.config/waybar/scripts/* 2>/dev/null || true
chmod +x ~/.config/eww/scripts/* 2>/dev/null || true
```

---

# 32. Troubleshooting

## Hyprland Config Errors

```bash
hyprctl configerrors
```

If there is an error, fix:

```text
~/.config/hypr/hyprland.lua
```

## Waybar JSON Error

Run one bar manually:

```bash
waybar -c ~/.config/waybar/config-main.jsonc -s ~/.config/waybar/style.css
```

or:

```bash
waybar -c ~/.config/waybar/config-secondary.jsonc -s ~/.config/waybar/style.css
```

Common causes:

```text
missing comma
extra comma
duplicate module block
bad quote escaping
```

## Workspaces Only Switch on One Monitor

Check:

```bash
hyprctl monitors
```

Then check these scripts:

```text
~/.scripts/switch_workspace_by_monitor.sh
~/.scripts/move_window_to_workspace_by_monitor.sh
```

## Plain Workspace Keys Move Windows

Plain workspace switching must use:

```text
hl.dsp.focus
```

Window moving must use:

```text
hl.dsp.window.move
```

Check:

```bash
grep -nE "switch_workspace|move_window|window.move|SUPER \\+ [1-8]" ~/.config/hypr/hyprland.lua
```

## Waybar Workspace Highlights Are Wrong

Restart Waybar:

```bash
pkill waybar

waybar -c ~/.config/waybar/config-main.jsonc -s ~/.config/waybar/style.css &
waybar -c ~/.config/waybar/config-secondary.jsonc -s ~/.config/waybar/style.css &
```

Test:

```bash
~/.config/waybar/scripts/ws_button.sh 1 1
~/.config/waybar/scripts/ws_button.sh 11 1
```

## CPU Temperature Does Not Show

Run:

```bash
sensors
```

Then:

```bash
sudo sensors-detect --auto
```

## GPU Shows N/A

Run:

```bash
nvidia-smi
```

If missing:

```bash
sudo pacman -S nvidia-utils
```

---

# 33. Sync Live Configs Back Into Repo

After editing live configs, sync them back into the repo:

```bash
cd ~/Hyprland-dotfiles

mkdir -p hypr waybar/scripts scripts rofi kitty mako eww

cp ~/.config/hypr/hyprland.lua hypr/hyprland.lua
cp ~/.config/hypr/hypridle.conf hypr/hypridle.conf 2>/dev/null || true
cp ~/.config/hypr/hyprlock.conf hypr/hyprlock.conf 2>/dev/null || true
cp ~/.config/hypr/hyprpaper.conf hypr/hyprpaper.conf 2>/dev/null || true

cp ~/.config/waybar/config-main.jsonc waybar/config-main.jsonc
cp ~/.config/waybar/config-secondary.jsonc waybar/config-secondary.jsonc
cp ~/.config/waybar/style.css waybar/style.css
cp ~/.config/waybar/power_menu.xml waybar/power_menu.xml 2>/dev/null || true
cp -r ~/.config/waybar/scripts/. waybar/scripts/ 2>/dev/null || true

cp -r ~/.config/rofi/. rofi/ 2>/dev/null || true
cp -r ~/.config/kitty/. kitty/ 2>/dev/null || true
cp -r ~/.config/mako/. mako/ 2>/dev/null || true
cp -r ~/.config/eww/. eww/ 2>/dev/null || true

cp ~/.scripts/*.sh scripts/ 2>/dev/null || true

find scripts waybar/scripts -type f -name "*.sh" -exec chmod +x {} \; 2>/dev/null || true

git add -A
git status
git diff --cached --stat
```

Commit and push:

```bash
git commit -m "Sync current Hyprland setup"
git push
```

---

# 34. Git Workflow

Check changed files:

```bash
git status
```

Add all changes:

```bash
git add -A
```

Commit:

```bash
git commit -m "Update Hyprland dotfiles"
```

Push:

```bash
git push
```

---

# Notes

This setup is personal and machine-specific.

Before installing on a new system, confirm monitor names:

```bash
hyprctl monitors
```

Then update monitor names if needed.

Primary files to edit for a different monitor layout:

```text
hypr/hyprland.lua
waybar/config-main.jsonc
waybar/config-secondary.jsonc
scripts/switch_workspace_by_monitor.sh
scripts/move_window_to_workspace_by_monitor.sh
waybar/scripts/ws_button.sh
```bash -lc 'cd ~/Hyprland-dotfiles && cat > README.md <<'"'"'EOF'"'"'
# Hyprland Dotfiles — Full Zero Install Guide

This repo is my personal Hyprland desktop setup.

It is designed for a fresh Arch/CachyOS/EndeavourOS-style system where I want to restore my full Hyprland environment from zero.

The setup includes:

- Hyprland Lua config
- Dual-monitor layout
- Independent workspaces per monitor
- Waybar panels for both monitors
- Custom clickable Waybar workspace buttons
- Active workspace highlighting
- CPU usage + CPU temperature
- RAM
- GPU
- Disk and network on the main monitor
- Volume
- Power menu
- Rofi launcher
- Kitty terminal
- Mako notifications
- Eww popups
- Hyprlock / Hypridle
- Helper scripts

---

# My target monitor layout

This setup expects this monitor layout:

```text
DP-1 = secondary monitor
2560x1440
left side
workspaces 11-18

DP-3 = main ultrawide monitor
3440x1440
right side
workspaces 1-8
```

Hyprland position layout:

```text
DP-1 starts at 0x0
DP-3 starts at 2560x0
```

If monitor names are different, they must be changed after install.

Check monitor names with:

```bash
hyprctl monitors
```

---

# Repo structure

```text
hyprland-dotfiles/
├── hypr/
│   ├── hyprland.lua
│   ├── hypridle.conf
│   ├── hyprlock.conf
│   ├── hyprpaper.conf
│   └── hyprland.conf.legacy
├── waybar/
│   ├── config-main.jsonc
│   ├── config-secondary.jsonc
│   ├── style.css
│   ├── power_menu.xml
│   └── scripts/
│       ├── ws_button.sh
│       ├── cpu_status.sh
│       ├── gpu_compact.sh
│       ├── ram_compact.sh
│       └── cpu_compact.sh
├── scripts/
│   ├── switch_workspace_by_monitor.sh
│   ├── move_window_to_workspace_by_monitor.sh
│   ├── show_hypr_binds.sh
│   ├── toggle_rofi_drun.sh
│   ├── toggle_calendar.sh
│   └── toggle_volume.sh
├── rofi/
├── kitty/
├── mako/
└── eww/
```

---

# 1. Install base packages

On CachyOS / Arch / EndeavourOS:

```bash
sudo pacman -Syu
```

Install the required packages:

```bash
sudo pacman -S \
  git \
  base-devel \
  hyprland \
  hyprlock \
  hypridle \
  waybar \
  rofi \
  kitty \
  dolphin \
  kate \
  jq \
  socat \
  playerctl \
  pamixer \
  pavucontrol \
  pipewire \
  pipewire-pulse \
  pipewire-alsa \
  pipewire-jack \
  wireplumber \
  mako \
  libnotify \
  lm_sensors \
  curl \
  wget \
  unzip \
  brightnessctl \
  network-manager-applet \
  grim \
  slurp \
  wl-clipboard \
  papirus-icon-theme \
  ttf-jetbrains-mono-nerd \
  ttf-font-awesome \
  nvidia-utils
```

If any package is unavailable, install what exists first, then handle the missing package later.

---

# 2. Install yay if needed

If `yay` is not installed:

```bash
cd ~

git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
```

Then install Eww if needed:

```bash
yay -S eww
```

If `eww` is available in the normal repos, this may also work:

```bash
sudo pacman -S eww
```

---

# 3. Enable PipeWire audio

```bash
systemctl --user enable --now pipewire pipewire-pulse wireplumber
```

Check audio:

```bash
pactl info
```

---

# 4. Set up CPU temperature sensors

Install sensors:

```bash
sudo pacman -S lm_sensors
```

Detect sensors:

```bash
sudo sensors-detect --auto
```

Test:

```bash
sensors
```

The Waybar CPU module expects sensors to expose something like:

```text
Tctl
Package id 0
CPU
```

---

# 5. Clone this repo

```bash
cd ~

git clone https://github.com/kristopher95/hyprland-dotfiles.git

cd ~/hyprland-dotfiles
```

If I prefer the capitalized folder name:

```bash
mv ~/hyprland-dotfiles ~/Hyprland-dotfiles
cd ~/Hyprland-dotfiles
```

---

# 6. Back up existing configs

Run this before installing:

```bash
mkdir -p ~/dotfiles-backup

cp -r ~/.config/hypr ~/dotfiles-backup/hypr 2>/dev/null || true
cp -r ~/.config/waybar ~/dotfiles-backup/waybar 2>/dev/null || true
cp -r ~/.config/eww ~/dotfiles-backup/eww 2>/dev/null || true
cp -r ~/.config/rofi ~/dotfiles-backup/rofi 2>/dev/null || true
cp -r ~/.config/kitty ~/dotfiles-backup/kitty 2>/dev/null || true
cp -r ~/.config/mako ~/dotfiles-backup/mako 2>/dev/null || true
cp -r ~/.scripts ~/dotfiles-backup/scripts 2>/dev/null || true
```

---

# 7. Create required folders

```bash
mkdir -p ~/.config/hypr
mkdir -p ~/.config/waybar/scripts
mkdir -p ~/.config/eww
mkdir -p ~/.config/rofi
mkdir -p ~/.config/kitty
mkdir -p ~/.config/mako
mkdir -p ~/.scripts
mkdir -p ~/Pictures/Screenshots
mkdir -p ~/Pictures/wallpapers
```

---

# 8. Install the dotfiles

From inside the repo:

```bash
cd ~/Hyprland-dotfiles
```

Copy Hyprland files:

```bash
cp hypr/hyprland.lua ~/.config/hypr/hyprland.lua
cp hypr/hypridle.conf ~/.config/hypr/hypridle.conf 2>/dev/null || true
cp hypr/hyprlock.conf ~/.config/hypr/hyprlock.conf 2>/dev/null || true
cp hypr/hyprpaper.conf ~/.config/hypr/hyprpaper.conf 2>/dev/null || true
```

Copy Waybar:

```bash
cp waybar/config-main.jsonc ~/.config/waybar/config-main.jsonc
cp waybar/config-secondary.jsonc ~/.config/waybar/config-secondary.jsonc
cp waybar/style.css ~/.config/waybar/style.css
cp waybar/power_menu.xml ~/.config/waybar/power_menu.xml 2>/dev/null || true
cp -r waybar/scripts/. ~/.config/waybar/scripts/
```

Copy helper scripts:

```bash
cp -r scripts/. ~/.scripts/
```

Copy Rofi:

```bash
cp -r rofi/. ~/.config/rofi/ 2>/dev/null || true
```

Copy Kitty:

```bash
cp -r kitty/. ~/.config/kitty/ 2>/dev/null || true
```

Copy Mako:

```bash
cp -r mako/. ~/.config/mako/ 2>/dev/null || true
```

Copy Eww:

```bash
cp -r eww/. ~/.config/eww/ 2>/dev/null || true
```

Make scripts executable:

```bash
chmod +x ~/.scripts/* 2>/dev/null || true
chmod +x ~/.config/waybar/scripts/* 2>/dev/null || true
chmod +x ~/.config/eww/scripts/* 2>/dev/null || true
```

---

# 9. Check monitor names

Run:

```bash
hyprctl monitors
```

Expected names:

```text
DP-1
DP-3
```

If monitor names are different, edit these files:

```text
~/.config/hypr/hyprland.lua
~/.config/waybar/config-main.jsonc
~/.config/waybar/config-secondary.jsonc
~/.scripts/switch_workspace_by_monitor.sh
~/.scripts/move_window_to_workspace_by_monitor.sh
~/.config/waybar/scripts/ws_button.sh
```

Use Kate:

```bash
kate ~/.config/hypr/hyprland.lua \
     ~/.config/waybar/config-main.jsonc \
     ~/.config/waybar/config-secondary.jsonc \
     ~/.scripts/switch_workspace_by_monitor.sh \
     ~/.scripts/move_window_to_workspace_by_monitor.sh \
     ~/.config/waybar/scripts/ws_button.sh &
```

---

# 10. Hyprland Lua config

Main config:

```text
~/.config/hypr/hyprland.lua
```

This repo uses the new Hyprland Lua configuration style.

Check config errors:

```bash
hyprctl reload
hyprctl configerrors
```

Expected:

```text
ok
```

If Hyprland breaks, disable the Lua file from a TTY:

```bash
mv ~/.config/hypr/hyprland.lua ~/.config/hypr/hyprland.lua.broken
```

Then restart the display manager or reboot.

---

# 11. Workspace layout

Main monitor:

```text
DP-3
workspaces 1-8
```

Secondary monitor:

```text
DP-1
workspaces 11-18
```

Waybar visually shows both monitors as:

```text
1 2 3 4 5 6 7 8
```

But internally the secondary monitor uses:

```text
11 12 13 14 15 16 17 18
```

---

# 12. Workspace keybinds

Switch workspace on the focused monitor:

```text
SUPER + 1
SUPER + 2
SUPER + 3
SUPER + 4
SUPER + 5
SUPER + 6
SUPER + 7
SUPER + 8
```

Move active window to workspace on focused monitor:

```text
SUPER + SHIFT + 1
SUPER + SHIFT + 2
SUPER + SHIFT + 3
SUPER + SHIFT + 4
SUPER + SHIFT + 5
SUPER + SHIFT + 6
SUPER + SHIFT + 7
SUPER + SHIFT + 8
```

Scripts used:

```text
~/.scripts/switch_workspace_by_monitor.sh
~/.scripts/move_window_to_workspace_by_monitor.sh
```

Manual test:

```bash
~/.scripts/switch_workspace_by_monitor.sh 1
~/.scripts/switch_workspace_by_monitor.sh 2
```

Move-window test:

```bash
~/.scripts/move_window_to_workspace_by_monitor.sh 1
```

---

# 13. Main keybinds

```text
SUPER + Q            Open Kitty
SUPER + C            Close active window
SUPER + R            Toggle Rofi launcher
SUPER + E            Open Dolphin
SUPER + B            Open Firefox
SUPER + V            Toggle floating
SUPER + F            Toggle fullscreen
SUPER + L            Lock screen
SUPER + /            Show shortcut cheat sheet
SUPER + SHIFT + S    Screenshot selected area
SUPER + mouse left   Move window
SUPER + mouse right  Resize window
```

---

# 14. Waybar setup

This setup uses two Waybar configs:

```text
~/.config/waybar/config-main.jsonc
~/.config/waybar/config-secondary.jsonc
```

Main monitor:

```text
config-main.jsonc → DP-3
```

Secondary monitor:

```text
config-secondary.jsonc → DP-1
```

Restart Waybar:

```bash
pkill waybar

waybar -c ~/.config/waybar/config-main.jsonc -s ~/.config/waybar/style.css &
waybar -c ~/.config/waybar/config-secondary.jsonc -s ~/.config/waybar/style.css &
```

---

# 15. Waybar modules

Main monitor includes:

```text
Workspaces
Clock
CPU usage + CPU temperature
RAM
GPU
Disk
Network
Volume
Tray
Power
```

Secondary monitor includes:

```text
Workspaces
Clock
CPU usage + CPU temperature
RAM
GPU
Volume
Tray
Power
```

Secondary intentionally leaves out:

```text
Disk
Network
```

---

# 16. Waybar workspace buttons

This setup does not use the default Waybar `hyprland/workspaces` module.

It uses custom modules and a script:

```text
~/.config/waybar/scripts/ws_button.sh
```

This gives:

- clickable workspace buttons
- active workspace highlighting
- independent monitor state
- hover styling
- compatibility with the Hyprland Lua dispatcher setup

Manual test:

```bash
~/.config/waybar/scripts/ws_button.sh 1 1
~/.config/waybar/scripts/ws_button.sh 11 1
```

Expected active output example:

```json
{"text":"<span foreground='#11111b' background='#89b4fa' weight='bold'> 1 </span>","tooltip":"Workspace 1"}
```

Expected inactive output example:

```json
{"text":"<span foreground='#a6adc8'> 1 </span>","tooltip":"Workspace 11"}
```

---

# 17. CPU module

The combined CPU module is:

```text
~/.config/waybar/scripts/cpu_status.sh
```

Expected output:

```text
[CPU:8% 52°C]
```

Test:

```bash
~/.config/waybar/scripts/cpu_status.sh
```

If temperature is missing:

```bash
sensors
sudo sensors-detect --auto
```

---

# 18. GPU module

The GPU module is:

```text
~/.config/waybar/scripts/gpu_compact.sh
```

Expected output:

```text
[GPU:12% 47°C]
```

Test:

```bash
~/.config/waybar/scripts/gpu_compact.sh
```

For NVIDIA, test:

```bash
nvidia-smi
```

---

# 19. Rofi

Rofi is launched through:

```text
~/.scripts/toggle_rofi_drun.sh
```

Keybind:

```text
SUPER + R
```

Rofi config:

```text
~/.config/rofi/
```

Manual launch:

```bash
~/.scripts/toggle_rofi_drun.sh
```

---

# 20. Kitty

Kitty config:

```text
~/.config/kitty/
```

Keybind:

```text
SUPER + Q
```

Manual launch:

```bash
kitty
```

---

# 21. Eww

Eww is used for popups like:

```text
Calendar
Volume popup
```

Start Eww:

```bash
eww daemon &
```

Reload Eww:

```bash
eww reload
```

Calendar script:

```text
~/.scripts/toggle_calendar.sh
```

Volume script:

```text
~/.scripts/toggle_volume.sh
```

---

# 22. Audio

Waybar uses the `pulseaudio` module.

Left click:

```text
toggle volume popup
```

Right click:

```text
pavucontrol
```

Useful commands:

```bash
pavucontrol
pamixer --get-volume
pamixer --toggle-mute
```

---

# 23. Screenshots

Screenshot keybind:

```text
SUPER + SHIFT + S
```

Screenshots save to:

```text
~/Pictures/Screenshots/
```

Required tools:

```bash
sudo pacman -S grim slurp wl-clipboard
```

---

# 24. Notifications

Mako config:

```text
~/.config/mako/
```

Restart Mako:

```bash
pkill mako
mako &
```

---

# 25. Lock and idle

Hyprlock:

```text
~/.config/hypr/hyprlock.conf
```

Hypridle:

```text
~/.config/hypr/hypridle.conf
```

Lock manually:

```bash
hyprlock
```

---

# 26. Power menu

Waybar power menu file:

```text
~/.config/waybar/power_menu.xml
```

Power menu actions:

```text
Lock
Suspend
Reboot
Shutdown
```

---

# 27. Manual reload commands

Reload Hyprland:

```bash
hyprctl reload
hyprctl configerrors
```

Restart Waybar:

```bash
pkill waybar

waybar -c ~/.config/waybar/config-main.jsonc -s ~/.config/waybar/style.css &
waybar -c ~/.config/waybar/config-secondary.jsonc -s ~/.config/waybar/style.css &
```

Restart Eww:

```bash
pkill eww
eww daemon &
```

Restart Mako:

```bash
pkill mako
mako &
```

---

# 28. Full install command after cloning

After cloning the repo, this command installs the config files into the correct places:

```bash
cd ~/Hyprland-dotfiles

mkdir -p ~/.config/hypr
mkdir -p ~/.config/waybar/scripts
mkdir -p ~/.config/eww
mkdir -p ~/.config/rofi
mkdir -p ~/.config/kitty
mkdir -p ~/.config/mako
mkdir -p ~/.scripts
mkdir -p ~/Pictures/Screenshots
mkdir -p ~/Pictures/wallpapers

cp hypr/hyprland.lua ~/.config/hypr/hyprland.lua
cp hypr/hypridle.conf ~/.config/hypr/hypridle.conf 2>/dev/null || true
cp hypr/hyprlock.conf ~/.config/hypr/hyprlock.conf 2>/dev/null || true
cp hypr/hyprpaper.conf ~/.config/hypr/hyprpaper.conf 2>/dev/null || true

cp waybar/config-main.jsonc ~/.config/waybar/config-main.jsonc
cp waybar/config-secondary.jsonc ~/.config/waybar/config-secondary.jsonc
cp waybar/style.css ~/.config/waybar/style.css
cp waybar/power_menu.xml ~/.config/waybar/power_menu.xml 2>/dev/null || true
cp -r waybar/scripts/. ~/.config/waybar/scripts/

cp -r scripts/. ~/.scripts/
cp -r rofi/. ~/.config/rofi/ 2>/dev/null || true
cp -r kitty/. ~/.config/kitty/ 2>/dev/null || true
cp -r mako/. ~/.config/mako/ 2>/dev/null || true
cp -r eww/. ~/.config/eww/ 2>/dev/null || true

chmod +x ~/.scripts/* 2>/dev/null || true
chmod +x ~/.config/waybar/scripts/* 2>/dev/null || true
chmod +x ~/.config/eww/scripts/* 2>/dev/null || true
```

---

# 29. Troubleshooting

## Hyprland config errors

```bash
hyprctl configerrors
```

If there is an error, fix:

```text
~/.config/hypr/hyprland.lua
```

## Waybar JSON error

Run one bar manually:

```bash
waybar -c ~/.config/waybar/config-main.jsonc -s ~/.config/waybar/style.css
```

or:

```bash
waybar -c ~/.config/waybar/config-secondary.jsonc -s ~/.config/waybar/style.css
```

Common causes:

```text
missing comma
extra comma
duplicate module block
bad quote escaping
```

## Workspaces only switch on one monitor

Check:

```bash
hyprctl monitors
```

Then check these scripts:

```text
~/.scripts/switch_workspace_by_monitor.sh
~/.scripts/move_window_to_workspace_by_monitor.sh
```

## Plain workspace keys move windows

Plain workspace switching must use:

```text
hl.dsp.focus
```

Window moving must use:

```text
hl.dsp.window.move
```

Check:

```bash
grep -nE "switch_workspace|move_window|window.move|SUPER \\+ [1-8]" ~/.config/hypr/hyprland.lua
```

## Waybar workspace highlights are wrong

Restart Waybar:

```bash
pkill waybar

waybar -c ~/.config/waybar/config-main.jsonc -s ~/.config/waybar/style.css &
waybar -c ~/.config/waybar/config-secondary.jsonc -s ~/.config/waybar/style.css &
```

Test:

```bash
~/.config/waybar/scripts/ws_button.sh 1 1
~/.config/waybar/scripts/ws_button.sh 11 1
```

## CPU temp does not show

Run:

```bash
sensors
```

Then:

```bash
sudo sensors-detect --auto
```

## GPU shows N/A

Run:

```bash
nvidia-smi
```

If missing:

```bash
sudo pacman -S nvidia-utils
```

---

# 30. Sync live configs back into repo

After editing live configs, sync them back into the repo:

```bash
cd ~/Hyprland-dotfiles

mkdir -p hypr waybar/scripts scripts rofi kitty mako eww

cp ~/.config/hypr/hyprland.lua hypr/hyprland.lua
cp ~/.config/hypr/hypridle.conf hypr/hypridle.conf 2>/dev/null || true
cp ~/.config/hypr/hyprlock.conf hypr/hyprlock.conf 2>/dev/null || true
cp ~/.config/hypr/hyprpaper.conf hypr/hyprpaper.conf 2>/dev/null || true

cp ~/.config/waybar/config-main.jsonc waybar/config-main.jsonc
cp ~/.config/waybar/config-secondary.jsonc waybar/config-secondary.jsonc
cp ~/.config/waybar/style.css waybar/style.css
cp ~/.config/waybar/power_menu.xml waybar/power_menu.xml 2>/dev/null || true
cp -r ~/.config/waybar/scripts/. waybar/scripts/ 2>/dev/null || true

cp -r ~/.config/rofi/. rofi/ 2>/dev/null || true
cp -r ~/.config/kitty/. kitty/ 2>/dev/null || true
cp -r ~/.config/mako/. mako/ 2>/dev/null || true
cp -r ~/.config/eww/. eww/ 2>/dev/null || true

cp ~/.scripts/*.sh scripts/ 2>/dev/null || true

find scripts waybar/scripts -type f -name "*.sh" -exec chmod +x {} \\; 2>/dev/null || true

git add -A
git status
git diff --cached --stat
```

Commit and push:

```bash
git commit -m "Sync current Hyprland setup"
git push
```

---

# 31. Git workflow

Check changed files:

```bash
git status
```

Add all changes:

```bash
git add -A
```

Commit:

```bash
git commit -m "Update Hyprland dotfiles"
```

Push:

```bash
git push
```

---

# Notes

This setup is personal and machine-specific.

Before installing on a new system, confirm:

```bash
hyprctl monitors
```

Then update monitor names if needed.

Primary files to edit for a different monitor layout:

```text
hypr/hyprland.lua
waybar/config-main.jsonc
waybar/config-secondary.jsonc
scripts/switch_workspace_by_monitor.sh
scripts/move_window_to_workspace_by_monitor.sh
waybar/scripts/ws_button.sh
```

EOF

rm -f README.txt

git add README.md
git add -u README.txt

git commit -m "Rewrite README as zero install guide"
git push'
