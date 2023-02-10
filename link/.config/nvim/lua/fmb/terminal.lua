-- Toggle floating terminal or create new one if there is none.
--
-- Author: kutsan, https://github.com/kutsan/
-- https://github.com/kutsan/dotfiles/blob/b2046a6c0bcc754fc381351119c14c374721fd4d/.config/nvim/lua/kutsan/mappings/normal/terminal.lua

local api = vim.api
local fn = vim.fn

local terminal = {
  buf = nil,
  win = nil,
  pid = nil
}

terminal.open = function ()
  -- Create buffer.
  local buf = nil

  if terminal.buf and api.nvim_buf_is_loaded(terminal.buf) then
    buf = terminal.buf
  else
    buf = api.nvim_create_buf(false, true)
  end

  -- Create window.
  local width = math.ceil(vim.o.columns * 0.8)
  local height = math.ceil(vim.o.lines * 0.9)

  local win = api.nvim_open_win(buf, true, {
    relative = 'editor',
    style = 'minimal',
    width = width,
    height = height,
    col = math.ceil((vim.o.columns - width) / 2),
    row = math.ceil((vim.o.lines - height) / 2 - 1),
  })
  api.nvim_win_set_option(win, 'winhighlight', 'Normal:CursorLine')

  -- Launch terminal.
  if not terminal.buf then
    terminal.pid = fn.termopen(string.format('%s --login', os.getenv('SHELL')))
  end

  vim.cmd('startinsert')
  api.nvim_clear_autocmds({
    event = 'TermClose',
    pattern = '<buffer>'
  })
  api.nvim_create_autocmd('TermClose', {
    pattern = '<buffer>',
    callback = function ()
      require('fmb.terminal').close(true)
    end
  })

  -- Save current handles.
  terminal.win = win
  terminal.buf = buf
end

terminal.close = function (force)
  if not terminal.win then
    return
  end

  if api.nvim_win_is_valid(terminal.win) then
    -- api.nvim_win_close(terminal.win, false)
    api.nvim_win_close(terminal.win, true)
    terminal.win = nil
  end

  -- Force close upon terminal exit.
  if force then
    if api.nvim_buf_is_loaded(terminal.buf) then
      api.nvim_buf_delete(terminal.buf, { force = true })
    end

    fn.jobstop(terminal.pid)

    terminal.buf = nil
    terminal.pid = nil
  end
end

terminal.toggle = function ()
  if terminal.win then
    terminal.close()
  else
    terminal.open()
  end
end

return terminal
