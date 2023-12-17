return {
  'folke/which-key.nvim',
  event = 'CursorHold',
  config = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 700
    require("which-key").setup({})
  end
}
