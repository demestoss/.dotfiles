-- Pull in the wezterm API
local wezterm = require 'wezterm'


-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

config.font = wezterm.font 'JetBrains Mono'
config.font_size = 18.0

config.hide_tab_bar_if_only_one_tab = true
config.window_frame = {
  font_size = 14.0,
}

config.window_decorations = "RESIZE"
config.window_background_opacity = 0.8
config.macos_window_background_blur = 80

config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}

-- For example, changing the color scheme:
config.color_scheme = 'Tokyo Night'

-- config.leader = { key = 'a', mods = 'CTRL' }

local act = wezterm.action

config.keys = {
  -- TMUX keys
  { key = ']', mods = 'CMD', action = act.SendString '\x01n' },
  { key = '[', mods = 'CMD', action = act.SendString '\x01p' },
  { key = 't', mods = 'CMD', action = act.SendString '\x01c' },
  { key = 'w', mods = 'CMD', action = act.SendString '\x01x' },
  { key = ')', mods = 'CMD', action = act.SendString '\x01)' },
  { key = '(', mods = 'CMD', action = act.SendString '\x01(' },
  { key = 's', mods = 'CMD', action = act.SendString '\x01j' },
  { key = 'r', mods = 'CMD', action = act.SendString '\x01$' },
  { key = 'n', mods = 'CMD', action = act.SendString '\x01,' },
  -- { key = 'k', mods = 'CMD', action = act.SendString '\x01k' },
  { key = 'j', mods = 'CMD', action = act.SendString '\x01k' },
  { key = '/', mods = 'CMD', action = act.SendString '\x01[' },
  -- WezTerm keys
}


-- and finally, return the configuration to wezterm
return config
