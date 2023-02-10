return {
  'folke/todo-comments.nvim',
  version = '1.*',
  event = 'BufCreate',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'folke/trouble.nvim',
  },
  config = function()
    require('todo-comments').setup({
      keywords = {
        -- TODO: = { icon = " ", color = "info" },
        -- HACK: = { icon = " ", color = "warning" },
        -- WARN: = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
        -- PERF: = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
        -- NOTE: = { icon = " ", color = "hint", alt = { "INFO" } },
        -- TEST: = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
      },
    })
    vim.keymap.set('n', '<leader>xt', '<cmd>TodoTrouble<cr>')
  end
}
