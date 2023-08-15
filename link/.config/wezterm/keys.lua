local wezterm = require('wezterm')
local act = wezterm.action
local module = {}

wezterm.on('increase-opacity', function(window, pane)
  local overrides = window:get_config_overrides() or {}
  if not overrides.window_background_opacity then
    overrides.window_background_opacity = 0.8
  elseif overrides.window_background_opacity <= 0.9 then
    overrides.window_background_opacity = overrides.window_background_opacity + 0.1
  end
  window:set_config_overrides(overrides)
end)

wezterm.on('decrease-opacity', function(window, pane)
  local overrides = window:get_config_overrides() or {}
  if not overrides.window_background_opacity then
    overrides.window_background_opacity = 0.6
  elseif overrides.window_background_opacity >= 0.1 then
    overrides.window_background_opacity = overrides.window_background_opacity - 0.1
  end
  window:set_config_overrides(overrides)
end)

local keys = {
  {
    key = 'h',
    mods = 'CTRL|SHIFT',
    action = act.ActivatePaneDirection 'Left',
  },
  {
    key = 'l',
    mods = 'CTRL|SHIFT',
    action = act.ActivatePaneDirection 'Right',
  },
  {
    key = 'k',
    mods = 'CTRL|SHIFT',
    action = act.ActivatePaneDirection 'Up',
  },
  {
    key = 'j',
    mods = 'CTRL|SHIFT',
    action = act.ActivatePaneDirection 'Down',
  },
  {
    key = 'w',
    mods = 'CMD',
    action = wezterm.action.CloseCurrentPane { confirm = true },
  },
  {
    key = 'w',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.CloseCurrentTab { confirm = true },
  },
  {
    key = 'i',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.EmitEvent 'increase-opacity',
  },
  {
    key = 'o',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.EmitEvent 'decrease-opacity',
  },
  {
    key = 'r',
    mods = 'CMD|SHIFT',
    action = wezterm.action.ReloadConfiguration,
  },

}

function module.apply_to_config(config)
  config.keys = keys
end

return module
