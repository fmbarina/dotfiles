-- Proper dart indenting?
vim.opt_local.tabstop = 2
vim.opt_local.softtabstop = 2
vim.opt_local.shiftwidth = 2
vim.opt_local.expandtab = true

-- This breaks syntax hightlighting. why?
-- -vim.api.nvim_buf_set_keymap(0, "n", "<leader>pp", "<cmd>!dart format .<CR>",
--     {desc="Format project dart code"}
-- )

