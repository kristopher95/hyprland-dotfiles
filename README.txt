# Hyprland Dotfiles

My personal Hyprland configuration for Arch Linux, CachyOS, EndeavourOS, and other Arch-based distributions.

Included configurations:

* Hyprland
* Waybar
* Rofi
* Kitty
* Mako
* Eww widgets
* Hyprlock and Hypridle
* Helper scripts
* Independent workspaces for two monitors

> **Warning:** These dotfiles are designed around my personal hardware and monitor layout. Back up your existing configuration before installing.

## Monitor Layout

This configuration uses:

| Monitor | Resolution | Position       | Workspaces |
| ------- | ---------: | -------------- | ---------- |
| `DP-3`  |  3440×1440 | Right/main     | 1–8        |
| `DP-1`  |  2560×1440 | Left/secondary | 11–18      |

Check your monitor names with:

```bash
hyprctl monitors
```

You may need to replace `DP-3` and `DP-1` inside the configuration files.

## Installation

### 1. Install the required packages

```bash
sudo pacman -Syu
```

```bash
sudo pacman -S --needed \
  git hyprland hyprlock hypridle hyprpaper \
  waybar rofi kitty dolphin mako libnotify \
  eww jq socat playerctl pamixer pavucontrol \
  pipewire pipewire-pulse wireplumber \
  lm_sensors grim slurp wl-clipboard \
  brightnessctl network-manager-applet \
  papirus-icon-theme \
  ttf-jetbrains-mono-nerd \
  ttf-font-awesome
```

If `eww` is unavailable through Pacman, install it from the AUR:

```bash
yay -S eww
```

### 2. Clone the repository

```bash
git clone https://github.com/kristopher95/hyprland-dotfiles.git
cd hyprland-dotfiles
```

### 3. Back up your existing configuration

```bash
mkdir -p ~/dotfiles-backup
```

```bash
cp -r ~/.config/hypr ~/dotfiles-backup/ 2>/dev/null || true
cp -r ~/.config/waybar ~/dotfiles-backup/ 2>/dev/null || true
cp -r ~/.config/eww ~/dotfiles-backup/ 2>/dev/null || true
cp -r ~/.config/rofi ~/dotfiles-backup/ 2>/dev/null || true
cp -r ~/.config/kitty ~/dotfiles-backup/ 2>/dev/null || true
cp -r ~/.config/mako ~/dotfiles-backup/ 2>/dev/null || true
cp -r ~/.scripts ~/dotfiles-backup/ 2>/dev/null || true
```

### 4. Copy the dotfiles

Run these commands from inside the cloned repository:

```bash
mkdir -p ~/.config/{hypr,waybar,eww,rofi,kitty,mako}
mkdir -p ~/.scripts
mkdir -p ~/Pictures/Screenshots
```

```bash
cp -r hypr/. ~/.config/hypr/
cp -r waybar/. ~/.config/waybar/
cp -r eww/. ~/.config/eww/
cp -r rofi/. ~/.config/rofi/
cp -r kitty/. ~/.config/kitty/
cp -r mako/. ~/.config/mako/
cp -r scripts/. ~/.scripts/
```

Make the scripts executable:

```bash
chmod +x ~/.scripts/* 2>/dev/null || true
chmod +x ~/.config/waybar/scripts/* 2>/dev/null || true
chmod +x ~/.config/eww/scripts/* 2>/dev/null || true
```

### 5. Configure temperature sensors

```bash
sudo sensors-detect --auto
sensors
```

The GPU module requires NVIDIA utilities:

```bash
nvidia-smi
```

### 6. Update your monitor names

Check your monitors:

```bash
hyprctl monitors
```

Update the monitor names where necessary in:

```text
~/.config/hypr/hyprland.lua
~/.config/waybar/config-main.jsonc
~/.config/waybar/config-secondary.jsonc
~/.scripts/switch_workspace_by_monitor.sh
~/.scripts/move_window_to_workspace_by_monitor.sh
~/.config/waybar/scripts/ws_button.sh
```

### 7. Start Hyprland

Log out and select **Hyprland** from your display manager.

After logging in, reload the configuration:

```bash
hyprctl reload
```

Check for errors:

```bash
hyprctl configerrors
```

## Restarting Components

Restart Waybar:

```bash
pkill waybar
waybar -c ~/.config/waybar/config-main.jsonc -s ~/.config/waybar/style.css &
waybar -c ~/.config/waybar/config-secondary.jsonc -s ~/.config/waybar/style.css &
```

Restart Mako:

```bash
pkill mako
mako &
```

Reload Eww:

```bash
eww daemon
eww reload
```

## Troubleshooting

Check Hyprland configuration errors:

```bash
hyprctl configerrors
```

Make the scripts executable again:

```bash
chmod +x ~/.scripts/* ~/.config/waybar/scripts/* 2>/dev/null
```

If the Hyprland configuration prevents the desktop from starting, open a TTY with `Ctrl + Alt + F3` and temporarily disable it:

```bash
mv ~/.config/hypr/hyprland.lua ~/.config/hypr/hyprland.lua.broken
sudo reboot
```

## Notes

These dotfiles are primarily intended as a reference for my personal setup. Some configuration changes will be required when using different monitors, hardware, applications, or directory paths.
