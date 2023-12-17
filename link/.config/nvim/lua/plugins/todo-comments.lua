return {
  'folke/todo-comments.nvim',
  version = '^1',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'folke/trouble.nvim',
  },
  cmd = { 'TodoTrouble', 'TodoTelescope' },
  event = { 'BufReadPost', 'BufNewFile' },
  config = function()
    require('todo-comments').setup({
      keywords = {
        FIX = { icon = " ", color = "error", alt = { "FIXME", "BUG", "ISSUE" } },
        TODO = { icon = " ", color = "info" },
        HACK = { icon = " ", color = "warning" },
        WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
        PERF = { icon = "󰅒 ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
        NOTE = { icon = "󰍨 ", color = "hint", alt = { "INFO" } },
        TEST = { icon = "󰢨 ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
        -- FIX:
        -- TODO:
        -- HACK:
        -- WARN:
        -- PERF:
        -- NOTE:
        -- TEST:
      },
    })
    vim.keymap.set('n', '<leader>xt', '<cmd>TodoTrouble<cr>')
  end
}