return {
  'simrat39/rust-tools.nvim',
  dependencies = {
    'neovim/nvim-lspconfig',
    'SmiteshP/nvim-navic',
  },
  event = {'BufReadPre *.rs', 'BufNewFile *.rs'},
  config = function ()
    local rt = require('rust-tools')
    local bind = require('fmb.util').bind

    rt.setup({
      server = {
        on_attach = function(client, bufnr)
          bind('n', 'K', rt.hover_actions.hover_actions, { buffer = bufnr })
          bind('n', '<leader>ca', rt.code_action_group.code_action_group, { buffer = bufnr })
          if client.server_capabilities.documentSymbolProvider then
            require('nvim-navic').attach(client, bufnr)
          end
        end,
      },
    })
  end
}
