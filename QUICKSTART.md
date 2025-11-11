# Quick Start Guide

## 🚀 5-Minute Setup

### 1. Prerequisites

**Install Neovim 0.11+**
```bash
# macOS
brew install neovim

# Linux (Ubuntu/Debian)
sudo apt install neovim
```

**Install Dependencies**
```bash
# macOS
brew install git ripgrep fd lazygit

# Linux (Ubuntu/Debian)
sudo apt install git ripgrep fd-find xclip
```

**Install Nerd Font (for icons)**
```bash
# We recommend Inconsolata LGC Nerd Font
    brew tap homebrew/cask-fonts && brew install --cask font-inconsolata-lgc-nerd-font
```

> [!TIP]
> For detailed instructions on installing Nerd Fonts and configuring your terminal, see [NERD_FONTS.md](NERD_FONTS.md) and [TERMINAL_SETUP.md](TERMINAL_SETUP.md).

### 2. Install Configuration

```bash
# Backup existing config
mv ~/.config/nvim ~/.config/nvim.backup

# Extract this config
unzip nvim-config.zip
mv nvim-config ~/.config/nvim

# Launch Neovim
nvim
```

> [!NOTE]
> Plugins will auto-install on first launch. Wait for completion, then restart Neovim.

### 3. Verify Installation

```bash
# Start Neovim
nvim test.js

# Check for errors
:checkhealth

# Verify no deprecation warnings
:messages
```

---

## ⌨️ Essential Keybindings

**Leader key:** `,` (comma)

| Category | Key | Action |
|----------|-----|--------|
| **Format** | `gA` | **Autoformat** (Manual) |
| **Git** | `<leader>gg` | Open LazyGit |
| **LSP** | `gd` | Go to definition |
| **Clipboard** | `<leader>c` | Copy to system clipboard |

> [!NOTE]
> For a complete list of keybindings, see [KEYBINDINGS.md](KEYBINDINGS.md).

---

## 🎯 Common Tasks

### Format Code

> [!IMPORTANT]
> This configuration uses **manual formatting only**. Code is NOT formatted on save.

```vim
# Option 1: Keybinding
gA

# Option 2: Command
:Autoformat
```

### Install Language Servers

```vim
# Open Mason
:Mason

# Navigate with j/k, press 'i' to install
# Recommended: typescript-language-server, lua-language-server, pyright
```

---

## 📚 Learn More

- **Full Documentation:** [README.md](README.md)
- **All Keybindings:** [KEYBINDINGS.md](KEYBINDINGS.md)
- **Plugin Details:** [PLUGINS.md](PLUGINS.md)
- **Troubleshooting:** [TROUBLESHOOTING.md](TROUBLESHOOTING.md)
- **Migration History:** [FIXES.md](FIXES.md)

---

**You're all set! Happy coding! 🎉**
