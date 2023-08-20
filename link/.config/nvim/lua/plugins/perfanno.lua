return {
  't-troebst/perfanno.nvim',
  dependencies = {
    'nvim-telescope/telescope.nvim',
  },
  cmd = {
    'PerfLoadFlat',
    'PerfLoadCallGraph',
    'PerfLoadFlameGraph',
    'PerfLuaProfileStart',
    'PerfCacheLoad',
    'PerfCacheDelete',
  },
  config = function ()
    local perfanno = require('perfanno')
    local util = require('perfanno.util')

    local bg_color = require('fmb.utils').get_hl_value('Normal', 'bg')
    local hot_color = '#CC3300'

    perfanno.setup({
      line_highlights = util.make_bg_highlights(bg_color, hot_color, 10),
      vt_highlight = util.make_fg_highlight(hot_color),
    })
  end
}
