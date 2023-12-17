return {
  "danymat/neogen",
  dependencies = "nvim-treesitter/nvim-treesitter",
  version = "^2",
  cmd = { 'Neogen' },
  keys = {
    {'<leader>ma', '<cmd>Neogen<cr>', desc = 'Generate code annotation'},
  },
  config = function()
    require('neogen').setup({
      snippet_engine = 'luasnip',
    })
  end
}