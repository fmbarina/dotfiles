local wezterm = require('wezterm')
local visual = require('visual')
local keys = require('keys')

-- In newer versions of wezterm, use the config_builder
local config = {}
if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.automatically_reload_config = false

visual.apply_to_config(config)
keys.apply_to_config(config)

return config
