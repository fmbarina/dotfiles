return {
  'nanozuki/tabby.nvim',
  version = '2.*',
  config = function()
    local theme = {
      fill = 'TabLineFill',
      head = 'TabLine',
      current_tab = 'TabLineSel',
      tab = 'TabLine',
      win = 'TabLine',
      tail = 'TabLine',
    }
    require('tabby.tabline').set(function(line)
      return {
        {
          {' TABS '},
        },
        line.tabs().foreach(function(tab)
          local hl = tab.is_current() and theme.current_tab or theme.tab
          return {
            {'|'},
            tab.number(),
            -- tab.name(),
            {' '},
            hl = hl,
            margin = ' ',
          }
        end),
        line.spacer(),
        line.wins_in_tab(line.api.get_current_tab()).foreach(function(win)
          local hl = win.is_current() and theme.current_tab or theme.tab
          return {
            {' '},
            win.buf_name(),
            {'|'},
            hl = hl,
            margin = ' ',
          }
        end),
        {
          {' BUFFERS '},
        },
        hl = theme.fill,
      },
      {
        tab_name = {
          name_fallback = function(tabid)
            return "fallback name"
          end
        },
        buf_name = {
          mode = "unique", -- unique|relative|tail|shorten
        }
      }
    end)
  end
}
