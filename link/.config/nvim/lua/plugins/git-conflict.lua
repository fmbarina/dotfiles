return {
  'akinsho/git-conflict.nvim',
  version = "^1",
  event = { "BufReadPre", "BufNewFile" },
  config = function ()
    local hl = require('fmb.util').hl
    hl('GitConflictIncoming', {bg = '#283741'})
    hl('GitConflictCurrent', {bg = '#1D2622'})

    require('git-conflict').setup({
      highlights = {
        incoming = 'GitConflictIncoming',
        current = 'GitConflictCurrent',
      },
    })
  end
}
