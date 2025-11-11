--[[
  OS-Aware Clipboard Integration
  Migrated from original vimrc clipboard functions
]]

local M = {}

-- Detect OS
local function get_os()
  if vim.fn.has('mac') == 1 or vim.fn.has('macunix') == 1 then
    return 'macos'
  elseif vim.fn.has('unix') == 1 then
    return 'linux'
  elseif vim.fn.has('win32') == 1 or vim.fn.has('win64') == 1 then
    return 'windows'
  end
  return 'unknown'
end

-- Copy to system clipboard
function M.copy_to_clipboard()
  local os = get_os()
  local reg_content = vim.fn.getreg('"')

  if os == 'macos' then
    vim.fn.system('pbcopy', reg_content)
  elseif os == 'linux' then
    -- Try xclip first, then xsel
    if vim.fn.executable('xclip') == 1 then
      vim.fn.system('xclip -i -selection clipboard', reg_content)
      vim.fn.system('xclip -i', reg_content)
    elseif vim.fn.executable('xsel') == 1 then
      vim.fn.system('xsel --clipboard --input', reg_content)
    else
      vim.notify('xclip or xsel not found', vim.log.levels.WARN)
    end
  elseif os == 'windows' then
    vim.fn.system('clip', reg_content)
  end
end

-- Paste from system clipboard
function M.paste_from_clipboard()
  local os = get_os()
  local content

  if os == 'macos' then
    content = vim.fn.system('pbpaste')
  elseif os == 'linux' then
    if vim.fn.executable('xclip') == 1 then
      content = vim.fn.system('xclip -o -selection clipboard')
    elseif vim.fn.executable('xsel') == 1 then
      content = vim.fn.system('xsel --clipboard --output')
    else
      vim.notify('xclip or xsel not found', vim.log.levels.WARN)
      return
    end
  elseif os == 'windows' then
    content = vim.fn.system('powershell -command "Get-Clipboard"')
  end

  if content then
    vim.fn.setreg('"', content)
    vim.cmd('normal! p')
  end
end

-- Set up keymaps
function M.setup()
  -- Copy to clipboard (visual mode)
  vim.keymap.set('v', '<leader>c', function()
    vim.cmd('normal! y')
    M.copy_to_clipboard()
  end, { desc = 'Copy to system clipboard' })

  -- Paste from clipboard (normal mode)
  vim.keymap.set('n', '<leader>v', function()
    M.paste_from_clipboard()
  end, { desc = 'Paste from system clipboard' })
end

return M
