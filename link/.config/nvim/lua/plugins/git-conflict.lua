return {
  'akinsho/git-conflict.nvim',
  version = "*",
  config = function ()
    vim.cmd[[highlight GitConflictIncoming ctermbg=0 guibg=#1D2622]]
    vim.cmd[[highlight GitConflictCurrent ctermbg=0 guibg=#283741]]

    require('git-conflict').setup({
      highlights = {
        incoming = 'GitConflictIncoming',
        current = 'GitConflictCurrent',
      },
    })
  end
}

