# Troubleshooting Guide

## No Syntax Highlighting

### Symptoms
- Files open without colors
- Everything appears in the same color
- No syntax highlighting for JS, JSON, CSS, etc.

### Cause
Treesitter parsers need to be compiled with a C compiler.

### Solution

**macOS:**
```sh
# Install Xcode Command Line Tools
xcode-select --install
```

**Linux (Ubuntu/Debian):**
```sh
sudo apt-get install build-essential
```

**Linux (Arch):**
```sh
sudo pacman -S base-devel
```

**After installing the compiler:**
1. Open nvim
2. Run `:TSInstall all` or `:TSUpdate`
3. Wait for parsers to compile
4. Restart nvim

## Icons Show as Question Marks (�)

### Cause
Your terminal font doesn't include Nerd Font icons.

### Solution
See `NERD_FONTS.md` for detailed installation instructions.

**Quick fix:** The config now uses ASCII characters `[+]`, `[-]`, `[o]` for folders, which should display correctly.

## LSP Deprecation Warnings

### Symptoms
```
The 'require('lspconfig')' 'framework' is deprecated
```

### Solution
The LSP configuration has been disabled to avoid these warnings. This is a known issue with nvim-lspconfig and Neovim 0.11+.

**Workaround:** The configuration will be updated once nvim-lspconfig releases a version compatible with Neovim 0.11+.

**Alternative:** You can enable LSP by setting `enabled = true` in `lua/plugins/lsp.lua` line 12, but you'll see deprecation warnings.

## Plugins Not Installing

### Symptoms
- Plugins show as "Not Loaded"
- Errors about missing plugins

### Solution
1. Delete plugin cache:
   ```sh
   rm -rf ~/.local/share/nvim ~/.local/state/nvim ~/.cache/nvim
   ```
2. Restart nvim
3. Plugins will auto-install
4. Or manually run `:Lazy install`

## Formatters Not Working

### Symptoms
- `:Autoformat` or `gA` doesn't format
- "Error running xo/prettier/standard"

### Cause
Formatters not installed.

### Solution
1. Open nvim
2. Run `:Mason`
3. Press `I` to install:
   - `prettier`
   - `xo`
   - `standard`
   - `stylua`
   - `black`
4. Or install globally:
   ```sh
   npm install -g prettier xo standard
   pip install black
   ```

## Slow Startup

### Symptoms
- Nvim takes several seconds to start

### Cause
- Too many plugins loading at once
- Treesitter compiling parsers

### Solution
1. Wait for initial setup to complete (first launch is slow)
2. Subsequent launches should be fast (~50ms)
3. Check startup time:
   ```sh
   nvim --startuptime startup.log
   ```

## Clipboard Not Working

### Symptoms
- `<leader>c` and `<leader>v` don't work
- Can't copy/paste to system clipboard

### Solution

**macOS:** Should work out of the box

**Linux:** Install clipboard provider:
```sh
# X11
sudo apt-get install xclip
# or
sudo apt-get install xsel

# Wayland
sudo apt-get install wl-clipboard
```

**Windows (WSL):** Install win32yank:
```sh
curl -sLo /tmp/win32yank.zip https://github.com/equalsraf/win32yank/releases/download/v0.0.4/win32yank-x64.zip
unzip -p /tmp/win32yank.zip win32yank.exe > /tmp/win32yank.exe
chmod +x /tmp/win32yank.exe
sudo mv /tmp/win32yank.exe /usr/local/bin/
```

## Markdown Preview Not Working

### Symptoms
- `gm` doesn't open preview
- Error about missing node modules

### Cause
markdown-preview.nvim requires Node.js.

### Solution
1. Install Node.js:
   ```sh
   # macOS
   brew install node
   
   # Linux
   curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
   sudo apt-get install -y nodejs
   ```
2. Rebuild the plugin:
   ```sh
   cd ~/.local/share/nvim/lazy/markdown-preview.nvim/app
   npm install
   ```
3. Restart nvim

## File Tree (Neo-tree) Not Opening

### Symptoms
- `<leader>n` doesn't work
- Error about neo-tree

### Solution
1. Check if plugin is loaded: `:Lazy`
2. Try opening manually: `:Neotree`
3. If error persists, reinstall:
   ```sh
   rm -rf ~/.local/share/nvim/lazy/neo-tree.nvim
   ```
4. Restart nvim

## Getting Help

If you encounter issues not covered here:

1. Check nvim health: `:checkhealth`
2. Check plugin status: `:Lazy`
3. Check LSP status: `:LspInfo` (if LSP is enabled)
4. Check treesitter: `:TSModuleInfo`
5. View logs: `~/.local/state/nvim/log`

## Common Commands

| Command | Description |
|---------|-------------|
| `:Lazy` | Open plugin manager |
| `:Mason` | Open LSP/formatter installer |
| `:TSInstall <lang>` | Install treesitter parser |
| `:TSUpdate` | Update all parsers |
| `:checkhealth` | Check nvim health |
| `:Autoformat` | Format current buffer |
| `:Neotree` | Open file tree |

## Reset Everything

If all else fails, start fresh:

```sh
# Backup your config
cp -r ~/.config/nvim ~/.config/nvim.backup

# Remove everything
rm -rf ~/.config/nvim ~/.local/share/nvim ~/.local/state/nvim ~/.cache/nvim

# Reinstall
unzip nvim-config-final.zip
mv nvim-config ~/.config/nvim

# Launch nvim
nvim
```
