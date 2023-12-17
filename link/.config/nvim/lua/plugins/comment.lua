return {
  'numToStr/Comment.nvim',
  event = { 'BufReadPost', 'BufNewFile' },
  config = function()
    require('Comment').setup({
      -- toggler = {
      --   line = '<leader>cc', --Line-comment toggle keymap
      --   block = '<leader>bc', --Block-comment toggle keymap
      -- },
      -- opleader = {
      --   line = '<leader>cc', --Line-comment keymap
      --   block = '<leader>cb', --Block-comment keymap
      -- },
      -- extra = {
      --   above = '<leader>cO', --Add comment on the line above
      --   below = '<leader>co', --Add comment on the line below
      --   eol = '<leader>ca', --Add comment at the end of line
      -- },
    })
  end
}