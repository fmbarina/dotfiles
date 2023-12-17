return {
  'fmbarina/multicolumn.nvim',
  event = {'BufReadPre', 'BufNewFile'},
  config = function ()
    require('multicolumn').setup({
      start = 'remember',
      base_set = {
        scope = 'window',
        rulers = {81},
      },
      sets = {
        default = {
          rulers = {10, 20, 30, 40, 50, 60, 70, 80, 90, 100},
          bg_color = '#660066',
        },
        lua = {
          scope = 'file',
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
        rust = {
          scope = 'file',
          full_column = true,
        },
        dart = {
          rulers = {100},
          full_column = true,
        },
        sh = {
          scope = 'file',
          to_line_end = true,
        },
        -- zsh = 'sh',
        NeogitCommitMessage = function(_, win)
          return {
            scope = T(vim.fn.line('.', win) == 1, 'line', 'window'),
            rulers = { T(vim.fn.line('.', win) == 1, 51, 73) },
            to_line_end = true,
            bg_color = '#691b1b',
            fg_color = '#ffd8ad',
          }
        end,
      },
      -- update = 5000,
      update = 'on_move',
      exclude_ft = {
        'text', 'help', 'netrw', 'yaml', 'typescript', 'vim', 'markdown',
        'alpha', 'Trouble', 'NeogitStatus', 'NeogitCommitView',
        'NeogitRebaseTodo'
      },
      use_default_set = false,
    })
  end
}