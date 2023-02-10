return {
  'kevinhwang91/rnvimr',
  config = function()
    -- Make Ranger replace Netrw and be the file explorer
    vim.g.rnvimr_enable_ex = 1

    -- Make Ranger to be hidden after picking a file
    vim.g.rnvimr_enable_picker = 1

    -- Change the border's color
    -- let vim.g.rnvimr_border_attr = {'fg': 14, 'bg': -1}

    -- Make Neovim wipe the buffers corresponding to the files deleted by Ranger
    vim.g.rnvimr_enable_bw = 1

    vim.keymap.set("n", "<leader>pr", "<cmd>RnvimrToggle<CR>" )
  end
}
