return {
  'NeogitOrg/neogit',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'sindrets/diffview.nvim',
  },
  keys = {
    {'<leader>gg', '<cmd>Neogit<cr>', desc='Open neogit'},
  },
  config = function()
    require('neogit').setup {
      kind = 'split',
      integrations = {
        diffview = true
      },
    }
  end
}
