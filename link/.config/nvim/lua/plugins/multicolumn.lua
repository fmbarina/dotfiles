return {
  'fmbarina/multicolumn.nvim',
  enabled = true,
  dev = true,
  config = function ()
    require('multicolumn').setup({
      start = 'remember',
      base_set = {
        scope = 'window',
        rulers = {81},
      },
      sets = {
        default = {
          rulers = {10, 20, 30, 40, 50},
          bg_color = '#f08800',
        },
        lua = {
          -- scope = 'file',
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
          to_line_end = true,
          always_on = true,
        },
        sh = {
          scope = 'file',
          to_line_end = true,
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
      use_default_set = false,
    })
  end
}
