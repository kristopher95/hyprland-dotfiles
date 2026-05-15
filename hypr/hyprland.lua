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
  hl.exec_cmd(terminal)
end)

-- Basic app binds
hl.bind("SUPER + Return", hl.dsp.exec_cmd(terminal))
hl.bind("SUPER + D", hl.dsp.exec_cmd(menu))
hl.bind("SUPER + E", hl.dsp.exec_cmd(file_manager))
hl.bind("SUPER + Q", hl.dsp.window.close())

-- Session
hl.bind("SUPER + M", hl.dsp.exit())

-- Window state
hl.bind("SUPER + F", hl.dsp.window.fullscreen({
  mode = "fullscreen",
  action = "toggle",
}))

hl.bind("SUPER + V", hl.dsp.window.float({
  action = "toggle",
}))

-- Workspace switching
hl.bind("SUPER + 1", hl.dsp.focus({ workspace = "1" }))
hl.bind("SUPER + 2", hl.dsp.focus({ workspace = "2" }))
hl.bind("SUPER + 3", hl.dsp.focus({ workspace = "3" }))
hl.bind("SUPER + 4", hl.dsp.focus({ workspace = "4" }))
hl.bind("SUPER + 5", hl.dsp.focus({ workspace = "5" }))

-- Move window to workspace
hl.bind("SUPER + SHIFT + 1", hl.dsp.window.move({ workspace = "1" }))
hl.bind("SUPER + SHIFT + 2", hl.dsp.window.move({ workspace = "2" }))
hl.bind("SUPER + SHIFT + 3", hl.dsp.window.move({ workspace = "3" }))
hl.bind("SUPER + SHIFT + 4", hl.dsp.window.move({ workspace = "4" }))
hl.bind("SUPER + SHIFT + 5", hl.dsp.window.move({ workspace = "5" }))

-- Resize binds
hl.bind("SUPER + SHIFT + right", hl.dsp.window.resize({
  x = 10,
  y = 0,
  relative = true,
}))

hl.bind("SUPER + SHIFT + left", hl.dsp.window.resize({
  x = -10,
  y = 0,
  relative = true,
}))

hl.bind("SUPER + SHIFT + up", hl.dsp.window.resize({
  x = 0,
  y = -10,
  relative = true,
}))

hl.bind("SUPER + SHIFT + down", hl.dsp.window.resize({
  x = 0,
  y = 10,
  relative = true,
}))
