local alpha = require('alpha')

local headers = {
  ['bonfire'] = {
    " ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣄⠀⠀⠀⠀⠀⠀⠀",
    " ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⠃⠀⠀⠀⠀⠀⠀⠀",
    " ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣸⠀⠀⠀⠀⠀⠀⠀⠀",
    " ⠀⠀⠀⠀⠀⠀⢀⠀⠀⣦⣧⡀⠀⠀⠀⠀⠀⠀⠀",
    " ⠀⠀⠀⠀⠀⠀⠆⠀⡆⢸⠏⠁⠀⠀⠀⠀⠀⠀⠀",
    " ⠀⠀⠀⠀⠀⢸⠀⠀⠈⣼⠀⡀⠀⠀⠀⠀⠀⠀⠀",
    " ⠀⠀⠀⠀⠀⠈⣧⡀⡆⠇⠀⢳⠀⠀⠀⠀⠀⠀⠀",
    " ⠀⠀⠀⠀⢠⠀⢸⡷⣿⠄⡆⡜⠀⠀⠀⠀⠀⠀⠀",
    " ⠀⠀⠀⠀⡈⠁⢞⢱⣿⡀⢿⠀⠀⠀⠀⠀⠀⠀⠀",
    " ⠀⠀⠀⠀⠇⢳⢪⣿⣿⣿⡎⢈⠆⠀⠀⠀⠀⠀⠀",
    " ⠀⠀⠀⠀⠀⠯⢸⣿⣿⣿⣯⢆⢀⣀⠀⠀⠀⠀⠀",
    " ⠀⠀⠀⠴⢒⡐⣛⠿⠿⡟⡨⣊⡤⢖⣲⢄⡀⠀⠀",
    " ⠀⣀⡤⢚⡽⢊⠞⢰⠁⡇⠈⠪⣙⠳⢮⣝⡒⠤⡀",
    " ⠊⠁⠒⢁⡴⠋⠀⡏⠀⣇⠀⠀⠙⠷⠀⠉⠛⠀⠀",
    " ⠀⠀⠘⠉⠀⠀⠀⠁⠀⠙⠀⠀⠀⠀⠀⠀⠀⠀⠀",
  },
}

-- shamelessly stolen from 
-- https://github.com/Alexis12119/nvim-config

local dashboard = require('alpha.themes.dashboard')
dashboard.section.header.val = headers.bonfire

dashboard.section.buttons.val = {
  dashboard.button("f", "  Find File", "<cmd>Lazy load telescope.nvim<cr><bar><cmd>Telescope find_files<cr>"),
  dashboard.button("e", "  New file", "<cmd>ene <bar> startinsert <cr>"),
  dashboard.button("r", "🖿  Recent Files", "<cmd>Lazy load telescope.nvim<cr><bar><cmd>Telescope oldfiles<cr>"),
  dashboard.button("t", "  Find Text", "<cmd>Lazy load telescope.nvim<cr><bar><cmd>Telescope live_grep<cr>"),
  dashboard.button("c", "  Configuration", "<cmd>cd $HOME/.dotfiles<cr><bar><cmd>Ex<cr><cr>"),
  dashboard.button("u", "  Update Plugins", "<cmd>Lazy update<cr>"),
  dashboard.button("q", "  Quit Neovim", "<cmd>qa!<cr>"),
}

local footer = function()
  local version = " " .. vim.version().major .. "." .. vim.version().minor .. "." .. vim.version().patch
  local lazy_ok, lazy = pcall(require, "lazy")
  if lazy_ok then
    local total_plugins = "   " .. lazy.stats().count .. " Plugins"
    local startuptime = (math.floor(lazy.stats().startuptime * 100 + 0.5) / 100)
    return version .. total_plugins .. "  " .. startuptime .. "ms"
  else
    return version
  end
end

vim.api.nvim_create_autocmd("User", {
  pattern = "LazyVimStarted",
  callback = function()
    dashboard.section.footer.val = footer()
  end,
  desc = "Footer for Alpha",
})

dashboard.section.footer.opts.hl = "AlphaFooter"
dashboard.section.header.opts.hl = "AlphaHeader"
dashboard.section.buttons.opts.hl = "AlphaButton"

dashboard.opts.opts.noautocmd = false
alpha.setup(dashboard.opts)
