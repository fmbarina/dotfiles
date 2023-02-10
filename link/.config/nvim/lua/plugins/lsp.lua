return {
  'VonHeikemen/lsp-zero.nvim',
  branch = 'v1.x',
  event = 'CursorMoved',
  dependencies = {
    -- LSP Support
    {'neovim/nvim-lspconfig'},             -- Required
    {'williamboman/mason.nvim'},           -- Optional
    {'williamboman/mason-lspconfig.nvim'}, -- Optional

    -- Autocompletion
    {'hrsh7th/nvim-cmp'},         -- Required
    {'hrsh7th/cmp-nvim-lsp'},     -- Required
    {'hrsh7th/cmp-buffer'},       -- Optional
    {'hrsh7th/cmp-path'},         -- Optional
    {'saadparwaiz1/cmp_luasnip'}, -- Optional
    {'hrsh7th/cmp-nvim-lua'},     -- Optional

    -- Snippets
    {'L3MON4D3/LuaSnip'},             -- Required
    {'rafamadriz/friendly-snippets'}, -- Optional
  },
  config = function()
    local lsp = require('lsp-zero').preset({
      name = 'manual-setup',
      suggest_lsp_servers = true,
    })

    lsp.ensure_installed({
      'lua_ls',
      'marksman', -- markdown
      'pyright', -- python
      -- The following require npm for installation
      'bashls',
      'cssls', -- vscode-langservers-extracted
      'eslint', -- vscode-langservers-extracted
      'html', -- vscode-langservers-extracted
      'jsonls', -- vscode-langservers-extracted
    })

    lsp.nvim_workspace()

    lsp.setup()
  end
}
