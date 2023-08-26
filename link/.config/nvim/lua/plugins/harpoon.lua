return {
  'theprimeagen/harpoon',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  keys = {
    {
      '<leader>a',
      desc='Add file to harpoon'
    },
  },
  config = function ()
    require('harpoon').setup()
    local mark = require('harpoon.mark')
    local ui = require('harpoon.ui')

    vim.keymap.set('n', '<leader>a', mark.add_file, {desc='Add file to harpoon'})
    vim.keymap.set('n', '<leader>hh', ui.toggle_quick_menu, {desc='Toggle harpoon quick menu'})
    vim.keymap.set('n', '<leader>ha', function () ui.nav_file(1) end, {desc='Quick harpoon nav 1'})
    vim.keymap.set('n', '<leader>hs', function () ui.nav_file(2) end, {desc='Quick harpoon nav 2'})
    vim.keymap.set('n', '<leader>hd', function () ui.nav_file(3) end, {desc='Quick harpoon nav 3'})
    vim.keymap.set('n', '<leader>hf', function () ui.nav_file(4) end, {desc='Quick harpoon nav 4'})
  end
}
