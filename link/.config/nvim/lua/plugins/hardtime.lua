return {
  'm4xshen/hardtime.nvim',
  event = {'BufReadPre', 'BufNewFile'},
  config = function ()
    require('hardtime').setup({
      disable_mouse = false,
      notification = false,
      disabled_filetypes = {
        'undotree', 'qf', 'netrw', 'lazy', 'mason', 'help', 'NeogitCommitView',
        'NeogitStatus', 'NeogitPopup', 'NeogitRebaseTodo', 'Trouble', 'alpha',
        'harpoon', 'Outline', 'lspinfo',
      },
    })
  end
}