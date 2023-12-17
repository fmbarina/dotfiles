return {
  'Wansmer/treesj',
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  keys = {
    {'<space>tt', '<cmd>TSJToggle<cr>', desc = 'TreeSJ toggle block'},
    {'<space>ts', '<cmd>TSJSplit<cr>', desc = 'TreeSJ split block'},
    {'<space>tj', '<cmd>TSJJoin<cr>', desc = 'TreeSJ join block'},
  },
  config = function()
    require('treesj').setup({
      use_default_keymaps = false,
    })
  end,
}
