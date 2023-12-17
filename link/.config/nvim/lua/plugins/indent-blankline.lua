return {
  'lukas-reineke/indent-blankline.nvim',
  event = {'BufReadPost', 'BufNewFile'},
  config = function()
    local hl = require('fmb.util').hl
    hl('IndentBlanklineScope', {fg = '#F5C2E7'})
    hl('IndentBlanklineCustom', {fg = '#444659'})
    require('ibl').setup({
      indent = {
        -- ▏⎸┆
        char = '│',
        highlight = 'IndentBlanklineCustom',
      },
      scope = {
        enabled = true,
        show_start = false,
        show_end = true,
        highlight = 'IndentBlanklineScope',
      },
    })
  end
}