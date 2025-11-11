--[[
  Line Swapping Functions
  Migrated from original vimrc custom functions
]]

local M = {}

-- Swap two lines
local function swap_lines(n1, n2)
  local line1 = vim.fn.getline(n1)
  local line2 = vim.fn.getline(n2)
  vim.fn.setline(n1, line2)
  vim.fn.setline(n2, line1)
end

-- Swap current line with line above
function M.swap_up()
  local n = vim.fn.line('.')
  if n == 1 then
    return
  end
  swap_lines(n, n - 1)
  vim.cmd('normal! ' .. (n - 1) .. 'G')
end

-- Swap current line with line below
function M.swap_down()
  local n = vim.fn.line('.')
  if n == vim.fn.line('$') then
    return
  end
  swap_lines(n, n + 1)
  vim.cmd('normal! ' .. (n + 1) .. 'G')
end

-- Set up keymaps
function M.setup()
  vim.keymap.set('n', '<C-j>', M.swap_up, { silent = true, desc = 'Swap line up' })
  vim.keymap.set('n', '<C-k>', M.swap_down, { silent = true, desc = 'Swap line down' })
end

return M
