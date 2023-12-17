return {
  'b0o/incline.nvim',
  event = 'BufReadPre',
  config = function()
    require("incline").setup({
      hide = {
        cursorline = 'focused_win',
        only_win = true,
      },
    })
  end,
}