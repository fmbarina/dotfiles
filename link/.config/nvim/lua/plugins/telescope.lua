return {
  'nvim-telescope/telescope.nvim',
  version = '0.1.*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    { 'nvim-telescope/telescope-fzf-native.nvim', build = "make" },
    -- 'nvim-telescope/telescope-dap.nvim', TODO: glitchy, come back later?
  },
  cmd = {
    'Telescope',
  },
  keys = {
    {'<leader>ff', '<cmd>Telescope find_files<cr>', desc='Fuzzy search files by filename'},
    {'<leader>ft', '<cmd>Telescope live_grep<cr>', desc='Fuzzy search text in files'},
    {'<leader>fb', '<cmd>Telescope buffers<cr>', desc='Fuzzy search open buffers'},
    {'<leader>fh', '<cmd>Telescope help_tags<cr>', desc='Fuzzy search help terms'},
    {'<leader>fg', '<cmd>Telescope git_files<cr>', desc='Fuzzy search files in git repository'},
    {'<leader>fc', '<cmd>Telescope commands<cr>', desc='Fuzzy search commands'},
    {'<leader>fr', '<cmd>Telescope oldfiles<cr>', desc='Fuzzy search recent files'},
    {'<leader>fs', '<cmd>Telescope grep_string<cr>', desc='Fuzzy search string under cursor'},
  },
  config = function()
    local telescope = require('telescope')

    local extensions = {
      fzf = {
        fuzzy = true,                    -- false will only do exact matching
        override_generic_sorter = true,  -- override the generic sorter
        override_file_sorter = true,     -- override the file sorter
        case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
      },
    }

    telescope.setup({
      pickers = {
        find_files = {
          find_command = { 'rg', '--files', '--hidden', '--glob',
          '!.git/*' },
        },
        live_grep = {
          glob_pattern = {
            '!{.git,.svn,.node_modules}',
          },
          additional_args = function() return {
            '--hidden',
            '--max-depth=16',
          } end
        },
      },
      extensions = extensions,
    })

    telescope.load_extension('fzf')
    -- telescope.load_extension('flutter')
    telescope.load_extension('notify')
  end
}
