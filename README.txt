# Hyprland Dotfiles

A personal collection of Hyprland configuration dotfiles — ready to use or customize as your base Hyprland setup.

Dotfiles in this repo define configuration for Hyprland itself and related desktop tooling such as Waybar, launcher scripts, keybindings, themes, and other utilities. Dotfiles control everything from workspace behavior to widget appearance.

---

Included Configuration

- Hyprland config (~/.config/hypr/hyprland.conf)
- Waybar configuration (~/.config/waybar/)
- Launcher and script folders
- Optional themes and utilities

---

Prerequisites

Before installing these dotfiles, install the following dependencies.

For Arch-based systems (Arch, Manjaro, CachyOS):

sudo pacman -Syu
sudo pacman -S hyprland waybar swaybg swayidle swaylock kitty alacritty rofi
sudo pacman -S nitrogen pamixer playerctl brightnessctl feh pavucontrol
sudo pacman -S ttf-jetbrains-mono-nerd noto-fonts noto-fonts-cjk ttf-font-awesome
sudo pacman -S polkit lxappearance dunst

For Ubuntu/Debian-based systems:

sudo apt update && sudo apt upgrade -y
sudo apt install -y kitty alacritty rofi nitrogen swayidle swaylock feh pavucontrol fonts-jetbrains-mono fonts-font-awesome dunst

*Note:* Make sure Waybar is installed and configured. GPU tools like nvidia-smi may be required if using GPU modules.

---

Installation

1) Clone the Repository

git clone https://github.com/kristopher95/hyprland-dotfiles.git
cd hyprland-dotfiles

2) Backup Your Current Config

cp -r ~/.config/hypr ~/.config/hypr-backup
cp -r ~/.config/waybar ~/.config/waybar-backup

3) Apply Dotfile Configs

cp -r .config ~/.config/

Alternatively, use symlinks:

ln -s ~/path/to/hyprland-dotfiles/.config/hypr ~/.config/hypr
ln -s ~/path/to/hyprland-dotfiles/.config/waybar ~/.config/waybar

4) Reload or Restart

Restart Hyprland or reload config:

- Press your Hyprland reload shortcut (often Super+Esc), or
- Log out and log back in

---

Testing & Verification

After installation:

1. Check that Hyprland launches without errors
2. Verify keybindings work as expected
3. Ensure bar/launcher panels display correctly

If something doesn’t behave as expected, review logs or revert using backups.

---

Customization

You can customize:

- Keybindings inside hyprland.conf
- Waybar modules, themes, and colors
- Launcher scripts and panel widgets
- Terminal, shell, and plugin configs

These dotfiles are intended to be a base you extend and maintain.

---

Screenshots / Showcase (Optional)

Add a screenshots/ folder and reference them like:

![Hyprland Desktop](screenshots/desktop.png)
![Waybar Modules](screenshots/waybar.png)

---

Tips

- Use symlinks so the repo and config always stay in sync
- Consider using a tool like stow or custom install scripts for better management
- Always keep backups before major changes

---

License

This project is licensed under the MIT License

---

Made for users who want a clean, fully functional, customizable Hyprland desktop setup that can be reused or built upon.
