return {
  'kevinhwang91/nvim-ufo',
  dependencies = {
    {'kevinhwang91/promise-async'},
    {'neovim/nvim-lspconfig'},
  },
  event = {'BufReadPost'},
  config = function()
    -- Set those opts
    vim.o.foldlevel = 24 -- Using ufo provider need a large value
    vim.o.foldlevelstart = 24
    vim.o.foldenable = true

    -- Using ufo provider need remap `zR` and `zM`
    local bind = require('fmb.util').bind
    bind('n', 'zR', function() require('ufo').openAllFolds() end)
    bind('n', 'zM', function() require('ufo').closeAllFolds() end)

    require('ufo').setup()
  end,
}
