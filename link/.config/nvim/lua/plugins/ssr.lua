return {
  'cshuaimin/ssr.nvim',
  keys = {
    {
      '<leader>sr',
      function()
        require('ssr').open()
      end,
      desc = 'Structural search and replace',
    },
  },
  config = function()
    -- reminder: ssr does searching and replacing at AST level, it doesn't
    -- understand code as much as LSP servers do. Use LSP's ssr if possible.
    require('ssr').setup({
      border = vim.g.border,
      min_width = 50,
      min_height = 5,
      max_width = 120,
      max_height = 25,
      keymaps = {
        close = 'q',
        next_match = 'n',
        prev_match = 'N',
        replace_confirm = '<cr>',
        replace_all = '<c-cr>',
      },
    })
  end,
}
