return {
  'm4xshen/hardtime.nvim',
  event = 'CursorMoved',
  config = function ()
    require('hardtime').setup({
      notification = false,
      disabled_filetypes = {
        'undotree', 'qf', 'netrw', 'lazy', 'mason', 'help', 'NeogitStatus',
        'NeogitPopup', 'Trouble', 'alpha',
      },
    })
  end
}
