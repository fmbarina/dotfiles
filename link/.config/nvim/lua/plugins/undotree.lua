return {
  'mbbill/undotree',
  keys = {
    { "<leader>u", "<cmd>UndotreeToggle<CR>", desc='Toggle undo tree' }
  },
  config = function()
    vim.g.undotree_SetFocusWhenToggle = 1
    vim.g.undotree_RelativeTimestamp = 1
    vim.g.undotree_ShortIndicators = 1
  end
}
