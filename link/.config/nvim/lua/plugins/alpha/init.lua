return {
  'goolord/alpha-nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
    'fmbarina/persistence.nvim',
  },
  -- event = {'VimEnter'}, --TODO: this importante?
  config = function ()
    require('plugins.alpha.dashboard')
  end
}
