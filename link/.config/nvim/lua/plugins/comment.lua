return {
  'numToStr/Comment.nvim',
  event = 'CursorMoved',
  config = function()
    require('Comment').setup()
  end
}

