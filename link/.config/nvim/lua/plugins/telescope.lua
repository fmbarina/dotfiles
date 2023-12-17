return {
  "nvim-telescope/telescope.nvim",
  version = "*",
  dependencies = {
    { "nvim-lua/plenary.nvim" },
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    { "debugloop/telescope-undo.nvim" },
    -- { 'chip/telescope-software-licenses.nvim' },
    { 'fmbarina/tsl.nvim' },
    -- 'nvim-telescope/telescope-dap.nvim', TODO: glitchy, come back later?
  },
  cmd = {
    "Telescope",
  },
  keys = {
    { "<leader>ff", "<cmd>Telescope find_files<cr>",  desc = "Fuzzy search files by filename" },
    { "<leader>ft", "<cmd>Telescope live_grep<cr>",   desc = "Fuzzy search text in files" },
    { "<leader>fb", "<cmd>Telescope buffers<cr>",     desc = "Fuzzy search open buffers" },
    { "<leader>fh", "<cmd>Telescope help_tags<cr>",   desc = "Fuzzy search help terms" },
    { "<leader>fg", "<cmd>Telescope git_files<cr>",   desc = "Fuzzy search files in git repository" },
    { "<leader>fc", "<cmd>Telescope commands<cr>",    desc = "Fuzzy search commands" },
    { "<leader>fr", "<cmd>Telescope oldfiles<cr>",    desc = "Fuzzy search recent files" },
    { "<leader>fs", "<cmd>Telescope grep_string<cr>", desc = "Fuzzy search string under cursor" },
    { "<leader>u",  "<cmd>Telescope undo<cr>",        desc = "Fuzzy navigate undo tree" },
  },
  config = function()
    local telescope = require("telescope")
    local convert = require("fmb.util").tele_bdrchars

    local extensions = {
      fzf = {
        fuzzy = true,                   -- false will only do exact matching
        override_generic_sorter = true, -- override the generic sorter
        override_file_sorter = true,    -- override the file sorter
        case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
      },
      undo = {
        side_by_side = true,
      },
    }

    telescope.setup({
      defaults = {
        borderchars = convert(vim.g.border),
        create_layout = nil, -- switch to this when it arrives
      },
      pickers = {
        find_files = {
          find_command = { "fd", "--type=f", "--hidden" },
        },
        live_grep = {
          glob_pattern = {
            "!{.git,.svn,.node_modules,.luarocks,lua_modules}",
          },
          additional_args = function()
            return {
              "--hidden",
              "--max-depth=16",
            }
          end,
        },
      },
      extensions = extensions,
    })

    telescope.load_extension("fzf")
    telescope.load_extension("undo")
    telescope.load_extension("notify")
    telescope.load_extension('software-licenses')
    -- telescope.load_extension('themes')
    -- telescope.load_extension('flutter')
  end,
}