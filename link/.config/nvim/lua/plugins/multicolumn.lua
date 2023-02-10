return {
  'fmbarina/multicolumn.nvim',
  dev = true,
  config = function ()
    require('multicolumn').setup({
      start = 'remember',
      sets = {
        default = {
          rulers = {},
        },
        lua = {
          scope = 'file',
          rulers = {81},
          full_column = true,
        },
        python = {
          scope = 'window',
          rulers = {80},
          to_line_end = true,
          bg_color = '#f08800',
          fg_color = '#17172e',
        },
        c = {
          rulers = {81},
          to_line_end = true,
          always_on = true,
        },
        NeogitCommitMessage = function(buf, win)
          return {
            scope = T(vim.fn.line('.', win) == 1, 'line', 'window'),
            rulers = { T(vim.fn.line('.', win) == 1, 51, 73) },
            to_line_end = true,
            bg_color = '#691b1b',
            fg_color = '#ffd8ad',
          }
        end,
      },
      disabled_filetypes = {'markdown', 'help', 'netrw', 'alpha', 'Trouble',
        'NeogitStatus',
      }
    })
  end
}
