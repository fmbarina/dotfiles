return {
  'nvim-lualine/lualine.nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
    'SmiteshP/nvim-navic',
  },
  event = {'VeryLazy'},
  config = function()
    local function get_current_ls()
      local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
      local clients = vim.lsp.get_active_clients()
      if next(clients) == nil then
        return false
      end
      for _, client in ipairs(clients) do
        local filetypes = client.config.filetypes
        if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
          return client.name
        end
      end
      return false
    end

    local function file_or_ls()
      local msg = vim.bo.filetype
      local ls = get_current_ls()
      if ls then
        msg = '󱐋 ' .. ls .. ' '
      end
      return msg
    end

    local navic = require('nvim-navic')
    local function is_available() return navic.is_available() end
    local function get_location() return navic.get_location() end

    require('lualine').setup {
      options = {
        icons_enabled = false,
        -- theme = 'oxocarbon',
        component_separators = '',
        section_separators = '',
        ignore_focus = {},
        globalstatus = true,
      },
      sections = {
        lualine_a = {
          {'mode', separator = '|'},
          {'selectioncount'},
        },
        lualine_b = {
          {'branch', separator = '|', icons_enabled = true},
          {'diff'},
        },
        lualine_c = {
          {'filename', separator = '»'},
          {get_location, cond = is_available},
        },
        lualine_x = {
          {'diagnostics', icons_enabled = true},
          {file_or_ls, padding = {right = 0}},
          {'encoding', padding = {right = 0}},
          {'fileformat'},
        },
        lualine_y = {
          {'searchcount', padding = {left = 1, right = 0}},
          {'progress'},
        },
        lualine_z = {
          {'location'},
        },
      },
    }
  end
}
