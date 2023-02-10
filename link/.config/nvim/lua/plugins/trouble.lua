return {
  'folke/trouble.nvim',
  dependencies = 'nvim-tree/nvim-web-devicons',
  keys = {
    {'<leader>xx', '<cmd>TroubleToggle<cr>', desc='Toggle trouble split'},
    {'<leader>xw', '<cmd>TroubleToggle workspace_diagnostics<cr>',
    desc='Trouble workspace diagnostics'},
    {'<leader>xd', '<cmd>TroubleToggle document_diagnostics<cr>',
    desc='Trouble document diagnostics'},
    {'<leader>xl', '<cmd>TroubleToggle loclist<cr>', desc='Trouble loclist'},
    {'<leader>xq', '<cmd>TroubleToggle quickfix<cr>', desc='Trouble quickfix'},
    {'<leader>xr', '<cmd>TroubleToggle lsp_references<cr>',
    desc='Trouble lsp references'},
  },
  config = function()
    require('trouble').setup {
    }
  end
}
