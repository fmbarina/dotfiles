return {
  'lewis6991/gitsigns.nvim',
  event = {'BufReadPre', 'BufNewFile'},
  config = function()
    require('gitsigns').setup {
      -- signs = {
      --     add          = { text = '│' },
      --     change       = { text = '│' },
      --     delete       = { text = '_' },
      --     topdelete    = { text = '‾' },
      --     changedelete = { text = '~' },
      --     untracked    = { text = '┆' },
      -- },
      trouble = false,
      signcolumn = true,
      current_line_blame = true,
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns
        local bind = require('fmb.util').bind

        -- Navigation
        bind('n', ']g', function()
          -- if vim.wo.diff then return ']c' end
          vim.schedule(function() gs.next_hunk() end)
          return '<Ignore>'
        end, {expr=true, desc='Git next hunk'})

        bind('n', '[g', function()
          -- if vim.wo.diff then return '[c' end
          vim.schedule(function() gs.prev_hunk() end)
          return '<Ignore>'
        end, {expr=true, desc='Git previous hunk'})

        -- Actions
        bind({'n', 'v'}, '<leader>gs', gs.stage_hunk, {desc='Git stage hunk'})
        bind({'n', 'v'}, '<leader>gr', gs.reset_hunk, {desc='Git reset hunk'})
        bind('n', '<leader>gS', gs.stage_buffer, {desc='Git stage buffer'})
        bind('n', '<leader>gR', gs.reset_buffer, {desc='Git reset buffer'})
        bind('n', '<leader>gp', gs.preview_hunk, {desc='Git preview hunk'})
        -- map('n', '<leader>hd', gs.diffthis)
        -- map('n', '<leader>hD', function() gs.diffthis('~') end)
        -- map('n', '<leader>td', gs.toggle_deleted)
        bind('n', '<leader>gt',
          -- FIX: I don't think it's properly toggling current_line_blame
          '<cmd>Gitsigns toggle_signs<CR> <BAR> \
          <cmd>Gitsigns toggle_current_line_blame<CR>',
          {desc='Toggle gitsigns and line blame'}
        )
      end
    }
  end
}
