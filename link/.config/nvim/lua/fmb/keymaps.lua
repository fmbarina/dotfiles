local bind = require('fmb.util').bind

bind('n', '<leader>pv', vim.cmd.Ex, {desc='Open netrw explorer'})

-- Center cursor in page jumping/searching
bind('n', '<C-d>', '<C-d>zz')
bind('n', '<C-u>', '<C-u>zz')
bind('n', 'n', 'nzzzv')
bind('n', 'N', 'Nzzzv')

-- paste/delete without rewriting buffer (send to void)
bind('x', '<leader>p', '\"_dP', {desc='Paste without overwriting buf'})
bind('n', '<leader>dd', '\"_dP', {desc='Delete without overwriting buf'})
bind('v', '<leader>d', '\'_dP', {desc='Delete line without overwriting buf'})

-- yank to system clipboard
bind('n', '<leader>y', '\"+y', {desc='Yank to system'})
bind('n', '<leader>Y', '\"+Y', {desc='Yank remaining to system'}) -- TODO: this aint right
bind('v', '<leader>y', '\"+y', {desc='yank selection to system'})

-- popup terminal
bind('n', '<C-e>', require('fmb.terminal').toggle)
bind('t', '<C-e>', require('fmb.terminal').toggle)
bind('t', '<esc>', [[<C-\><C-n>]])

-- clear last search highlight
bind('n', '<C-/>', function() vim.cmd.noh() end)