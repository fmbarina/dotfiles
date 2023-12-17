return {
  'nvim-treesitter/nvim-treesitter',
  dependencies = {
    'JoosepAlviste/nvim-ts-context-commentstring',
  },
  build = ':TSUpdate',
  version = '0.*',
  event = {'BufReadPost', 'BufNewFile'},
  cmd = { 'TSUpdateSync' },
  config = function()
    require'nvim-treesitter.configs'.setup({
      ensure_installed = { 'arduino', 'bash', 'c_sharp', 'cmake', 'comment', 'cpp', 'dart', 'diff', 'dockerfile', 'git_config', 'git_rebase', 'gitcommit', 'gitignore', 'html', 'java', 'javascript', 'json', 'kotlin', 'latex', 'make', 'markdown', 'php', 'python', 'regex', 'rst', 'rust', 'toml', 'typescript', 'yaml', 'c', 'lua', 'vim', 'vimdoc', 'query' },
      auto_install = true, -- should have tree-sitter locally installed
      highlight = {
        enable = true,
        disable = function(lang, buf)
          local max_filesize = 100 * 1024 -- 100 KB
          local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
          if ok and stats and stats.size > max_filesize then
            return true
          end
        end,
      },
      indent = {
        enable = true,
        disable = { 'dart' },-- NOTE: dart indent enabled makes editor laggy
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-space>",
          node_incremental = "<C-space>",
          scope_incremental = false,
          node_decremental = "<bs>",
        },
      },
    })
  end
}