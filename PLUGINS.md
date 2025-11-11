# Plugin Reference

This document provides a comprehensive overview of all plugins used in this Neovim configuration, their purpose, and how they map to the original Vim setup.

## Plugin Manager

### lazy.nvim

**Repository**: https://github.com/folke/lazy.nvim

**Purpose**: Modern plugin manager for Neovim with lazy-loading capabilities.

**Replaces**: Pathogen

**Features**:
- Lazy loading by default (faster startup)
- Lockfile support for reproducible installations
- Beautiful UI for managing plugins
- Automatic caching and bytecode compilation
- Profile tools for debugging

**Commands**:
- `:Lazy` - Open the Lazy UI
- `:Lazy sync` - Update all plugins
- `:Lazy clean` - Remove unused plugins
- `:Lazy profile` - Profile plugin load times

## File Management & Navigation

### neo-tree.nvim

**Repository**: https://github.com/nvim-neo-tree/neo-tree.nvim

**Purpose**: File explorer with modern UI and features.

**Replaces**: NERDTree + nerdtree-execute

**Key Mappings**:
- `<leader>n` - Toggle file tree
- `<space>` - Toggle node (in tree)
- `<CR>` - Open file
- `a` - Add file
- `d` - Delete file
- `r` - Rename file
- `?` - Show help

**Features**:
- Git status integration
- Diagnostics integration
- Multiple views (filesystem, buffers, git)
- Floating window support

### telescope.nvim

**Repository**: https://github.com/nvim-telescope/telescope.nvim

**Purpose**: Fuzzy finder for files, text, and more.

**Replaces**: (New addition, not in original)

**Key Mappings**:
- `<leader>ff` - Find files
- `<leader>fg` - Live grep
- `<leader>fb` - Find buffers
- `<leader>fh` - Help tags
- `<leader>fr` - Recent files
- `<leader>fc` - Commands
- `<leader>fk` - Keymaps

**Features**:
- Fast fuzzy finding with fzf-native
- Live grep with ripgrep
- Preview window
- Multiple pickers (files, buffers, commands, etc.)

### vim-fetch

**Repository**: https://github.com/wsdjeg/vim-fetch

**Purpose**: Open files with line numbers (e.g., `file.txt:42`).

**Replaces**: (Kept from original)

**Usage**: `nvim file.txt:42` will open file at line 42

## Editing & Text Manipulation

### nvim-surround

**Repository**: https://github.com/kylechui/nvim-surround

**Purpose**: Surround text with quotes, brackets, tags, etc.

**Replaces**: vim-surround

**Usage**:
- `ys{motion}{char}` - Add surrounding
- `ds{char}` - Delete surrounding
- `cs{old}{new}` - Change surrounding
- Example: `ysiw"` - Surround word with quotes

### Comment.nvim

**Repository**: https://github.com/numToStr/Comment.nvim

**Purpose**: Toggle comments.

**Replaces**: tcomment_vim

**Key Mappings**:
- `gcc` - Toggle line comment
- `gbc` - Toggle block comment
- `gc` - Toggle comment (visual mode)
- `gcO` - Add comment above
- `gco` - Add comment below
- `gcA` - Add comment at end of line

### nvim-autopairs

**Repository**: https://github.com/windwp/nvim-autopairs

**Purpose**: Auto-close brackets, quotes, etc.

**Replaces**: (New addition)

**Features**:
- Auto-close pairs
- Fast wrap with `Alt-e`
- Treesitter integration

### vim-repeat

**Repository**: https://github.com/tpope/vim-repeat

**Purpose**: Repeat plugin commands with `.`

**Replaces**: (Kept from original)

### vim-unimpaired

**Repository**: https://github.com/tpope/vim-unimpaired

**Purpose**: Bracket mappings for common operations.

**Replaces**: (Kept from original)

**Key Mappings**:
- `[b` / `]b` - Previous/next buffer
- `[q` / `]q` - Previous/next quickfix
- `[e` / `]e` - Bubble line up/down (used for Ctrl-Up/Down)
- `[<space>` / `]<space>` - Add blank line above/below

### vim-pasta

**Repository**: https://github.com/sickill/vim-pasta

**Purpose**: Context-aware pasting.

**Replaces**: (Kept from original)

**Features**: Automatically adjusts indentation when pasting

### vim-ragtag

**Repository**: https://github.com/tpope/vim-ragtag

**Purpose**: HTML/XML tag helpers.

**Replaces**: (Kept from original)

**Usage**: Provides shortcuts for HTML/XML editing

### tabular

**Repository**: https://github.com/godlygeek/tabular

**Purpose**: Text alignment.

**Replaces**: (Kept from original)

**Usage**: `:Tabularize /<pattern>` to align text

## Motion & Navigation

### flash.nvim

**Repository**: https://github.com/folke/flash.nvim

**Purpose**: Fast motion with minimal keystrokes.

**Replaces**: vim-easymotion

**Key Mappings**:
- `s` - Jump to any character (2-char search)
- `S` - Treesitter jump
- `<leader>j` - Jump to line down
- `<leader>k` - Jump to line up

**Features**:
- Faster than easymotion
- Treesitter integration
- Multi-window support
- Smart case sensitivity

## Syntax & Linting

### nvim-treesitter

**Repository**: https://github.com/nvim-treesitter/nvim-treesitter

**Purpose**: Better syntax highlighting and code understanding.

**Replaces**: vim-javascript, vim-jade, vim-less, vim-markdown

**Features**:
- Incremental parsing
- Syntax highlighting
- Code folding
- Indentation
- Text objects
- Incremental selection

**Supported Languages**: JavaScript, TypeScript, Python, Lua, HTML, CSS, JSON, YAML, Markdown, and many more.

### nvim-lint

**Repository**: https://github.com/mfussenegger/nvim-lint

**Purpose**: Async linting.

**Replaces**: Syntastic

**Configured Linters**:
- JavaScript/TypeScript: xo
- Python: pylint
- Markdown: markdownlint
- YAML: yamllint
- Pug: puglint
- Shell: shellcheck

**Features**:
- Asynchronous (doesn't block editing)
- Automatic linting on save and other events
- Configurable per filetype
- Helpful tips when linters aren't installed (shows once per session)

**Installation Tips**:
- Use `:Mason` to install linters interactively
- Or install via npm (e.g., `npm install -g markdownlint-cli`)
- Missing linters will trigger a helpful notification

## Formatting

### conform.nvim

**Repository**: https://github.com/stevearc/conform.nvim

**Purpose**: Smart auto-formatting with config detection.

**Replaces**: vim-autoformat, vim-better-whitespace, vim-xo

**Key Mappings**:
- `<leader>f` - Format buffer
- `:Autoformat` - Format buffer (command)

**Configured Formatters**:
- JavaScript/TypeScript: xo → prettier → standard (priority order)
- Markdown: remark → prettier (priority order)
- Lua: stylua
- Python: ruff_format, black
- HTML/CSS/JSON/YAML: prettier
- Shell: shfmt
- All files: trim_whitespace

**Smart Config Detection**:
- Searches from current file up to project root
- Only runs formatter if config file is found
- Supports multiple formatters with priority order

**Example (JavaScript)**:
- If `.xo-config` or `"xo"` in `package.json` → uses XO
- Else if `.prettierrc` or `"prettier"` in `package.json` → uses Prettier
- Else if `.standardrc` or `"standard"` in `package.json` → uses Standard

**Example (Markdown)**:
- If `.remarkrc` or `"remark"` in `package.json` → uses remark
- Else if `.prettierrc` or `"prettier"` in `package.json` → uses Prettier
- Else → falls back to LSP formatter

## LSP & Completion

### nvim-lspconfig

**Repository**: https://github.com/neovim/nvim-lspconfig

**Purpose**: LSP client configuration.

**Replaces**: (New addition)

**Configured Servers**:
- Lua: lua_ls
- JavaScript/TypeScript: tsserver, eslint
- Python: pyright
- Shell: bashls
- JSON: jsonls
- YAML: yamlls
- HTML: html
- CSS: cssls

**Key Mappings** (when LSP is active):
- `K` - Hover documentation
- `gd` - Go to definition
- `gD` - Go to declaration
- `gi` - Go to implementation
- `gr` - Go to references
- `<leader>rn` - Rename
- `<leader>ca` - Code action
- `<leader>D` - Type definition

### mason.nvim

**Repository**: https://github.com/williamboman/mason.nvim

**Purpose**: LSP/formatter/linter installer.

**Replaces**: (New addition)

**Commands**:
- `:Mason` - Open Mason UI
- `:MasonInstall <tool>` - Install a tool
- `:MasonUninstall <tool>` - Uninstall a tool
- `:MasonUpdate` - Update all tools

**Auto-installed Tools**:
- Language servers: lua_ls, tsserver, eslint, pyright, bashls, jsonls, yamlls, html, cssls
- Formatters: stylua, prettier, xo, shfmt
- Linters: shellcheck, eslint_d

### nvim-cmp

**Repository**: https://github.com/hrsh7th/nvim-cmp

**Purpose**: Completion engine.

**Replaces**: supertab

**Key Mappings**:
- `<C-n>` / `<C-p>` - Next/previous completion
- `<Tab>` / `<S-Tab>` - Next/previous completion (also for snippets)
- `<CR>` - Confirm completion
- `<C-Space>` - Trigger completion
- `<C-e>` - Abort completion

**Sources**:
- LSP
- Buffer
- Path
- Snippets (LuaSnip)

## Visual & UI

### lualine.nvim

**Repository**: https://github.com/nvim-lualine/lualine.nvim

**Purpose**: Status line.

**Replaces**: vim-powerline

**Features**:
- Shows mode, branch, diff, diagnostics
- File path and status
- Encoding, format, filetype
- Position and progress
- Integrates with plugins (neo-tree, lazy, mason)

### tokyonight.nvim

**Repository**: https://github.com/folke/tokyonight.nvim

**Purpose**: Color scheme.

**Replaces**: vim-irblack

**Variant**: tokyonight-night (dark theme similar to ir_black)

**Alternatives**: Can be easily changed to catppuccin, gruvbox, or any other modern theme.

### indent-blankline.nvim

**Repository**: https://github.com/lukas-reineke/indent-blankline.nvim

**Purpose**: Indentation guides.

**Replaces**: (New addition)

**Features**: Shows vertical lines for indentation levels

### which-key.nvim

**Repository**: https://github.com/folke/which-key.nvim

**Purpose**: Key binding helper.

**Replaces**: (New addition)

**Features**:
- Shows available key bindings after pressing leader
- Helps discover commands
- Displays descriptions

## Git Integration

### gitsigns.nvim

**Repository**: https://github.com/lewis6991/gitsigns.nvim

**Purpose**: Git signs in the gutter.

**Replaces**: vim-git

**Features**:
- Shows added/changed/deleted lines
- Inline blame
- Stage/unstage hunks
- Preview changes

## Utilities

### editorconfig-vim

**Repository**: https://github.com/editorconfig/editorconfig-vim

**Purpose**: EditorConfig support.

**Replaces**: (Kept from original)

**Features**: Automatically applies editor settings from `.editorconfig` files

### markdown-preview.nvim

**Repository**: https://github.com/iamcco/markdown-preview.nvim

**Purpose**: Live markdown preview.

**Replaces**: vim-livedown

**Key Mappings**:
- `gm` - Toggle markdown preview

**Features**:
- Live preview in browser
- Synchronized scrolling
- Port 8337 (same as original livedown config)

## Custom Utilities

### clipboard.lua

**Purpose**: OS-aware clipboard integration.

**Replaces**: Custom vimrc functions

**Key Mappings**:
- `<leader>c` - Copy to system clipboard (visual mode)
- `<leader>v` - Paste from system clipboard

**Features**:
- Detects OS (macOS, Linux, Windows)
- Uses appropriate clipboard tool (pbcopy/xclip/clip)

### swap-lines.lua

**Purpose**: Swap lines up/down.

**Replaces**: Custom vimrc functions

**Key Mappings**:
- `Ctrl-j` - Swap line up
- `Ctrl-k` - Swap line down

**Features**:
- Boundary checks (doesn't swap at top/bottom)
- Moves cursor with line

## Removed Plugins

The following plugins from the original config were removed as they are either obsolete, rarely used, or replaced by built-in Neovim features:

- **vim-speeddating**: Date manipulation (rarely used)
- **utl.vim**: Universal Text Linking (rarely used)
- **vim-orgmode**: Org-mode support (can be added back if needed via `orgmode.nvim`)

## Plugin Loading Strategy

All plugins are lazy-loaded for optimal performance:

- **Immediate**: Only colorscheme and essential UI plugins
- **On Event**: Most plugins load on `BufReadPost`, `BufNewFile`, or `VeryLazy`
- **On Command**: Some plugins only load when their command is used
- **On Filetype**: Language-specific plugins load only for relevant files
- **On Key**: Some plugins load when their keybinding is pressed

This results in startup times of typically under 50ms.

## Updating Plugins

To update all plugins:

```vim
:Lazy sync
```

To update a specific plugin:

```vim
:Lazy update <plugin-name>
```

To view plugin status:

```vim
:Lazy
```

## Adding New Plugins

To add a new plugin, create a file in `lua/plugins/`:

```lua
-- lua/plugins/my-plugin.lua
return {
  'author/plugin-name',
  event = 'VeryLazy',  -- or cmd, ft, keys, etc.
  opts = {
    -- plugin options
  },
  config = function(_, opts)
    require('plugin-name').setup(opts)
  end,
}
```

Restart Neovim, and the plugin will be automatically installed by lazy.nvim.

## Disabling Plugins

To disable a plugin, add `enabled = false`:

```lua
return {
  'author/plugin-name',
  enabled = false,
}
```

Or simply delete the plugin file from `lua/plugins/`.
