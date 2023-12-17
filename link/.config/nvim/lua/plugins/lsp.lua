return {
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    lazy = true,
    config = function()
      require('lsp-zero').preset({
        float_border = vim.g.border,
      })
    end,
  },

  -- Autocompletion
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      {
        'L3MON4D3/LuaSnip',
        dependencies = {
          'rafamadriz/friendly-snippets',
          config = function()
            require('luasnip.loaders.from_vscode').lazy_load()
          end,
        },
      },
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'onsails/lspkind.nvim',
    },
    config = function()
      require('lsp-zero').extend_cmp()

      local cmp = require('cmp')
      local cmp_act = require('lsp-zero').cmp_action()
      local lspkind = require('lspkind')

      cmp.setup({
        sources = {
          { name = 'nvim_lsp' }, -- cmp-nvim-lsp (base)
          { name = 'luasnip' },  -- cmp_luasnip / custom snippets
          { name = 'buffer' },   -- cmp-buffer
          { name = 'path' },     -- cmp-path
        },
        mapping = cmp.mapping.preset.insert({
          ['<Tab>'] = cmp_act.luasnip_supertab(),
          ['<S-Tab>'] = cmp_act.luasnip_shift_supertab(),
          ['<CR>'] = cmp.mapping.confirm({ select = false }),
        }),
        window = {
          completion = {
            -- winhighlight = "Normal:Pmenu",
            -- winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
            col_offset = -3,
            side_padding = 0,
          },
        },
        formatting = {
          fields = { 'kind', 'abbr', 'menu' },
          format = function(entry, vim_item)
            local kind = lspkind.cmp_format({
              mode = 'symbol_text',
              maxwidth = 40,
              ellipsis_char = '…',
              menu = {
                nvim_lsp = 'LSP',
                luasnip = 'LUS',
                buffer = 'BUF',
                path = 'PTH',
              },
            })(entry, vim_item)
            local strings = vim.split(kind.kind, '%s', { trimempty = true })
            local src = kind.menu
            kind.kind = ' ' .. (strings[1] or '') .. ' '
            kind.menu = src .. ' ' .. (strings[2] or '')
            return kind
          end,
        },
      })
    end,
  },

  -- LSP
  {
    'neovim/nvim-lspconfig',
    cmd = 'LspInfo',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'williamboman/mason.nvim' },
      { 'williamboman/mason-lspconfig.nvim' },
      -- Info providers
      { 'SmiteshP/nvim-navic' },
      -- {'kevinhwang91/nvim-ufo'},
      -- Lang specific
      { 'folke/neodev.nvim' },
    },
    config = function()
      local lsp = require('lsp-zero')
      local bind = require('fmb.util').bind
      local plf = require('plf')

      lsp.extend_lspconfig()

      lsp.on_attach(function(client, bufnr)
        lsp.default_keymaps({
          buffer = bufnr,
          preserve_mappings = false,
        })
        bind('n', '<leader>lr', function()
          vim.lsp.buf.rename()
        end, { buffer = bufnr, desc = 'LSP rename symbol' })
        bind('n', '<leader>lf', function()
          plf.format({ async = false })
        end, { buffer = bufnr, desc = 'LSP format buffer' })
        bind('n', '<leader>la', function()
          vim.lsp.buf.code_action()
        end, { buffer = bufnr, desc = 'LSP code action' })
        bind('n', '<leader>lh', function()
          local state = vim.diagnostic.config().virtual_text
          vim.diagnostic.config({ virtual_text = not state })
        end, { buffer = bufnr, desc = 'LSP toggle diagnostic hints' })
        -- bind('n', '<leader>ld', function()
        --   if vim.diagnostic.is_disabled() then
        --     vim.diagnostic.enable() -- err, dont wanna investigate right now
        --   else
        --     vim.diagnostic.disable()
        --   end
        -- end, { buffer = bufnr, desc = 'LSP toggle diagnostics' })
        if client.server_capabilities.documentSymbolProvider then
          require('nvim-navic').attach(client, bufnr)
        end
      end)

      lsp.set_server_config({
        capabilities = {
          textDocument = {
            foldingRange = {
              dynamicRegistration = false,
              lineFoldingOnly = true,
            },
          },
        },
      })

      if vim.g.icons then
        lsp.set_sign_icons({
          error = '󰅚 ',
          warn = '󰀪 ',
          info = '󰋽 ',
          hint = '󰌶 ',
        })
      end

      lsp.configure('lua_ls', {
        before_init = require('neodev.lsp').before_init,
      })

      -- Mason must be setup before the next line!
      require('mason-lspconfig').setup({
        ensure_installed = {
          'clangd',
          'efm',      -- general purpose
          'lua_ls',
          'marksman', -- markdown
          'pyright',
          'rust_analyzer',
          -- The following require npm for installation
          'bashls',
          'cssls',  -- vscode-langservers-extracted
          'eslint', -- vscode-langservers-extracted
          'html',   -- vscode-langservers-extracted
          'jsonls', -- vscode-langservers-extracted
        },
        handlers = {
          lsp.default_setup,
          rust_analyzer = lsp.noop, -- we'll let rust-tools handle this
          efm = lsp.noop,           -- done by efmls-configs-nvim
        },
      })
    end,
  },

  {
    'creativenull/efmls-configs-nvim',
    enabled = true,
    version = '1.*',
    dependencies = { 'neovim/nvim-lspconfig' },
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      local languages = require('efmls-configs.defaults').languages()

      languages = vim.tbl_extend('force', languages, {
        python = {
          require('efmls-configs.formatters.black'),
        },
        lua = {
          require('efmls-configs.formatters.stylua'),
        },
      })

      local efmls_cfg = {
        filetypes = vim.tbl_keys(languages),
        settings = {
          rootMarkers = { '.git/' },
          languages = languages,
        },
        init_options = {
          documentFormatting = true,
          documentRangeFormatting = true,
        },
      }
      local capabilities = require('lsp-zero').get_capabilities()

      require('lspconfig').efm.setup(vim.tbl_extend('force', efmls_cfg, {
        -- on_attach = on_attach,
        capabilities = capabilities,
      }))
    end,
  },

  {
    'fmbarina/pick-lsp-formatter.nvim',
    lazy = true,
    config = function()
      require('plf').setup({
        find_project = true,
        find_patterns = { '.git/', 'LICENSE', 'README.md', },
      })
    end
  },

  -- Code nav visualization
  {
    'SmiteshP/nvim-navic',
    lazy = true,
    config = function()
      -- vim.g.navic_silence = true -- uncomment if annoying :^)
      require('nvim-navic').setup({
        separator = ' › ',
        depth_limit = 5,
        depth_limit_indicator = '...',
        lazy_update_context = false, -- only on CursorHold / need perf?
        safe_output = true,
      })
    end,
  },

  {
    'ray-x/lsp_signature.nvim',
    dependencies = 'hrsh7th/nvim-cmp',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      require('lsp_signature').setup({
        hint_enable = false, -- no panda.
      })
    end
  },
}