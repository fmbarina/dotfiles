return {
  'm4xshen/hardtime.nvim',
  enabled = true,
  event = 'CursorMoved',
  config = function ()
    require('hardtime').setup({
      notification = false,
      disabled_filetypes = {
        'undotree', 'qf', 'netrw', 'lazy', 'mason', 'help', 'NeogitCommitView',
        'NeogitStatus', 'NeogitPopup', 'NeogitRebaseTodo', 'Trouble', 'alpha',
      },
    })
  end
}
