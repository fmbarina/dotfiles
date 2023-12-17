return {
  'RRethy/vim-illuminate',
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    local hl = require('fmb.util').hl
    hl('IlluminatedWordRead', {link = 'Visual'})
    hl('IlluminatedWordWrite', {link = 'Visual'})

    require('illuminate').configure({
      filetypes_denylist = {},
    })
  end
}