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
-- LINE SWAPPING (Custom functions loaded from utils)
-- ============================================================================

-- These will be set up after loading the swap-lines utility
-- Ctrl-j/k for swapping lines (custom function)
-- Ctrl-Up/Down for bubbling lines (vim-unimpaired)

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
-- LSP KEYMAPS (will be set in LSP config)
-- ============================================================================

-- These are set up in plugins/lsp.lua when LSP attaches
