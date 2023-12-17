return {
  'stevearc/dressing.nvim',
  event = { 'VeryLazy' },
  config = function()
    local dropdown = require('fmb.util').tele_dropdown(vim.g.border)

    require('dressing').setup({
      input = {
        border = vim.g.border,
      },
      select = {
        telescope = dropdown,
        nui = {
          border = {
            style = vim.g.border,
          },
        },
        builtin = {
          border = vim.g.border,
        },
      },
    })
  end
}