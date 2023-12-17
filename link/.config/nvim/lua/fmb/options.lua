local o = vim.opt
local g = vim.g

-- -- Custom corner
-- Useful so that I don't repeat myself all over my config, not neovim settings
-- Make neovim transparent
g.transparent = false
-- nvim_open_win border option
g.border = {'┌', '─', '┐', '│', '┘', '─', '└', '│'}
-- Make neovim use icons
g.icons = true
if g.neovide then
  g.guifont = 'JetBrainsMono Nerd Font'
end
-- End of custom corner

g.mapleader = ' '
g.maplocalleader = ' '
g.loaded_perl_provider = 0
g.loaded_ruby_provider = 0
g.loaded_node_provider = 0

-- o.smartindent = true -- Treesitter is handling it
o.backup = false
o.cmdheight = 0
o.expandtab = true
o.fillchars = {eob = " "}
o.hlsearch = true
o.ignorecase = true
o.incsearch = true
o.laststatus = 3 -- Global statusline / overwritten by lualine
o.list = true
o.listchars:append 'eol: ' -- ¬ ↵
o.listchars:append 'lead:⋅'
o.listchars:append 'space: '
o.listchars:append 'tab:  →'
o.listchars:append 'trail:␣'
o.number = true
o.relativenumber = true
o.scrolloff = 6
o.shiftwidth = 4
o.signcolumn = 'yes'
o.smartcase = true
-- o.smoothscroll = true -- is this nightly?
o.softtabstop = 4
o.splitright = true
o.swapfile = true
o.tabstop = 4
o.termguicolors = true
o.undofile = true
o.updatetime = 1000
o.wrap = false