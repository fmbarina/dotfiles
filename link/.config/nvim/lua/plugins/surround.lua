return {
  'kylechui/nvim-surround',
  event = {'BufReadPost', 'BufNewFile'},
  config = function()
    require('nvim-surround').setup()
  end
}
