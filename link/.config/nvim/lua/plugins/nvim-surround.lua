return {
  'kylechui/nvim-surround',
  event = 'CursorMoved',
  config = function()
    require('nvim-surround').setup()
  end
}
