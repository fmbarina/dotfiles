require('fmb.options')
require('fmb.keymaps')
require('fmb.globals')

function Wheremybgat()
  vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
  vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })
end

vim.keymap.set('n', '<leader>bg', function () Wheremybgat() end)

