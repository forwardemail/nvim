# Neovim Configuration

A modern, feature-rich Neovim configuration migrated from Vim with full LSP support, smart formatting, and extensive plugin ecosystem.

> **Used in production by [@forwardemail](https://github.com/forwardemail)** - This is the actual configuration we use to develop all our code, including our main repository at [forwardemail.net](https://github.com/forwardemail/forwardemail.net).

## 📋 Table of Contents

- [Features](#features)
- [Requirements](#requirements)
- [Installation](#installation)
- [Plugin Overview](#plugin-overview)
- [Keybindings](#keybindings)
- [Configuration](#configuration)
- [Troubleshooting](#troubleshooting)
- [Documentation](#documentation)
- [About Forward Email](#-about-forward-email)
- [Our Migration Story](#-our-migration-story)
- [Contributing](#-contributing)
- [License](#-license)


## ✨ Features

- **🚀 Modern LSP Support** - Native Neovim 0.11+ LSP with `vim.lsp.config` API
- **🎨 Smart Syntax Highlighting** - [Treesitter](https://github.com/nvim-treesitter/nvim-treesitter)-based highlighting for 40+ languages
- **📝 Intelligent Manual Formatting** - Auto-detects project configs ([Prettier](https://prettier.io/), [ESLint](https://eslint.org/), etc.)
- **🔍 Fuzzy Finding** - [Telescope](https://github.com/nvim-telescope/telescope.nvim) for files, buffers, and text search
- **🌳 File Explorer** - [Neo-tree](https://github.com/nvim-neo-tree/neo-tree.nvim) with git integration
- **⚡ Fast Navigation** - [Flash.nvim](https://github.com/folke/flash.nvim) for quick jumps
- **🔧 Git Integration** - [Gitsigns](https://github.com/lewis6991/gitsigns.nvim) + [LazyGit](https://github.com/jesseduffield/lazygit) for version control
- **💡 Code Completion** - [nvim-cmp](https://github.com/hrsh7th/nvim-cmp) with LSP, snippets, and path completion
- **🎯 Linting** - Real-time error checking with [nvim-lint](https://github.com/mfussenegger/nvim-lint)
- **📦 Plugin Management** - [Lazy.nvim](https://github.com/folke/lazy.nvim) for fast, lazy-loaded plugins


## 📦 Requirements

### Neovim

- **[Neovim](https://neovim.io/) 0.10.0+** (required for XO linting and native LSP API)
- Check version: `nvim --version`
- Install: [Neovim Releases](https://github.com/neovim/neovim/releases)

> [!IMPORTANT]
> This configuration requires Neovim 0.10.0 or later. XO linting uses `vim.system()` API which is only available in Neovim 0.10+.

### External Dependencies

A C compiler is required for [`nvim-treesitter`](https://github.com/nvim-treesitter/nvim-treesitter) to build parsers.

- **macOS**: Run `xcode-select --install`
- **Linux (Ubuntu/Debian)**: Run `sudo apt install build-essential`

#### macOS
```bash
# Required
brew install git ripgrep fd

# Optional (for LazyGit)
brew install lazygit
```

#### Linux (Ubuntu/Debian)
```bash
# Required
sudo apt install git ripgrep fd-find

# Optional (for clipboard)
sudo apt install xclip

# Optional (for LazyGit)
# See: https://github.com/jesseduffield/lazygit#installation
```

### Nerd Fonts (for Icons)

For proper icon rendering, you need to install and configure a [Nerd Font](https://www.nerdfonts.com/).

1.  **Install Nerd Font**
    ```bash
    # We recommend Inconsolata LGC Nerd Font
    brew tap homebrew/cask-fonts && brew install --cask font-inconsolata-lgc-nerd-font
    ```

2.  **Configure Your Terminal**
    - **iTerm2**: `Preferences` → `Profiles` → `Text` → `Font` → Select `Inconsolata LGC Nerd Font`
    - **Alacritty**: See `alacritty.yml` example in [TERMINAL_SETUP.md](TERMINAL_SETUP.md)

> [!TIP]
> For detailed instructions on installing Nerd Fonts and configuring your terminal, see [NERD_FONTS.md](NERD_FONTS.md) and [TERMINAL_SETUP.md](TERMINAL_SETUP.md).

### Language Servers & Tools

These are automatically installed via [Mason](https://github.com/williamboman/mason.nvim) when you first open Neovim:

- **LSP Servers**: `lua-language-server`, `typescript-language-server`, `pyright`, etc.
- **Formatters**: `prettier`, `stylua`, `black`
- **Linters**: `eslint_d`, `markdownlint`, `shellcheck`

### XO Linter (Required for JavaScript/TypeScript)

If you're working with JavaScript/TypeScript projects that use XO:

```bash
# Install XO globally
npm install -g xo

# Verify installation
xo --version
```

> [!NOTE]
> XO linting will only run on files in projects with XO configuration in `package.json`. See the XO Configuration section below.


## 🚀 Installation

> [!NOTE]
> For a more detailed installation guide, see [INSTALL.md](INSTALL.md).

### 1. Backup Existing Config

```bash
# Backup your current Neovim config
mv ~/.config/nvim ~/.config/nvim.backup
mv ~/.local/share/nvim ~/.local/share/nvim.backup
mv ~/.local/state/nvim ~/.local/state/nvim.backup
```

### 2. Install This Config

```bash
# Extract the zip file and move it to the correct location
unzip nvim-config.zip
mv nvim-config ~/.config/nvim
```

### 3. First Launch

```bash
# Start Neovim
nvim
```

[Lazy.nvim](https://github.com/folke/lazy.nvim) will automatically install all plugins. Wait for the installation to complete, then restart Neovim.

> [!WARNING]
> You may see some errors on the first launch. This is normal. Restart Neovim after the initial setup is complete.

### 4. Install Language Servers

```bash
# Open Mason
:Mason

# Or install specific servers
:MasonInstall typescript-language-server lua-language-server pyright
```


## 🔌 Plugin Overview

> [!NOTE]
> For a complete list of plugins and their configurations, see [PLUGINS.md](PLUGINS.md).

### Formatting & Linting

#### ✨ [conform.nvim](https://github.com/stevearc/conform.nvim)
**Code Formatter** - Format code with multiple formatters.

> [!IMPORTANT]
> This configuration uses **manual formatting only**. Code is NOT formatted on save. You must run the format command manually.

**Usage:**
- **Manual format**: `gA` or `:Autoformat`

**Supported Formatters:**
- **JavaScript/TypeScript**: [Prettier](https://prettier.io/)
- **Python**: [black](https://github.com/psf/black), [ruff_format](https://docs.astral.sh/ruff/formatter/)
- **Lua**: [Stylua](https://github.com/JohnnyMorganz/StyLua)
- **Markdown/JSON/YAML/CSS/HTML**: [Prettier](https://prettier.io/)

#### 🔍 XO Linting (Direct Implementation)
**Linter** - Real-time error checking for JavaScript/TypeScript.

**Features:**
- **Runs on save** - Displays linting errors immediately
- **No auto-fix** - Shows issues without changing your code
- **Manual fix** - Use `:Autoformat` or fix by hand
- **Project-aware** - Respects your `package.json` XO config

**XO Configuration Example** (`package.json`):
```json
{
  "xo": {
    "semicolon": true,
    "space": true,
    "rules": {
      "capitalized-comments": "off"
    }
  }
}
```

> [!TIP]
> XO is a wrapper around ESLint with sensible defaults. See [XO documentation](https://github.com/xojs/xo) for all configuration options.

#### 🔍 [nvim-lint](https://github.com/mfussenegger/nvim-lint)
**Linter** - Real-time error checking for other languages.

**Smart Detection:**
- Linters only run if project config files exist (e.g., `.eslintrc` for `eslint_d`).
- Shows helpful tips when linters aren't installed.


## ⌨️ Keybindings

> [!NOTE]
> For a complete list of keybindings, see [KEYBINDINGS.md](KEYBINDINGS.md).

### Quick Reference

| Category | Key | Action |
|----------|-----|--------|
| **File** | `<leader>w` | Save file |
| **File** | `<leader>n` | Toggle file tree |
| **Search** | `<leader>ff` | Find files |
| **Search** | `<leader>fg` | Search in files |
| **Format** | `gA` | **Autoformat** (Manual) |
| **Git** | `<leader>gg` | Open LazyGit |
| **LSP** | `gd` | Go to definition |
| **Clipboard** | `<leader>c` | Copy to system clipboard |
| **Clipboard** | `<leader>v` | Paste from system clipboard |


## ⚙️ Configuration

### File Structure

```
~/.config/nvim/
├── init.lua                 # Entry point
├── lua/
│   ├── config/              # Core config
│   └── plugins/             # Plugin configs
├── README.md                # This file
└── ... (other documentation files)
```

### Customization

#### IR Black Theme

This configuration uses the **IR Black** color scheme - a classic dark theme with pure black background (`#000000`).

**Credits:**
- Original theme by [Todd Werth](https://x.com/twerth)
- Vim implementation by [Wes Gibbs](https://github.com/wesgibbs/vim-irblack)
- Neovim port included in this configuration

**Features:**
- Pure black background for OLED displays
- High contrast colors optimized for long coding sessions
- Full Treesitter and LSP semantic token support
- Integrated with all plugins (Neo-tree, Telescope, Gitsigns, etc.)

**Theme location:** `~/.config/nvim/colors/ir_black.lua`

For detailed theme documentation, see [IR_BLACK_THEME.md](IR_BLACK_THEME.md).

#### Change Colorscheme

To use a different theme, edit `lua/plugins/colorscheme.lua` and `init.lua`.


## 🐛 Troubleshooting

> [!NOTE]
> For a more detailed troubleshooting guide, see [TROUBLESHOOTING.md](TROUBLESHOOTING.md).

### Common Issues

#### LSP Not Working

```bash
# Check LSP status
:LspInfo

# Install language server
:Mason
```

#### Clipboard Not Working

**macOS**: `pbcopy`/`pbpaste` are built-in.

**Linux**: Install `xclip`
```bash
sudo apt install xclip
```


## 📚 Documentation

This project includes comprehensive documentation. Here are the key files:

- **[QUICKSTART.md](QUICKSTART.md)**: A 5-minute guide to get you up and running.
- **[README.md](README.md)**: You are here. Overview of the project.
- **[INSTALL.md](INSTALL.md)**: Detailed installation instructions.
- **[KEYBINDINGS.md](KEYBINDINGS.md)**: Complete keybinding reference.
- **[LSP_DIAGNOSTICS.md](LSP_DIAGNOSTICS.md)**: Guide to understanding and managing LSP diagnostics, hints, and code actions.
- **[PLUGINS.md](PLUGINS.md)**: In-depth documentation for all plugins.
- **[TROUBLESHOOTING.md](TROUBLESHOOTING.md)**: Solutions to common problems.
- **[NERD_FONTS.md](NERD_FONTS.md)**: Guide to installing and configuring Nerd Fonts for icons.
- **[TERMINAL_SETUP.md](TERMINAL_SETUP.md)**: Instructions for setting up your terminal.
- **[IR_BLACK_THEME.md](IR_BLACK_THEME.md)**: Documentation for the IR Black color scheme.
- **[MIGRATION.md](MIGRATION.md)**: Our story of migrating from Vim to Neovim.
- **[CONTRIBUTING.md](CONTRIBUTING.md)**: Guidelines for contributing to this project.
- **[LICENSE.md](LICENSE.md)**: The MIT License for this project.


## 📝 Version History

> [!NOTE]
> For a complete migration history and list of all fixes, see [Releases](/releases).


## 🏢 About Forward Email

This configuration is used in production by the [@forwardemail](https://github.com/forwardemail) team. We develop all our code by hand using this setup, including:

- **Main Repository**: [forwardemail.net](https://github.com/forwardemail/forwardemail.net) - Our core email forwarding service
- **All Forward Email projects**: Every line of code we write uses this Neovim configuration

We're sharing this configuration with the community because we believe in open source and want to give back to the tools that make our work possible.

## 📖 Our Migration Story

This configuration is the result of a long and rewarding journey migrating from a classic Vim + [Pathogen](https://github.com/tpope/vim-pathogen) setup to a modern Neovim + Lua configuration. We've documented this process in [MIGRATION.md](MIGRATION.md) to share our experience with the community.

**Key Highlights:**
- Migrated from [Pathogen](https://github.com/tpope/vim-pathogen) to [lazy.nvim](https://github.com/folke/lazy.nvim)
- Replaced all classic Vim plugins with modern Neovim equivalents
- Achieved 1:1 feature parity with our original Vim setup
- Numerous fixes and improvements

## 🤝 Contributing

This is an open-source project, and we welcome contributions of all kinds! Whether you're:

- Fixing a bug
- Adding a new feature
- Improving documentation
- Sharing your experience

Please see our [contribution guidelines](CONTRIBUTING.md) for more information.

**Find us on GitHub**: [@forwardemail](https://github.com/forwardemail)


## 📄 License

This project is licensed under the MIT License. See the [LICENSE.md](LICENSE.md) file for details.

© 2025 Forward Email LLC
