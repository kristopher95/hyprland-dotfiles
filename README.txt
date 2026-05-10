Hyprland Dotfiles Setup
=======================

This repository contains my full Hyprland configuration including:
- Hyprland main config (~/.config/hypr)
- Waybar with color-coded RAM, CPU, GPU modules (~/.config/waybar)
- Kitty terminal configuration with JetBrains Mono Nerd Font (~/.config/kitty)
- Rofi Tokyo Night theme with Papirus icons (~/.config/rofi)
- Scripts for Waybar modules: volume, RAM, CPU, GPU
- Minimal login setup via greetd + tuigreet

Step-by-Step Setup
------------------

1. Install CachyOS (or Arch-based Linux)

2. Update system and install required packages:
   sudo pacman -Syu
   sudo pacman -S hyprland waybar kitty rofi wpctl papirus-icon-theme git

3. Clone this repository:
   git clone git@github.com:kristopher95/hyprland-dotfiles.git
   cd hyprland-dotfiles

4. Copy configs to your home directory:
   cp -r hypr ~/.config/hypr
   cp -r waybar ~/.config/waybar
   cp -r kitty ~/.config/kitty
   cp -r rofi ~/.config/rofi

5. Make all Waybar scripts executable:
   chmod +x ~/.config/waybar/scripts/*.sh

6. Ensure JetBrains Mono Nerd Font is installed for Kitty, Waybar, and Rofi

7. Test Rofi theme:
   rofi -show drun

8. Configure minimal login with greetd + tuigreet:
   sudo nano /etc/greetd/config.toml

   Paste the following:

   [terminal]
   vt = 1

   [default_session]
   command = "tuigreet --time --remember --cmd start-hyprland"
   user = "kris"

9. Enable greetd and disable SDDM:
   sudo systemctl enable greetd
   sudo systemctl disable sddm
   sudo systemctl restart greetd

10. Restart Waybar to apply module settings:
    pkill waybar
    waybar &

11. Configure volume module (optional):
    - Click opens pavucontrol (default)
    - Scroll or scripts can be used for incremental volume control

12. Optional: SSH key setup for GitHub backup
    ssh-keygen -t ed25519 -C "kristopher95@github.com"
    cat ~/.ssh/id_ed25519.pub  # copy the key
    # Add to GitHub → Settings → SSH and GPG keys → New SSH key
    ssh -T git@github.com     # test connection
    git remote set-url origin git@github.com:kristopher95/hyprland-dotfiles.git
    git push -u origin main

13. Adjust Waybar font size (ultrawide monitors):
    ~/.config/waybar/style.css

14. Adjust Rofi font and icon size for ultrawide:
    ~/.config/rofi/config.rasi

15. Optional Hyprland tweaks:
    - Window gaps and borders: ~/.config/hypr/hyprland.conf
    - Monitor refresh rates configured in Hyprland outputs section

16. Updating dotfiles:
    git add .
    git commit -m "Update configs"
    git push

Notes
-----
- Kitty, Waybar, and Rofi are all dark-themed and OLED-friendly
- Waybar modules include RAM, CPU, GPU, volume, network, and taskbar
- Login uses greetd + tuigreet for minimal startup
- Fully color-coded Tokyo Night aesthetic across Rofi and Waybar
- Ultrawide + secondary monitor fully supported
- All scripts included and ready to use
