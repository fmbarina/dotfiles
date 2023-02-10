return {
  'xiyaowong/nvim-cursorword',
  config = function()
    -- disable highlighting for some filetypes
    -- Also, how do you use [] in lua again?
    -- vim.g.cursorword_disable_filetypes = []

    -- disable highlighting at startup.
    -- run :CursorWordEnable or :CursorWordToggle to activate highlighting
    -- vim.g.cursorword_disable_at_startup = true

    -- min width of word
    vim.g.cursorword_min_width = 3

    -- max width of word
    vim.g.cursorword_max_width = 50
  end
}
