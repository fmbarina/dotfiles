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

local function is_vim(pane)
  -- this is set by smart-splits.nvim, and unset on ExitPre in Neovim
  return pane:get_user_vars().IS_NVIM == 'true'
end

local direction_keys = {
  Left = 'h',
  Down = 'j',
  Up = 'k',
  Right = 'l',
  -- reverse lookup
  h = 'Left',
  j = 'Down',
  k = 'Up',
  l = 'Right',
}

local function split_nav(resize_or_move, key)
  return {
    key = key,
    mods = resize_or_move == 'resize' and 'META' or 'CTRL',
    action = wezterm.action_callback(function(win, pane)
      if is_vim(pane) then
        -- pass the keys through to vim/nvim
        win:perform_action({
          SendKey = { key = key, mods = resize_or_move == 'resize' and 'META' or 'CTRL' },
        }, pane)
      else
        if resize_or_move == 'resize' then
          win:perform_action({ AdjustPaneSize = { direction_keys[key], 3 } }, pane)
        else
          win:perform_action({ ActivatePaneDirection = direction_keys[key] }, pane)
        end
      end
    end),
  }
end

local leader = { key = 'Space', mods = 'CTRL', timeout_milliseconds = 3000 }

local keys = {
  -- move between split panes
  split_nav('move', 'h'),
  split_nav('move', 'j'),
  split_nav('move', 'k'),
  split_nav('move', 'l'),
  -- resize panes
  split_nav('resize', 'h'),
  split_nav('resize', 'j'),
  split_nav('resize', 'k'),
  split_nav('resize', 'l'),
  {
    key = 'w',
    mods = 'CTRL|META',
    action = act.CloseCurrentPane { confirm = true },
  },
  {
    key = 'w',
    mods = 'CTRL|SHIFT',
    action = act.CloseCurrentTab { confirm = true },
  },
  {
    key = 'i',
    mods = 'CTRL|SHIFT',
    action = act.EmitEvent 'increase-opacity',
  },
  {
    key = 'o',
    mods = 'CTRL|SHIFT',
    action = act.EmitEvent 'decrease-opacity',
  },
  {
    key = 'R',
    mods = 'CTRL|SHIFT',
    action = act.ReloadConfiguration,
  },
  {
    key = 's',
    mods = 'LEADER',
    action = act.SplitVertical { domain = 'CurrentPaneDomain' },
  },
  {
    key = 'v',
    mods = 'LEADER',
    action = act.SplitHorizontal { domain = 'CurrentPaneDomain' },
  },
  -- remap debug overlay since I want to use <C-L> in nvim
  {
    key = 'L',
    mods = 'CTRL|SHIFT',
    action = 'DisableDefaultAssignment',
  },
  {
    key = 'L',
    mods = 'LEADER|CTRL|SHIFT',
    action = act.ShowDebugOverlay,
  }
}

function module.apply_to_config(config)
  config.leader = leader
  config.keys = keys
end

return module