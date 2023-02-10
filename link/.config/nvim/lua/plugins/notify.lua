return {
  'rcarriga/nvim-notify',
  version = '3.*',
  config = function ()
    -- require('notify').setup()
    vim.notify = require('notify')
  end
}
