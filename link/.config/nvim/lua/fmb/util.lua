local M = {}

function M.is_floating(win)
  local cfg = vim.api.nvim_win_get_config(win)
  if cfg.relative > '' or cfg.external then return true end
  return false
end

function M.get_hl_value(group, attr)
  return vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID(group)), attr .. '#')
end

function M.bind(mode, lhs, rhs, opts)
  opts = opts or {}
  vim.keymap.set(mode, lhs, rhs, opts)
end

function M.hl(name, val)
  vim.api.nvim_set_hl(0, name, val)
end

function M.mkcmd(cmd, act, opts)
  opts = opts or {}
  vim.api.nvim_create_user_command(cmd, act, opts)
end

function M.aucmd(events, opts)
  vim.api.nvim_create_autocmd(events, opts)
end

function M.augrp(name, opts)
  opts = opts or {}
  vim.api.nvim_create_augroup('fmb_' .. name, opts)
end

function M.tele_bdrchars(l)
  -- Not sure why telescope devs chose to define their own order
  -- for these. Maybe this was made before nvim_open_win()...?
  return {l[2], l[4], l[6], l[8], l[1], l[3], l[5], l[7]}
end

-- TODO: remove this trash, new telescope create_layout it the way
function M.tele_dropdown(l)
  -- You see this? You see how ugly it is? I see it, and I very much dislike it.
  -- But it works, and I've lost the ability to care somewhere along the way.
  local t = M.tele_bdrchars(l)
  return {
    results_title = false,
    sorting_strategy = 'ascending',
    layout_strategy = 'center',
    preview = false,
    layout_config = {
      width = function(_, max_columns, _)
        return math.min(max_columns, 80)
      end,
      height = function(_, _, max_lines)
        return math.min(max_lines, 15)
      end,
    },
    border = true,
    borderchars = {
      prompt = { t[1], t[2], ' ', t[4], t[5], t[6], t[7], t[8] },
      results = { t[1], t[2], t[3], t[4], "├", "┤", t[7], t[8] },
      preview = t,
    },
  }
end

return M