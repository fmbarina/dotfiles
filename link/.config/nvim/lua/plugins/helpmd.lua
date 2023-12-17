return {
  'fmbarina/helpmd.nvim',
  enabled = true,
  dependencies = {
    'stevearc/dressing.nvim',
    'nvim-telescope/telescope.nvim',
  },
  cmd = {'Helpmd'},
  config = function()
    require('helpmd').setup({
      telescope_preview = false,
      open = 'v_split',
      search_dirs = {
        '__DATA__/lazy',
      },
    })
  end
}
