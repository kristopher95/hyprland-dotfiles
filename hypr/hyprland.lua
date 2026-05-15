-- ~/.config/hypr/hyprland.lua
-- Hyprland 0.55.1 Lua config

------------------------------------------------------------
-- Programs
------------------------------------------------------------

local terminal = "kitty"
local file_manager = "dolphin"
local menu = "/home/kris/.scripts/toggle_rofi_drun.sh"

------------------------------------------------------------
-- Environment variables
------------------------------------------------------------

hl.env("XCURSOR_SIZE", "38")
hl.env("HYPRCURSOR_SIZE", "38")

-- NVIDIA
hl.env("LIBVA_DRIVER_NAME", "nvidia")
hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")

------------------------------------------------------------
-- Monitors
------------------------------------------------------------

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

------------------------------------------------------------
-- Workspace rules
------------------------------------------------------------

-- Main ultrawide workspaces on DP-3
hl.workspace_rule({ workspace = "1", monitor = "DP-3", default = true })
hl.workspace_rule({ workspace = "2", monitor = "DP-3" })
hl.workspace_rule({ workspace = "3", monitor = "DP-3" })
hl.workspace_rule({ workspace = "4", monitor = "DP-3" })
hl.workspace_rule({ workspace = "5", monitor = "DP-3" })
hl.workspace_rule({ workspace = "6", monitor = "DP-3" })
hl.workspace_rule({ workspace = "7", monitor = "DP-3" })
hl.workspace_rule({ workspace = "8", monitor = "DP-3" })

-- Secondary monitor workspaces on DP-1
hl.workspace_rule({ workspace = "11", monitor = "DP-1", default = true })
hl.workspace_rule({ workspace = "12", monitor = "DP-1" })
hl.workspace_rule({ workspace = "13", monitor = "DP-1" })
hl.workspace_rule({ workspace = "14", monitor = "DP-1" })
hl.workspace_rule({ workspace = "15", monitor = "DP-1" })
hl.workspace_rule({ workspace = "16", monitor = "DP-1" })
hl.workspace_rule({ workspace = "17", monitor = "DP-1" })
hl.workspace_rule({ workspace = "18", monitor = "DP-1" })

------------------------------------------------------------
-- Hyprland settings
------------------------------------------------------------

hl.config({
  input = {
    kb_layout = "us",
    kb_variant = "",
    kb_model = "",
    kb_options = "",
    kb_rules = "",

    follow_mouse = 1,
    sensitivity = -0.5,

    touchpad = {
      natural_scroll = false,
    },
  },

  general = {
    gaps_in = 1,
    gaps_out = 1,

    border_size = 2,

    ["col.active_border"] = {
      colors = {
        "rgba(33ccffee)",
          "rgba(00ff99ee)",
      },
      angle = 45,
    },

    ["col.inactive_border"] = {
      colors = {
        "rgba(595959aa)",
      },
    },

    resize_on_border = false,
    allow_tearing = false,

    layout = "dwindle",
  },

  decoration = {
    rounding = 0,
    rounding_power = 2,

    active_opacity = 1.0,
    inactive_opacity = 1.0,

    shadow = {
      enabled = true,
      range = 4,
      render_power = 3,
      color = "rgba(1a1a1aee)",
    },

    blur = {
      enabled = true,
      size = 3,
      passes = 1,
      vibrancy = 0.1696,
    },
  },

  dwindle = {
    preserve_split = true,
  },

  master = {
    new_status = "master",
  },

  misc = {
    force_default_wallpaper = -1,
      disable_hyprland_logo = false,
  },
})

------------------------------------------------------------
-- Animations
------------------------------------------------------------

hl.curve("easeOutQuint", {
  type = "bezier",
  points = {
    { 0.23, 1 },
    { 0.32, 1 },
  },
})

hl.curve("easeInOutCubic", {
  type = "bezier",
  points = {
    { 0.65, 0.05 },
    { 0.36, 1 },
  },
})

hl.curve("linear", {
  type = "bezier",
  points = {
    { 0, 0 },
    { 1, 1 },
  },
})

hl.curve("almostLinear", {
  type = "bezier",
  points = {
    { 0.5, 0.5 },
    { 0.75, 1 },
  },
})

hl.curve("quick", {
  type = "bezier",
  points = {
    { 0.15, 0 },
    { 0.1, 1 },
  },
})

hl.animation({
  leaf = "global",
  enabled = true,
  speed = 10,
  bezier = "default",
})

hl.animation({
  leaf = "border",
  enabled = true,
  speed = 5.39,
  bezier = "easeOutQuint",
})

hl.animation({
  leaf = "windows",
  enabled = true,
  speed = 4.79,
  bezier = "easeOutQuint",
})

hl.animation({
  leaf = "windowsIn",
  enabled = true,
  speed = 4.1,
  bezier = "easeOutQuint",
  style = "popin 87%",
})

hl.animation({
  leaf = "windowsOut",
  enabled = true,
  speed = 1.49,
  bezier = "linear",
  style = "popin 87%",
})

hl.animation({
  leaf = "fadeIn",
  enabled = true,
  speed = 1.73,
  bezier = "almostLinear",
})

hl.animation({
  leaf = "fadeOut",
  enabled = true,
  speed = 1.46,
  bezier = "almostLinear",
})

hl.animation({
  leaf = "fade",
  enabled = true,
  speed = 3.03,
  bezier = "quick",
})

hl.animation({
  leaf = "layers",
  enabled = true,
  speed = 3.81,
  bezier = "easeOutQuint",
})

hl.animation({
  leaf = "layersIn",
  enabled = true,
  speed = 4,
  bezier = "easeOutQuint",
  style = "fade",
})

hl.animation({
  leaf = "layersOut",
  enabled = true,
  speed = 1.5,
  bezier = "linear",
  style = "fade",
})

hl.animation({
  leaf = "fadeLayersIn",
  enabled = true,
  speed = 1.79,
  bezier = "almostLinear",
})

hl.animation({
  leaf = "fadeLayersOut",
  enabled = true,
  speed = 1.39,
  bezier = "almostLinear",
})

hl.animation({
  leaf = "workspaces",
  enabled = false,
})

hl.animation({
  leaf = "workspacesIn",
  enabled = false,
})

hl.animation({
  leaf = "workspacesOut",
  enabled = false,
})

hl.animation({
  leaf = "zoomFactor",
  enabled = true,
  speed = 7,
  bezier = "quick",
})

------------------------------------------------------------
-- Autostart
------------------------------------------------------------

hl.on("hyprland.start", function()
-- Bars
hl.exec_cmd("waybar -c ~/.config/waybar/config-main.jsonc -s ~/.config/waybar/style.css")
hl.exec_cmd("waybar -c ~/.config/waybar/config-secondary.jsonc -s ~/.config/waybar/style.css")

-- Instant Waybar workspace refresh
hl.exec_cmd("pkill -f hypr_ws_signal.sh; /home/kris/.config/waybar/scripts/hypr_ws_signal.sh")

-- Workspace-based wallpaper automation
hl.exec_cmd("/home/kris/.scripts/workspace_wallpaper_daemon.sh")

-- Idle/lock handling
hl.exec_cmd("hypridle")

-- Eww widgets
hl.exec_cmd("eww daemon")

-- Polkit auth agent
hl.exec_cmd("/usr/lib/polkit-kde-authentication-agent-1")

-- Old monitor-init workaround from your legacy config
hl.exec_cmd("sh -c 'sleep 2; hyprctl reload'")
end)

------------------------------------------------------------
-- Keybinds
------------------------------------------------------------

-- Shortcut cheat sheet
hl.bind("SUPER + slash", hl.dsp.exec_cmd("/home/kris/.scripts/show_hypr_binds.sh"))

-- Main app/window binds
hl.bind("SUPER + Q", hl.dsp.exec_cmd(terminal))
hl.bind("SUPER + C", hl.dsp.window.close())

hl.bind(
  "SUPER + M",
  hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'")
)

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

-- Screenshot selected area
hl.bind(
  "SUPER + SHIFT + S",
  hl.dsp.exec_cmd([[mkdir -p "$HOME/Pictures/Screenshots" && FILE="$HOME/Pictures/Screenshots/screenshot-$(date +'%Y-%m-%d_%H-%M-%S').png" && grim -g "$(slurp)" "$FILE" && wl-copy < "$FILE"]])
)

-- Lock screen
hl.bind("SUPER + L", hl.dsp.exec_cmd("hyprlock"))

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

------------------------------------------------------------
-- Independent monitor workspace keybinds
------------------------------------------------------------

-- Switch workspace only.
-- These must call switch_workspace_by_monitor.sh.
-- They must NOT use hl.dsp.window.move().
hl.bind("SUPER + 1", hl.dsp.exec_cmd("/home/kris/.scripts/switch_workspace_by_monitor.sh 1"))
hl.bind("SUPER + 2", hl.dsp.exec_cmd("/home/kris/.scripts/switch_workspace_by_monitor.sh 2"))
hl.bind("SUPER + 3", hl.dsp.exec_cmd("/home/kris/.scripts/switch_workspace_by_monitor.sh 3"))
hl.bind("SUPER + 4", hl.dsp.exec_cmd("/home/kris/.scripts/switch_workspace_by_monitor.sh 4"))
hl.bind("SUPER + 5", hl.dsp.exec_cmd("/home/kris/.scripts/switch_workspace_by_monitor.sh 5"))
hl.bind("SUPER + 6", hl.dsp.exec_cmd("/home/kris/.scripts/switch_workspace_by_monitor.sh 6"))
hl.bind("SUPER + 7", hl.dsp.exec_cmd("/home/kris/.scripts/switch_workspace_by_monitor.sh 7"))
hl.bind("SUPER + 8", hl.dsp.exec_cmd("/home/kris/.scripts/switch_workspace_by_monitor.sh 8"))

-- Move active window only.
-- These must call move_window_to_workspace_by_monitor.sh.
hl.bind("SUPER + SHIFT + 1", hl.dsp.exec_cmd("/home/kris/.scripts/move_window_to_workspace_by_monitor.sh 1"))
hl.bind("SUPER + SHIFT + 2", hl.dsp.exec_cmd("/home/kris/.scripts/move_window_to_workspace_by_monitor.sh 2"))
hl.bind("SUPER + SHIFT + 3", hl.dsp.exec_cmd("/home/kris/.scripts/move_window_to_workspace_by_monitor.sh 3"))
hl.bind("SUPER + SHIFT + 4", hl.dsp.exec_cmd("/home/kris/.scripts/move_window_to_workspace_by_monitor.sh 4"))
hl.bind("SUPER + SHIFT + 5", hl.dsp.exec_cmd("/home/kris/.scripts/move_window_to_workspace_by_monitor.sh 5"))
hl.bind("SUPER + SHIFT + 6", hl.dsp.exec_cmd("/home/kris/.scripts/move_window_to_workspace_by_monitor.sh 6"))
hl.bind("SUPER + SHIFT + 7", hl.dsp.exec_cmd("/home/kris/.scripts/move_window_to_workspace_by_monitor.sh 7"))
hl.bind("SUPER + SHIFT + 8", hl.dsp.exec_cmd("/home/kris/.scripts/move_window_to_workspace_by_monitor.sh 8"))

-- Scroll through existing workspaces with SUPER + mouse wheel
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

------------------------------------------------------------
-- Window rules
------------------------------------------------------------

hl.window_rule({
  name = "suppress-maximize-events",
  match = {
    class = ".*",
  },

  suppress_event = "maximize",
})

hl.window_rule({
  name = "fix-xwayland-drags",
  match = {
    class = "^$",
    title = "^$",
    xwayland = true,
    float = true,
    fullscreen = false,
    pin = false,
  },

  no_focus = true,
})

hl.window_rule({
  name = "move-hyprland-run",
  match = {
    class = "hyprland-run",
  },

  move = { 20, "monitor_h-120" },
  float = true,
})
