return {
  'kevinhwang91/rnvimr',
  config = function()
    -- Make Ranger replace Netrw and be the file explorer
    vim.g.rnvimr_enable_ex = 1
    -- Make Ranger to be hidden after picking a file
    vim.g.rnvimr_enable_picker = 1
    -- Replace $EDITOR candidate with this command to open the selected file
    -- vim.g.rnvimr_edit_cmd = "nil -- '$EDITOR'"
    -- Change the border's color
    -- vim.g.rnvimr_border_attr = {fg = 14, bg = -1}
    -- Make Neovim wipe the buffers corresponding to the files deleted by Ranger
    vim.g.rnvimr_enable_bw = 1
    -- Add views for Ranger to adapt the size of floating window
    vim.g.rnvimr_ranger_views = {
      {minwidth = 120, ratio = {2,3,8}},
      {minwidth = 80, maxwidth = 120, ratio = {1,2,4}},
      {maxwidth = 80, ratio = {1,2,3}},
    }
    vim.g.rnvimr_presets = {
      {width = 0.75, height = 0.70},
    }

    vim.keymap.set("n", "<leader>pr", "<cmd>RnvimrToggle<CR>" )
  end
}
