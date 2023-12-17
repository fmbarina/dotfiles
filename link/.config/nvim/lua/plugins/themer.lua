return {
  'themercorp/themer.lua',
  enabled = true,
  config = function()
    require('themer').setup({
      enable_installer = true,
      colorscheme = 'catppuccin',
      transparent = vim.g.transparent,
      styles = {
        ['function'] = { style = 'italic' },
        functionbuiltin = { style = 'italic' },
        variable = { style = 'italic' },
        variableBuiltIn = { style = 'italic' },
        parameter = { style = 'italic' },
      },
    })
  end,
}
