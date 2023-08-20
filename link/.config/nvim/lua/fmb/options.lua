local o = vim.opt
local g = vim.g

-- Custom start

vim.g.transparent = false

-- Custom end

g.mapleader = ' '
g.maplocalleader = ' '

-- o.guicursor = ''

o.number = true
o.relativenumber = true

o.tabstop = 4
o.softtabstop = 4
o.shiftwidth = 4
o.expandtab = true

-- Treesitter is handling it
-- o.smartindent = true

o.wrap = true

o.swapfile = true
o.backup = false
o.undodir = os.getenv('XDG_STATE_HOME') .. '/nvim/undodir'
o.undofile = true

o.hlsearch = true
o.incsearch = true

o.termguicolors = true

o.scrolloff = 6
o.signcolumn = 'yes'
o.cmdheight = 0
o.laststatus = 3 -- Global statusline / overwritten by lualine
o.splitright = true

o.updatetime = 500

o.list = true
o.listchars:append 'eol: ' -- ¬ ↵
o.listchars:append 'space: '
o.listchars:append 'lead:⋅'
o.listchars:append 'trail:␣'
o.listchars:append 'tab:  →'

o.fillchars = {eob = " "}

o.ignorecase = true
o.smartcase = true

