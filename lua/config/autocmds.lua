--[[
  Auto Commands
  Migrated from original vimrc
]]

local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- ============================================================================
-- AUTO SAVE
-- ============================================================================

-- Auto-save on focus lost, buffer leave, window leave, tab leave
local autosave_group = augroup('AutoSave', { clear = true })
autocmd({ 'FocusLost', 'BufLeave', 'WinLeave', 'TabLeave' }, {
  group = autosave_group,
  pattern = '*',
  command = 'silent! update',
  desc = 'Auto-save when leaving buffer or losing focus',
})

-- ============================================================================
-- CURSOR POSITION
-- ============================================================================

-- Restore cursor position when opening file
local cursor_group = augroup('RestoreCursor', { clear = true })
autocmd('BufReadPost', {
  group = cursor_group,
  pattern = '*',
  callback = function()
    local line = vim.fn.line("'\"")
    if line > 0 and line <= vim.fn.line('$') then
      vim.cmd('normal! g`"')
    end
  end,
  desc = 'Restore cursor position',
})

-- ============================================================================
-- QUICKFIX
-- ============================================================================

-- Open quickfix window after grep
local quickfix_group = augroup('QuickFix', { clear = true })
autocmd('QuickFixCmdPost', {
  group = quickfix_group,
  pattern = '*grep*',
  command = 'cwindow',
  desc = 'Open quickfix after grep',
})

-- ============================================================================
-- FILETYPE SPECIFIC
-- ============================================================================

-- Python: Use tabs instead of spaces
local python_group = augroup('Python', { clear = true })
autocmd('FileType', {
  group = python_group,
  pattern = 'python',
  callback = function()
    vim.opt_local.expandtab = false
  end,
  desc = 'Use tabs for Python',
})

-- Markdown: Force .md files as markdown (not Modula-2)
local markdown_group = augroup('Markdown', { clear = true })
autocmd({ 'BufNewFile', 'BufRead' }, {
  group = markdown_group,
  pattern = '*.md',
  command = 'set filetype=markdown',
  desc = 'Force .md as markdown',
})

-- ============================================================================
-- HIGHLIGHT ON YANK
-- ============================================================================

-- Highlight yanked text (modern Neovim feature)
local highlight_group = augroup('YankHighlight', { clear = true })
autocmd('TextYankPost', {
  group = highlight_group,
  pattern = '*',
  callback = function()
    vim.highlight.on_yank({ higroup = 'IncSearch', timeout = 200 })
  end,
  desc = 'Highlight yanked text',
})

-- ============================================================================
-- GUI SPECIFIC
-- ============================================================================

-- GUI-specific settings
if vim.fn.has('gui_running') == 1 then
  local gui_group = augroup('GUI', { clear = true })
  autocmd('GUIEnter', {
    group = gui_group,
    pattern = '*',
    callback = function()
      vim.opt.visualbell = false
      vim.opt.guioptions:remove('T') -- Remove toolbar
      vim.opt.guioptions:remove('m') -- Remove menubar
      vim.opt.linespace = 2
      vim.opt.columns = 160
      vim.opt.lines = 35
      vim.opt.cursorline = true
      vim.opt.colorcolumn = '115'
      -- Remove scrollbars
      vim.opt.guioptions:append('LlRrb')
      vim.opt.guioptions:remove('LlRrb')
    end,
    desc = 'GUI-specific settings',
  })
end

-- ============================================================================
-- LSP FORMATTING
-- ============================================================================

-- Format on save (handled by conform.nvim in plugin config)
-- This is configured in plugins/conform.lua

-- ============================================================================
-- TERMINAL MODE
-- ============================================================================

-- Easy escape from terminal mode
autocmd('TermOpen', {
  pattern = '*',
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.signcolumn = 'no'
  end,
  desc = 'Terminal mode settings',
})
