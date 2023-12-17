return {
  {
    'echasnovski/mini.move',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      require('mini.move').setup({
        mappings = {
          -- Since we'll only move in visual, just use shift as mod
          left = 'H',
          right = 'L',
          down = 'J',
          up = 'K',
          -- disable normal mode movement. Only visual!
          line_left = '',
          line_right = '',
          line_down = '',
          line_up = '',
        },
      })
    end
  },
}