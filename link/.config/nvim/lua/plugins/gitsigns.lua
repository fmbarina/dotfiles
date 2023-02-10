return {
  'lewis6991/gitsigns.nvim',
  event = 'BufCreate',
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

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map('n', ']c', function()
          if vim.wo.diff then return ']c' end
          vim.schedule(function() gs.next_hunk() end)
          return '<Ignore>'
        end, {expr=true})

        map('n', '[c', function()
          if vim.wo.diff then return '[c' end
          vim.schedule(function() gs.prev_hunk() end)
          return '<Ignore>'
        end, {expr=true})

        -- Actions
        map({'n', 'v'}, '<leader>gs', gs.stage_hunk, {desc='Git stage hunk'})
        map({'n', 'v'}, '<leader>gr', gs.reset_hunk, {desc='Git reset hunk'})
        map('n', '<leader>gS', gs.stage_buffer, {desc='Git stage buffer'})
        map('n', '<leader>gR', gs.reset_buffer, {desc='Git reset buffer'})
        map('n', '<leader>gp', gs.preview_hunk, {desc='Git preview hunk'})
        -- map('n', '<leader>hd', gs.diffthis)
        -- map('n', '<leader>hD', function() gs.diffthis('~') end)
        -- map('n', '<leader>td', gs.toggle_deleted)
        map('n', '<leader>gt',
          -- FIX: I don't think is toggling current_line_blame
          '<cmd>Gitsigns toggle_signs<CR> <BAR> \
          <cmd>Gitsigns toggle_current_line_blame<CR>',
          {desc='Toggle gitsigns and line blame'}
        )
      end
    }
  end
}
