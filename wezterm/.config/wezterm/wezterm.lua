-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

config.color_scheme = "tokyonight"

config.font = wezterm.font("JetBrains Mono")
config.font_size = 18.0

config.max_fps = 240
config.animation_fps = 120
config.cursor_blink_rate = 800
config.default_cursor_style = "BlinkingBlock"
config.cursor_blink_ease_in = "Constant"
config.cursor_blink_ease_out = "Constant"

config.window_frame = {
  font_size = 14.0,
}
config.macos_window_background_blur = 80
config.pane_focus_follows_mouse = true
config.leader = { key = "b", mods = "CTRL" }
config.default_workspace = "~"

config.window_padding = {
  left = 2,
  right = 2,
  top = 2,
  bottom = 2,
}

wezterm.on("update-right-status", function(window, pane)
  window:set_right_status(window:active_workspace())
end)

local workspace_switcher = wezterm.plugin.require("https://github.com/MLFlexer/smart_workspace_switcher.wezterm")
workspace_switcher.zoxide_path = "/opt/homebrew/bin/zoxide"

-- local session_manager = wezterm.plugin.require("/wezterm-session-manager/session-manager")
-- wezterm.on("save_session", function(window)
--   session_manager.save_state(window)
-- end)
-- wezterm.on("load_session", function(window)
--   session_manager.load_state(window)
-- end)
-- wezterm.on("restore_session", function(window)
--   session_manager.restore_state(window)
-- end)

local act = wezterm.action
local mux = wezterm.mux

config.keys = {
  -- Workspace keys
  { key = "s", mods = "CMD", action = workspace_switcher.switch_workspace() },
  { key = "j", mods = "CMD", action = act.ShowLauncherArgs({ flags = "FUZZY|WORKSPACES", title = "Switcher" }) },
  {
    key = "r",
    mods = "CMD",
    action = act.PromptInputLine({
      description = "Enter new name for workspace",
      action = wezterm.action_callback(function(window, pane, line)
        if line then
          mux.rename_workspace(window:mux_window():get_workspace(), line)
        end
      end),
    }),
  },
  -- {
  --   key = "s",
  --   mods = "CMD|SHIFT",
  --   action = act({ EmitEvent = "save_session" }),
  -- },
  -- {
  --   key = "L",
  --   mods = "CMD|SHIFT",
  --   action = act({ EmitEvent = "load_session" }),
  -- },
  -- {
  --   key = "R",
  --   mods = "CMD|SHIFT",
  --   action = act({ EmitEvent = "restore_session" }),
  -- },

  -- Leader keys
  { key = "[", mods = "LEADER", action = act.ActivateCopyMode },

  -- Tab keys
  { key = "q", mods = "CMD", action = act.ShowTabNavigator },
  { key = "t", mods = "CMD", action = act.SpawnTab("CurrentPaneDomain") },
  { key = "w", mods = "CMD", action = act.CloseCurrentTab({ confirm = true }) },
  { key = "]", mods = "CMD", action = act.ActivateTabRelative(1) },
  { key = "[", mods = "CMD", action = act.ActivateTabRelative(-1) },
  {
    key = ",",
    mods = "CMD",
    action = act.PromptInputLine({
      description = "Enter new name for tab",
      action = wezterm.action_callback(function(window, pane, line)
        if line then
          window:active_tab():set_title(line)
        end
      end),
    }),
  },

  -- Pane keys
  { key = "x", mods = "CMD", action = act.CloseCurrentPane({ confirm = false }) },
  {
    key = "\\",
    mods = "CMD",
    action = act.SplitPane({
      direction = "Right",
      size = { Percent = 50 },
    }),
  },
  {
    key = "'",
    mods = "CMD",
    action = act.SplitPane({
      direction = "Down",
      size = { Percent = 50 },
    }),
  },
  { key = "z", mods = "CMD", action = act.TogglePaneZoomState },
  { key = "{", mods = "CMD|SHIFT", action = act.PaneSelect({ mode = "SwapWithActiveKeepFocus" }) },
  { key = ";", mods = "CMD", action = act.ActivatePaneDirection("Prev") },
  { key = "o", mods = "CMD", action = act.ActivatePaneDirection("Next") },

  -- Attach to muxer
  {
    key = "a",
    mods = "LEADER",
    action = act.AttachDomain("unix"),
  },
  -- Detach from muxer
  {
    key = "d",
    mods = "LEADER",
    action = act.DetachDomain({ DomainName = "unix" }),
  },
}

config.unix_domains = {
  {
    name = "unix",
  },
}

-- set up workspace to be loaded on startup of wezterm
wezterm.on("gui-startup", function(cmd)
  local dotfiles_path = wezterm.home_dir .. "/.dotfiles"
  local tab, build_pane, window = mux.spawn_window({
    workspace = "dotfiles",
    cwd = dotfiles_path,
    args = args,
  })
  build_pane:send_text("nvim\n")
  mux.set_active_workspace("dotfiles")
end)
-- set up keymap for quickly jumping to this workspace

-- Tab bar
config.switch_to_last_active_tab_when_closing_tab = true
config.hide_tab_bar_if_only_one_tab = false
config.use_fancy_tab_bar = false
config.tab_max_width = 32

local function get_current_working_dir(tab)
  local current_dir = tab.active_pane and tab.active_pane.current_working_dir or { file_path = "" }
  local HOME_DIR = string.format("file://%s", os.getenv("HOME"))

  return current_dir == HOME_DIR and "." or string.gsub(current_dir.file_path, "(.*[/\\])(.*)", "%2")
end

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
  local has_unseen_output = false
  if not tab.is_active then
    for _, pane in ipairs(tab.panes) do
      if pane.has_unseen_output then
        has_unseen_output = true
        break
      end
    end
  end

  local cwd = wezterm.format({
    { Attribute = { Intensity = "Bold" } },
    { Text = get_current_working_dir(tab) },
  })

  local title = string.format(" [%s] %s ", tab.tab_index + 1, cwd)

  if has_unseen_output then
    return {
      { Foreground = { Color = "#8866bb" } },
      { Text = title },
    }
  end

  return {
    { Text = title },
  }
end)
-- Tab bar

-- Smart splits
local smart_splits = wezterm.plugin.require("https://github.com/mrjones2014/smart-splits.nvim")

smart_splits.apply_to_config(config, {
  direction_keys = { "h", "j", "k", "l" },
  -- direction_keys = {
  --   move = { "h", "j", "k", "l" },
  --   resize = { "LeftArrow", "DownArrow", "UpArrow", "RightArrow" },
  -- },
  -- modifier keys to combine with direction_keys
  modifiers = {
    move = "CTRL", -- modifier to use for pane movement, e.g. CTRL+h to move left
    resize = "META", -- modifier to use for pane resize, e.g. META+h to resize to the left
  },
})
-- Smart splits

-- and finally, return the configuration to wezterm
return config
