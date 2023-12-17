return {
  'folke/neodev.nvim',
  lazy = true,
  config = function ()
    require('neodev').setup({
      -- lspconfig: If you disable this, then you have to set
      -- before_init=require("neodev.lsp").before_init in the lsp start options
      lspconfig = false,
      pathStrict = true, -- needs lua-language-server >= 3.6.0
    })
  end
}
