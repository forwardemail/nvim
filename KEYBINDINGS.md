# Keybindings Reference

Complete reference of all keybindings in this Neovim configuration.

## Leader Key

- **Leader**: `,` (comma)
- **Local Leader**: `,` (comma)

## Quick Actions

| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `<leader>w` | Normal | `:update` | Save file (only if modified) |
| `jj` | Insert | `<ESC>` | Exit insert mode |
| `<leader>q` | Normal | `:q` | Quit |
| `<leader>Q` | Normal | `:qa!` | Quit all without saving |

## File Management

| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `<leader>n` | Normal | `:Neotree toggle` | Toggle file tree |
| `<leader>e` | Normal | `:Neotree focus` | Focus file tree |

## Navigation

| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `<C-h>` | Normal | `<C-w>h` | Move to left window |
| `<C-j>` | Normal | `<C-w>j` | Move to window below |
| `<C-k>` | Normal | `<C-w>k` | Move to window above |
| `<C-l>` | Normal | `<C-w>l` | Move to right window |
| `<leader>bd` | Normal | `:bdelete` | Delete buffer |
| `<leader>bn` | Normal | `:bnext` | Next buffer |
| `<leader>bp` | Normal | `:bprevious` | Previous buffer |

## Line Manipulation

| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `<C-j>` | Normal/Visual | Swap line down | Move current/selected lines down |
| `<C-k>` | Normal/Visual | Swap line up | Move current/selected lines up |
| `J` | Visual | `:m '>+1<CR>gv=gv` | Move selection down |
| `K` | Visual | `:m '<-2<CR>gv=gv` | Move selection up |

## Clipboard Operations

| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `<leader>c` (`,c`) | Visual | Copy to system clipboard | Uses pbcopy (macOS) or xclip (Linux) |
| `<leader>v` (`,v`) | Normal | Paste from system clipboard | Uses pbpaste (macOS) or xclip (Linux) |

**Note:** On Linux, install xclip first: `sudo apt install xclip`

## Search & Replace

| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `<leader>/` | Normal | `:nohl` | Clear search highlighting |
| `<leader>s` | Normal | `:%s/\\<<C-r><C-w>\\>//g<Left><Left>` | Search and replace word under cursor |

## Telescope (Fuzzy Finder)

| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `<leader>ff` | Normal | Find files | Fuzzy find files in project |
| `<leader>fg` | Normal | Live grep | Search text in project |
| `<leader>fb` | Normal | Find buffers | List and switch buffers |
| `<leader>fh` | Normal | Help tags | Search help documentation |

## Flash.nvim (Motion)

| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `s` | Normal/Visual/Operator | Flash | Jump to any location |
| `S` | Normal/Visual/Operator | Flash Treesitter | Jump to treesitter nodes |
| `r` | Operator | Remote Flash | Remote operation |
| `R` | Normal/Visual | Treesitter Search | Search with treesitter |
| `<c-s>` | Command | Toggle Flash Search | Toggle in command mode |

## Formatting

| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `<leader>f` | Normal | Format buffer | Format with conform.nvim |
| `gA` | Normal | **Autoformat buffer** | **Quick autoformat (NEW)** |
| `:Autoformat` | Command | Format buffer | Command-line format |

### Smart Autoformatter

The autoformatter (`gA`, `<leader>f`, `:Autoformat`) intelligently detects project configs:

**JavaScript/TypeScript:**
1. Checks for **XO** config (`.xo-config` or `"xo"` in `package.json`)
2. Checks for **Prettier** config (`.prettierrc*` or `"prettier"` in `package.json`)
3. Checks for **Standard** config (`.standardrc` or `"standard"` in `package.json`)
4. Falls back to **LSP formatter**

**Other Languages:**
- Python: `black`, `isort`
- Lua: `stylua`
- Go: `gofmt`, `goimports`
- Rust: `rustfmt`
- JSON/YAML/Markdown: `prettier`

## Markdown Preview

| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `gm` | Normal | Toggle markdown preview | Open/close preview in browser (port 8337) |

## Commenting

| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `gcc` | Normal | Toggle line comment | Comment/uncomment current line |
| `gc` | Visual | Toggle comment | Comment/uncomment selection |
| `gbc` | Normal | Toggle block comment | Block comment current line |
| `gb` | Visual | Toggle block comment | Block comment selection |

## LSP (Language Server Protocol)

These keybindings are available when an LSP server is attached to the buffer:

| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `gd` | Normal | Go to definition | Jump to symbol definition |
| `gD` | Normal | Go to declaration | Jump to symbol declaration |
| `gr` | Normal | References | List all references |
| `gi` | Normal | Go to implementation | Jump to implementation |
| `K` | Normal | Hover documentation | Show documentation |
| `<C-k>` | Insert | Signature help | Show function signature |
| `<leader>rn` | Normal | Rename | Rename symbol |
| `<leader>ca` | Normal | Code action | Show code actions |
| `<leader>D` | Normal | Type definition | Go to type definition |
| `[d` | Normal | Previous diagnostic | Go to previous diagnostic |
| `]d` | Normal | Next diagnostic | Go to next diagnostic |
| `<leader>dl` | Normal | Diagnostic list | Show diagnostics in location list |

## Completion (nvim-cmp)

These keybindings work in insert mode when the completion menu is open:

| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `<C-b>` | Insert | Scroll docs up | Scroll completion docs backward |
| `<C-f>` | Insert | Scroll docs down | Scroll completion docs forward |
| `<C-Space>` | Insert | Complete | Trigger completion |
| `<C-e>` | Insert | Abort | Close completion menu |
| `<CR>` | Insert | Confirm | Confirm completion |
| `<Tab>` | Insert | Next item | Select next completion item |
| `<S-Tab>` | Insert | Previous item | Select previous completion item |

## Spell Checking

| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `<leader>spl` | Normal | Toggle spell check | Enable/disable spell checking |
| `z=` | Normal | Spelling suggestions | Show suggestions for word under cursor |
| `]s` | Normal | Next misspelled | Jump to next misspelled word |
| `[s` | Normal | Previous misspelled | Jump to previous misspelled word |

## Git (Gitsigns)

| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `]c` | Normal | Next hunk | Jump to next git change |
| `[c` | Normal | Previous hunk | Jump to previous git change |
| `<leader>hs` | Normal | Stage hunk | Stage current hunk |
| `<leader>hr` | Normal | Reset hunk | Reset current hunk |
| `<leader>hS` | Normal | Stage buffer | Stage entire buffer |
| `<leader>hu` | Normal | Undo stage hunk | Undo last stage |
| `<leader>hR` | Normal | Reset buffer | Reset entire buffer |
| `<leader>hp` | Normal | Preview hunk | Preview hunk changes |
| `<leader>hb` | Normal | Blame line | Show git blame for line |
| `<leader>tb` | Normal | Toggle blame | Toggle blame virtual text |
| `<leader>hd` | Normal | Diff this | Show diff |
| `<leader>hD` | Normal | Diff this ~ | Show diff against index |

## Neo-tree (File Explorer)

When Neo-tree is focused:

| Key | Action | Description |
|-----|--------|-------------|
| `<CR>` | Open | Open file/folder |
| `<Space>` | Toggle node | Expand/collapse folder |
| `a` | Add | Create new file/folder |
| `d` | Delete | Delete file/folder |
| `r` | Rename | Rename file/folder |
| `y` | Copy | Copy file/folder |
| `x` | Cut | Cut file/folder |
| `p` | Paste | Paste file/folder |
| `c` | Copy to clipboard | Copy path to clipboard |
| `q` | Close | Close Neo-tree |
| `R` | Refresh | Refresh tree |
| `?` | Help | Show help |

## Mason (LSP/Tool Installer)

| Command | Description |
|---------|-------------|
| `:Mason` | Open Mason UI to install LSP servers, formatters, linters |
| `:MasonUpdate` | Update Mason registry |
| `:MasonInstall <package>` | Install a package |
| `:MasonUninstall <package>` | Uninstall a package |

## Lazy (Plugin Manager)

| Command | Description |
|---------|-------------|
| `:Lazy` | Open Lazy UI |
| `:Lazy sync` | Install, update, and clean plugins |
| `:Lazy update` | Update plugins |
| `:Lazy clean` | Remove unused plugins |
| `:Lazy check` | Check for updates |

## Notes

- **Conflicting Bindings**: `<C-j>` and `<C-k>` are used for both window navigation and line swapping. In normal mode, they swap lines. Use `<C-w>j` and `<C-w>k` explicitly for window navigation if needed.
- **Leader Key**: The comma (`,`) is the leader key. The backslash (`\`) is remapped to comma for compatibility.
- **Lazy Loading**: Some keybindings (like `gm` for markdown preview) only work after the plugin is loaded (e.g., when opening a markdown file).
- **LSP Keybindings**: LSP keybindings only work when a language server is attached to the current buffer.

## Quick Reference Card

**Most Used:**
- `<leader>w` - Save
- `<leader>n` - Toggle file tree
- `<leader>ff` - Find files
- `<leader>fg` - Search in files
- `gA` - **Autoformat** (NEW)
- `gcc` - Comment line
- `jj` - Exit insert mode
- `<leader>c` / `<leader>v` - Copy/paste system clipboard

**Format & Clean:**
- `gA` - **Autoformat with smart config detection**
- `<leader>f` - Format buffer
- `:Autoformat` - Format command

**Navigate:**
- `<C-h/j/k/l>` - Window navigation
- `gd` - Go to definition (LSP)
- `gr` - Find references (LSP)
- `K` - Show documentation (LSP)
