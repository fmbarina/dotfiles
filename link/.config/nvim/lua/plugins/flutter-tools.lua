return {
  'akinsho/flutter-tools.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'stevearc/dressing.nvim', -- optional for vim.ui.select
  },
  event = 'BufCreate *.dart',
  config = function()
    require('flutter-tools').setup{
      widget_guides = {
        enabled = true;
      },
      closing_tags = {
        -- highlight = "ErrorMsg",
        prefix = "> ",
        enabled = true
      },
      lsp = {
        color = { -- show the derived colours for dart variables
          enabled = true,
        },
        settings = {
          lineLength = 10
        }
      }
    }
  end
}
