local wezterm = require('wezterm')
local module = {}

local function get_tab_title(tab_info)
  local title = tab_info.tab_title
  -- if the tab title is explicitly set, take that
  if title and #title > 0 then
    return title
  end
  -- Otherwise, use the title from the active pane in that tab
  return tab_info.active_pane.title
end

wezterm.on(
  'format-tab-title',
  function(tab, tabs, panes, config, hover, max_width)
    local tab_title = get_tab_title(tab)

    local allow_unseen = false
    if string.find(tab_title, '^n?vim') then
      tab_title = wezterm.nerdfonts.custom_vim .. ' ' .. tab_title
    elseif string.find(tab_title, '^ncmpc') then
      tab_title = wezterm.nerdfonts.md_playlist_music .. ' ' .. tab_title
    else
      allow_unseen = true
    end

    local title = tab.tab_index .. ': ' .. tab_title
    title = wezterm.truncate_right(title, max_width - 2)

    if tab.is_active then
      return ' ' .. title .. ' '
    end

    for _, pane in ipairs(tab.panes) do
      if allow_unseen and pane.has_unseen_output then
        title = wezterm.truncate_right(title, max_width - 3)
        title = title .. ' …'
        break
      end
    end

    return ' ' .. title .. ' '
  end
)

wezterm.on('update-status', function(window, pane)
  local effective = window:effective_config()

  local format_item = {}
  if effective.use_fancy_tab_bar then
    format_item = { Text = '' }
  else
    local opacity = string.format('%.1f', effective.window_background_opacity)
    format_item = { Text = ' ' .. opacity .. ' ' }
  end

  window:set_left_status(wezterm.format {format_item})
end)

function module.apply_to_config(config)
  config.window_decorations = 'INTEGRATED_BUTTONS|RESIZE'
  config.integrated_title_button_style = 'Gnome'
  config.window_background_opacity = 0.7
  config.window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
  }

  config.enable_tab_bar = true
  config.use_fancy_tab_bar = true
  config.show_new_tab_button_in_tab_bar = true
  config.tab_max_width = 24

  -- Fancy tab
  if config.use_fancy_tab_bar then
    config.tab_bar_at_bottom = false
    config.hide_tab_bar_if_only_one_tab = false
  end

  -- Retro tab
  if not config.use_fancy_tab_bar then
    config.tab_bar_at_bottom = true
    config.hide_tab_bar_if_only_one_tab = true
    config.tab_bar_style = {
      window_hide = 'HIDE',
      window_maximize = ' MAX',
      window_close = ' CLOSE',
      window_hide_hover = 'HIDE',
      window_maximize_hover = ' MAX',
      window_close_hover = ' CLOSE',
    }
  end
end

return module
