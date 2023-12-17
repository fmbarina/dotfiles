return {
  'akinsho/flutter-tools.nvim',
  version = '^1',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'stevearc/dressing.nvim', -- optional for vim.ui.select
    'neovim/nvim-lspconfig',
  },
  event = { 'BufReadPre *.dart', 'BufNewFile *.dart' },
  config = function()
    local lsp = require('lsp-zero')
    local dart_lsp = lsp.build_options('dartls', {})

    require('flutter-tools').setup {
      ui = {
        -- border = '',
        notification_style = 'plugin',
      },
      widget_guides = {
        enabled = true,
      },
      closing_tags = {
        -- highlight = "ErrorMsg",
        prefix = "> ",
        enabled = true
      },
      lsp = {
        capabilities = dart_lsp.capabilities,
        color = { -- show the derived colours for dart variables
          enabled = true,
        },
        settings = {
          enableSnippets = false,
        }
      }
    }
  end
}