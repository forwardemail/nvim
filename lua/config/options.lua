--[[
  Core Vim Options
  Migrated from original vimrc with modern Neovim equivalents
]]

local opt = vim.opt

-- General
opt.compatible = false -- Full Vim (Neovim is always nocompatible)
opt.encoding = 'utf-8' -- UTF-8 encoding
opt.mouse = 'a' -- Full mouse support
opt.autoread = true -- Auto read when file is changed externally
opt.autowrite = true -- Auto write before certain commands
opt.showcmd = true -- Show typed commands
opt.hidden = true -- Allow background buffers without writing

-- Wild menu (command-line completion)
opt.wildmenu = true
opt.wildmode = 'list:longest,list:full'
opt.wildignore:append({ '*.o', '.git', '.svn', 'node_modules' })

-- UI
opt.number = true -- Show line numbers
opt.relativenumber = false -- Absolute line numbers
opt.ruler = true -- Show cursor position
opt.scrolloff = 3 -- Show 3 lines of context around cursor
opt.showmatch = true -- Show matching brackets
opt.laststatus = 2 -- Always show status line
opt.signcolumn = 'yes' -- Always show sign column (for git signs, diagnostics)
opt.cursorline = false -- Don't highlight current line (except in GUI)
opt.colorcolumn = '' -- No column marker (except in GUI)

-- Colors
opt.termguicolors = true -- True color support
opt.background = 'dark'

-- Search
opt.hlsearch = true -- Highlight search results
opt.incsearch = true -- Incremental search
opt.ignorecase = true -- Ignore case when searching
opt.smartcase = true -- But case-sensitive if expression contains capital
opt.gdefault = true -- Assume global when searching/substituting
opt.magic = true -- Magic mode for regular expressions

-- Performance
opt.lazyredraw = true -- Don't redraw during macros
opt.ttyfast = true -- Fast terminal connection

-- Files
opt.fileformats = { 'unix', 'mac', 'dos' }
opt.backup = false -- No backup files
opt.writebackup = false -- No backup before overwriting
opt.swapfile = false -- No swap files

-- Indentation
opt.shiftwidth = 2 -- Tab width
opt.softtabstop = 2
opt.tabstop = 2
opt.smarttab = true
opt.expandtab = true -- Use spaces, not tabs
opt.autoindent = true -- Auto indent
opt.smartindent = true -- Smart indent

-- Wrapping
opt.wrap = true -- Wrap lines that exceed window width
opt.linebreak = true -- Break at word boundaries (don't break words)
opt.breakindent = true -- Preserve indentation in wrapped lines

-- Whitespace visualization
opt.list = true
opt.listchars:append({
  tab = '→ ',
  trail = '·',
  extends = '→',
  precedes = '←',
  nbsp = '␣',
})

-- Spell checking
opt.spelllang = { 'en', 'es' }
opt.spell = false -- Disabled by default, toggle with <leader>spl

-- Bells
opt.errorbells = false
opt.visualbell = false

-- Folding
opt.foldenable = true
opt.foldmethod = 'indent'
opt.foldlevel = 99

-- Backspace behavior
opt.backspace = { 'indent', 'eol', 'start' }

-- Security
opt.modeline = false -- Disable modelines for security
opt.secure = true -- Secure mode for project-specific vimrc

-- Completion
opt.completeopt = { 'menu', 'menuone', 'noselect' }

-- Split behavior
opt.splitright = true -- Vertical splits go right
opt.splitbelow = true -- Horizontal splits go below

-- Timeout
opt.timeoutlen = 500 -- Time to wait for mapped sequence
opt.updatetime = 250 -- Faster completion and CursorHold

-- Clipboard (OS-aware, handled in keymaps)
-- Don't set clipboard=unnamedplus to preserve original behavior
-- Original config uses custom mappings for clipboard

-- Neovim-specific improvements
opt.inccommand = 'split' -- Show substitution preview in split
