return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  config = function()
    require'nvim-treesitter.configs'.setup {
      ensure_installed = { 'arduino', 'bash', 'c_sharp', 'cmake', 'comment', 'cpp', 'dart', 'diff', 'dockerfile', 'git_config', 'git_rebase', 'gitcommit', 'gitignore', 'html', 'java', 'javascript', 'json', 'kotlin', 'latex', 'make', 'markdown', 'php', 'python', 'regex', 'rst', 'rust', 'toml', 'typescript', 'yaml', 'c', 'lua', 'vim', 'vimdoc', 'query' },

      -- Install parsers synchronously (only applied to `ensure_installed`)
      sync_install = false,

      -- Automatically install missing parsers when entering buffer
      -- Recommendation: set to false if you don't have `tree-sitter`
      -- CLI installed locally
      auto_install = true,

      highlight = {
        enable = true,

        -- NOTE: these are the names of the parsers and not the filetype.
        -- list of language that will be disabled
        --   disable = { 'c', 'rust' },
        -- Or use a function for more flexibility,
        -- e.g. to disable slow treesitter highlight for large files
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
        -- NOTE: having dart indent enabled makes the editor laggy (in .dart)
        disable = { 'dart' },
      },
    }
  end
}
