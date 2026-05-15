-- ~/.config/hypr/hyprland.lua
-- Minimal Hyprland 0.55.1 Lua test config

-- Programs
local terminal = "kitty"
local file_manager = "dolphin"
local menu = "rofi -show drun"

-- Monitors
hl.monitor({
  output = "DP-1",
  mode = "2560x1440@59.95",
  position = "0x0",
  scale = 1,
})

hl.monitor({
  output = "DP-3",
  mode = "3440x1440@143.97",
  position = "2560x0",
  scale = 1,
})

-- Basic Hyprland options
hl.config({
  input = {
    kb_layout = "us",
    follow_mouse = 1,

    touchpad = {
      natural_scroll = false,
    },
  },

  general = {
    gaps_in = 5,
    gaps_out = 10,
    border_size = 2,
    layout = "dwindle",
  },

  decoration = {
    rounding = 10,
  },

  dwindle = {
    preserve_split = true,
  },

  misc = {
    disable_hyprland_logo = true,
    force_default_wallpaper = -1,
  },
})

-- Emergency autostart.
-- This opens Kitty on login so you are not trapped if a bind fails.
hl.on("hyprland.start", function()
-- Emergency terminal while testing Lua migration.
-- Remove this later once the full config is stable.
hl.exec_cmd(terminal)

-- Bars
hl.exec_cmd("waybar -c ~/.config/waybar/config-main.jsonc -s ~/.config/waybar/style.css")
hl.exec_cmd("waybar -c ~/.config/waybar/config-secondary.jsonc -s ~/.config/waybar/style.css")

-- Wallpaper/workspace automation
hl.exec_cmd("~/.scripts/workspace_wallpaper_daemon.sh")

-- Idle/lock handling
hl.exec_cmd("hypridle")

-- Eww widgets
hl.exec_cmd("eww daemon")

-- Polkit auth agent
hl.exec_cmd("/usr/lib/polkit-kde-authentication-agent-1")
end)

-- Keybinds migrated from old hyprland.conf

-- Main app/window binds
hl.bind("SUPER + Q", hl.dsp.exec_cmd(terminal))
hl.bind("SUPER + C", hl.dsp.window.close())

hl.bind("SUPER + M", hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"))

hl.bind("SUPER + E", hl.dsp.exec_cmd(file_manager))
hl.bind("SUPER + B", hl.dsp.exec_cmd("firefox"))
hl.bind("SUPER + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind("SUPER + R", hl.dsp.exec_cmd(menu))
hl.bind("SUPER + P", hl.dsp.window.pseudo({ action = "toggle" }))
hl.bind("SUPER + J", hl.dsp.layout("togglesplit"))
hl.bind("SUPER + F", hl.dsp.window.fullscreen({
  mode = "fullscreen",
  action = "toggle",
}))

-- Move focus with SUPER + arrow keys
hl.bind("SUPER + left", hl.dsp.focus({ direction = "l" }))
hl.bind("SUPER + right", hl.dsp.focus({ direction = "r" }))
hl.bind("SUPER + up", hl.dsp.focus({ direction = "u" }))
hl.bind("SUPER + down", hl.dsp.focus({ direction = "d" }))

-- Resize active window with SUPER + SHIFT + arrow keys
hl.bind("SUPER + SHIFT + right", hl.dsp.window.resize({
  x = 250,
  y = 0,
  relative = true,
}))

hl.bind("SUPER + SHIFT + left", hl.dsp.window.resize({
  x = -250,
  y = 0,
  relative = true,
}))

hl.bind("SUPER + SHIFT + up", hl.dsp.window.resize({
  x = 0,
  y = -250,
  relative = true,
}))

hl.bind("SUPER + SHIFT + down", hl.dsp.window.resize({
  x = 0,
  y = 250,
  relative = true,
}))

-- Switch workspaces with SUPER + 0-9
hl.bind("SUPER + 1", hl.dsp.focus({ workspace = "1" }))
hl.bind("SUPER + 2", hl.dsp.focus({ workspace = "2" }))
hl.bind("SUPER + 3", hl.dsp.focus({ workspace = "3" }))
hl.bind("SUPER + 4", hl.dsp.focus({ workspace = "4" }))
hl.bind("SUPER + 5", hl.dsp.focus({ workspace = "5" }))
hl.bind("SUPER + 6", hl.dsp.focus({ workspace = "6" }))
hl.bind("SUPER + 7", hl.dsp.focus({ workspace = "7" }))
hl.bind("SUPER + 8", hl.dsp.focus({ workspace = "8" }))
hl.bind("SUPER + 9", hl.dsp.focus({ workspace = "9" }))
hl.bind("SUPER + 0", hl.dsp.focus({ workspace = "10" }))

-- Move active window to workspace with SUPER + SHIFT + 0-9
hl.bind("SUPER + SHIFT + 1", hl.dsp.window.move({ workspace = "1" }))
hl.bind("SUPER + SHIFT + 2", hl.dsp.window.move({ workspace = "2" }))
hl.bind("SUPER + SHIFT + 3", hl.dsp.window.move({ workspace = "3" }))
hl.bind("SUPER + SHIFT + 4", hl.dsp.window.move({ workspace = "4" }))
hl.bind("SUPER + SHIFT + 5", hl.dsp.window.move({ workspace = "5" }))
hl.bind("SUPER + SHIFT + 6", hl.dsp.window.move({ workspace = "6" }))
hl.bind("SUPER + SHIFT + 7", hl.dsp.window.move({ workspace = "7" }))
hl.bind("SUPER + SHIFT + 8", hl.dsp.window.move({ workspace = "8" }))
hl.bind("SUPER + SHIFT + 9", hl.dsp.window.move({ workspace = "9" }))
hl.bind("SUPER + SHIFT + 0", hl.dsp.window.move({ workspace = "10" }))

-- Scratchpad
hl.bind("SUPER + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind("SUPER + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through workspaces with SUPER + mouse wheel
hl.bind("SUPER + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind("SUPER + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with SUPER + mouse
hl.bind("SUPER + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind("SUPER + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Volume / mic / brightness keys
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), {
  repeating = true,
  locked = true,
})

hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), {
  repeating = true,
  locked = true,
})

hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), {
  repeating = true,
  locked = true,
})

hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), {
  repeating = true,
  locked = true,
})

hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), {
  repeating = true,
  locked = true,
})

hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), {
  repeating = true,
  locked = true,
})

-- Media keys
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), {
  locked = true,
})

hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), {
  locked = true,
})

hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), {
  locked = true,
})

hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), {
  locked = true,
})
