return {
  'mrjones2014/smart-splits.nvim',
  version = '^1',
  config = function()
    -- NOTE: it is not recommended to lazy load this plugin
    local bind = require('fmb.util').bind

    -- resizing splits
    bind('n', '<M-h>', require('smart-splits').resize_left)
    bind('n', '<M-j>', require('smart-splits').resize_down)
    bind('n', '<M-k>', require('smart-splits').resize_up)
    bind('n', '<M-l>', require('smart-splits').resize_right)
    -- moving between splits
    bind('n', '<C-h>', require('smart-splits').move_cursor_left)
    bind('n', '<C-j>', require('smart-splits').move_cursor_down)
    bind('n', '<C-k>', require('smart-splits').move_cursor_up)
    bind('n', '<C-l>', require('smart-splits').move_cursor_right)
    -- swapping buffers between windows
    bind('n', '<leader><leader>h', require('smart-splits').swap_buf_left)
    bind('n', '<leader><leader>j', require('smart-splits').swap_buf_down)
    bind('n', '<leader><leader>k', require('smart-splits').swap_buf_up)
    bind('n', '<leader><leader>l', require('smart-splits').swap_buf_right)

    require('smart-splits').setup({
      resize_mode = {
        hooks = {
          on_leave = require('bufresize').register,
        },
      },
    })
  end
}