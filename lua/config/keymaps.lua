--[[
  Key Mappings
  Migrated from original vimrc with 1:1 parity
]]

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Leader key is set in init.lua as ','
-- Remap backslash to comma (so comma can be leader)
keymap('n', ',', '\\', opts)

-- ============================================================================
-- FAST ACTIONS
-- ============================================================================

-- Fast saving (save only if modified)
keymap('n', '<leader>w', ':update<CR>', { desc = 'Save file (if modified)' })

-- Fast escaping
keymap('i', 'jj', '<ESC>', { desc = 'Exit insert mode' })

-- Prevent accidental F1 key
keymap('n', '<F1>', '<ESC>', opts)
keymap('i', '<F1>', '<ESC>', opts)

-- Clear search highlight
keymap('n', '<leader><space>', ':nohlsearch<CR>', { desc = 'Clear search highlight' })

-- ============================================================================
-- NAVIGATION
-- ============================================================================

-- Move by display lines (not file lines)
keymap('n', 'j', 'gj', opts)
keymap('n', 'k', 'gk', opts)

-- Swap ' and ` for better jump behavior
keymap('n', "'", '`', opts)
keymap('n', '`', "'", opts)

-- Fast window switching
keymap('n', '<leader>,', '<C-W>w', { desc = 'Switch windows' })

-- Cycle between buffers
keymap('n', '<leader>.', ':b#<CR>', { desc = 'Cycle buffers' })

-- Change directory to current file
keymap('n', '<leader>cd', ':cd %:p:h<CR>', { desc = 'CD to current file' })

-- ============================================================================
-- EDITING
-- ============================================================================

-- Map Y to match C and D behavior (yank to end of line)
keymap('n', 'Y', 'y$', { desc = 'Yank to end of line' })

-- Yank entire file (global yank)
keymap('n', 'gy', 'ggVGy', { desc = 'Yank entire file' })

-- Indent visual selected code without unselecting
keymap('v', '>', '>gv', { desc = 'Indent right' })
keymap('v', '<', '<gv', { desc = 'Indent left' })

-- Pull word under cursor into search and replace
keymap('n', '<leader>r', ':%s#\\<<C-r>=expand("<cword>")<CR>\\>#', { desc = 'Search & replace word' })

-- Insert path of current file into command
keymap('c', '<C-P>', '<C-R>=expand("%:p:h") . "/" <CR>', { noremap = true })

-- Auto-complete brackets with newlines
keymap('i', '{<CR>', '{<CR>}<Esc>O', opts)
keymap('i', '(<CR>', '(<CR>)<Esc>O', opts)
keymap('i', '[<CR>', '[<CR>]<Esc>O', opts)

-- ============================================================================
-- CONFIG MANAGEMENT
-- ============================================================================

-- Fast editing of config
keymap('n', '<leader>ev', ':e $MYVIMRC<CR>', { desc = 'Edit init.lua' })
keymap('n', '<leader>sv', ':source $MYVIMRC<CR>', { desc = 'Source init.lua' })

-- ============================================================================
-- SYSTEM INTEGRATION
-- ============================================================================

-- OS-aware clipboard (pbcopy/pbpaste on macOS, xclip on Linux)
if vim.fn.has('unix') == 1 then
  local uname = vim.fn.system('uname'):gsub('%s+', '')
  if uname == 'Darwin' then
    -- macOS: pbcopy/pbpaste
    keymap('v', '<leader>c', [[y:call system("pbcopy", getreg('"'))<CR>]], { desc = 'Copy to clipboard (pbcopy)' })
    keymap('n', '<leader>v', ':r !pbpaste<CR>', { desc = 'Paste from clipboard (pbpaste)' })
  else
    -- Linux: xclip
    keymap('v', '<leader>c', [[y:call system("xclip -i -selection clipboard", getreg('"'))<CR>]], { desc = 'Copy to clipboard (xclip)' })
    keymap('n', '<leader>v', ':r !xclip -o -selection clipboard<CR>', { desc = 'Paste from clipboard (xclip)' })
  end
end

-- Allow saving when you forgot sudo
keymap('c', 'w!!', 'w !sudo tee % >/dev/null', { noremap = true, desc = 'Save with sudo' })

-- ============================================================================
-- SPELL CHECKING
-- ============================================================================

-- Toggle spell checking
keymap('n', '<leader>spl', ':setlocal spell!<CR>', { desc = 'Toggle spell check' })

-- Spell checking navigation
keymap('n', '<leader>sn', ']s', { desc = 'Next misspelling' })
keymap('n', '<leader>sp', '[s', { desc = 'Previous misspelling' })
keymap('n', '<leader>sa', 'zg', { desc = 'Add to dictionary' })
keymap('n', '<leader>s?', 'z=', { desc = 'Suggest corrections' })

-- ============================================================================
-- LINE SWAPPING
-- ============================================================================

-- Load swap-lines utility
local swap_lines = require('utils.swap-lines')

-- Ctrl-j/k for swapping lines up/down (normal mode)
keymap('n', '<C-j>', swap_lines.swap_up, { silent = true, desc = 'Move line up' })
keymap('n', '<C-k>', swap_lines.swap_down, { silent = true, desc = 'Move line down' })

-- Ctrl-Up/Down for moving lines (normal mode)
keymap('n', '<C-Up>', ':move .-2<CR>==', { silent = true, desc = 'Move line up' })
keymap('n', '<C-Down>', ':move .+1<CR>==', { silent = true, desc = 'Move line down' })

-- Ctrl-Up/Down for moving visual selection (visual mode)
keymap('v', '<C-Up>', ":move '<-2<CR>gv=gv", { silent = true, desc = 'Move selection up' })
keymap('v', '<C-Down>', ":move '>+1<CR>gv=gv", { silent = true, desc = 'Move selection down' })

-- ============================================================================
-- PLUGIN-SPECIFIC KEYMAPS
-- ============================================================================

-- File tree toggle (neo-tree)
keymap('n', '<leader>n', ':Neotree toggle<CR>', { desc = 'Toggle file tree' })

-- Telescope fuzzy finder (added in modern config)
keymap('n', '<leader>ff', ':Telescope find_files<CR>', { desc = 'Find files' })
keymap('n', '<leader>fg', ':Telescope live_grep<CR>', { desc = 'Live grep' })
keymap('n', '<leader>fb', ':Telescope buffers<CR>', { desc = 'Find buffers' })
keymap('n', '<leader>fh', ':Telescope help_tags<CR>', { desc = 'Help tags' })

-- Flash.nvim motion (replaces easymotion)
-- Configured in plugin file

-- Markdown preview (gm)
-- Configured in plugins/misc.lua (lazy-loaded)

-- ============================================================================
-- FORMATTING
-- ============================================================================

-- Autoformat command (conform.nvim)
keymap('n', '<leader>f', function()
  require('conform').format({ async = true, lsp_format = 'fallback' })
end, { desc = 'Format buffer' })

-- gA for autoformat (quick access)
keymap('n', 'gA', function()
  require('conform').format({ async = true, lsp_format = 'fallback' })
end, { desc = 'Autoformat buffer' })

-- Create :Autoformat command for compatibility
vim.api.nvim_create_user_command('Autoformat', function()
  require('conform').format({ async = true, lsp_format = 'fallback' })
end, { desc = 'Format buffer with conform.nvim' })

-- ============================================================================
-- DIAGNOSTICS
-- ============================================================================

-- Open diagnostic list (Trouble.nvim)
keymap('n', '<leader>e', ':Trouble diagnostics toggle filter.buf=0<CR>', { desc = 'Open diagnostic list' })

-- Navigate diagnostics
keymap('n', '[d', vim.diagnostic.goto_prev, { desc = 'Previous diagnostic' })
keymap('n', ']d', vim.diagnostic.goto_next, { desc = 'Next diagnostic' })

-- Classic Vim location list commands (for backward compatibility)
-- These work with native Neovim location list
keymap('n', '<leader>lo', ':lopen<CR>', { desc = 'Open location list' })
keymap('n', '<leader>lc', ':lclose<CR>', { desc = 'Close location list' })
keymap('n', '<leader>ll', ':DiagnosticsToLocList<CR>', { desc = 'Populate location list with diagnostics' })

-- Map :lnext and :lprev to diagnostic navigation (more reliable than location list)
keymap('n', '<leader>ln', vim.diagnostic.goto_next, { desc = 'Next diagnostic' })
keymap('n', '<leader>lp', vim.diagnostic.goto_prev, { desc = 'Previous diagnostic' })

-- Create command aliases for classic Vim muscle memory
vim.api.nvim_create_user_command('Lnext', function()
  vim.diagnostic.goto_next()
end, { desc = 'Jump to next diagnostic' })

vim.api.nvim_create_user_command('Lprev', function()
  vim.diagnostic.goto_prev()
end, { desc = 'Jump to previous diagnostic' })

-- ============================================================================
-- LSP KEYMAPS (will be set in LSP config)
-- ============================================================================

-- These are set up in plugins/lsp.lua when LSP attaches
