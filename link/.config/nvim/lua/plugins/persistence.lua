return {
  'fmbarina/persistence.nvim', -- 'folke/persistence.nvim',
  dev = true,
  event = 'BufReadPre',
  config = function()
    local persist = require('persistence')
    local util = require('fmb.util')

    persist.setup()

    util.mkcmd('PersistLoad', function() persist.load() end)
    util.mkcmd('PersistLast', function() persist.load({last = true}) end)
    util.aucmd('Filetype', {
      group = util.augrp('Persistance_git_disable'),
      pattern = {'gitcommit'},
      callback = persist.stop
    })
  end,
}