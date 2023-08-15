return {
  'rcarriga/nvim-notify',
  version = '3.*',
  config = function ()
    local opts = {
      top_down = false,
    }

    if vim.g.transparent then
      opts = vim.tbl_extend('force', opts, {background_colour = '#000000'})
    end

    require('notify').setup(opts)
    vim.notify = require('notify')
  end
}
