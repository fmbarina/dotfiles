local function map(mode, l, r, opts)
  opts = opts or {}
  vim.keymap.set(mode, l, r, opts)
end

map('n', '<leader>pv', vim.cmd.Ex, {desc='Open netrw explorer'})

-- Move selected line region up/down
map('v', 'J', "<cmd>m '>+1<CR>gv=gv")
map('v', 'K', "<cmd>m '<-2<CR>gv=gv")

-- Center cursor in page jumping/searching
map('n', '<C-d>', '<C-d>zz')
map('n', '<C-u>', '<C-u>zz')
map('n', 'n', 'nzzzv')
map('n', 'N', 'Nzzzv')

-- paste/delete without rewriting buffer (send to void)
map('x', '<leader>p', '\"_dP')
map('n', '<leader>d', '\"_dP')
map('v', '<leader>dd', '\'_dP')

-- yank to system clipboard
map('n', '<leader>y', '\"+y')
map('n', '<leader>Y', '\"+Y')
map('v', '<leader>y', '\"+y')

-- popup terminal
map('n', '<C-e>', require('fmb.terminal').toggle)
map('t', '<C-e>', require('fmb.terminal').toggle)
map('t', '<esc>', [[<C-\><C-n>]])

