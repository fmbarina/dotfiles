return {
  'folke/neodev.nvim',
  event = 'BufCreate',
  config = function ()
    require('neodev').setup({
      -- With lspconfig, Neodev will automatically setup your
      -- lua-language-server. If you disable this, then you have to set
      -- {before_init=require("neodev.lsp").before_init in the lsp start options
      lspconfig = true,
      pathStrict = true, -- needs lua-language-server >= 3.6.0
    })
  end
}
