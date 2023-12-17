return {
  'simrat39/symbols-outline.nvim',
  enabled = false,
  event = { 'BufReadPost', 'BufNewFile' },
  config = function()
    require('symbols-outline').setup({
      keymaps = { -- These keymaps can be a string or a table for multiple keys
        focus_location = "o",
        hover_symbol = "<C-space>",
        fold = {'<tab>', 'h'},
        unfold = 'l', -- {'<tab>', 'l'},
        fold_all = {'zM', 'W'},
        unfold_all = {'zR', 'E'},
        fold_reset = "R",
      },
    })
  end
}