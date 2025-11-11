# Installation Guide

This guide walks you through installing and setting up your new Neovim configuration.

## Prerequisites

Before you begin, ensure you have the following installed:

### Required

1.  **Neovim 0.11+**
    -   Check your version: `nvim --version`
    -   Download from: https://github.com/neovim/neovim/releases

    > [!IMPORTANT]
    > This configuration requires Neovim 0.11+ for the native LSP API.

2.  **Git**
    -   Required for plugin management with `lazy.nvim`.
    -   Check: `git --version`

3.  **A C Compiler**
    -   Required for building `nvim-treesitter` parsers.
    -   **macOS**: `xcode-select --install`
    -   **Linux**: `sudo apt install build-essential`

### Recommended

1.  **`ripgrep` and `fd`** - For fast searching in Telescope.
    ```bash
    # macOS
    brew install ripgrep fd

    # Linux (Ubuntu/Debian)
    sudo apt install ripgrep fd-find
    ```

2.  **A Nerd Font** - For icons in the UI.
    -   **Installation**: See the [NERD_FONTS.md](NERD_FONTS.md) guide.
    -   **Configuration**: See the [TERMINAL_SETUP.md](TERMINAL_SETUP.md) guide.

    > [!TIP]
    > We recommend **Inconsolata LGC Nerd Font**. You can install it on macOS with:
    > `brew tap homebrew/cask-fonts && brew install --cask font-inconsolata-lgc-nerd-font`

3.  **`lazygit`** - For the terminal-based Git UI.
    ```bash
    # macOS
    brew install lazygit
    ```

## Installation Steps

### 1. Backup Existing Configuration

> [!CAUTION]
> This will replace your existing Neovim configuration. Make sure to back it up first.

```bash
# Backup your current Neovim setup
mv ~/.config/nvim ~/.config/nvim.backup
mv ~/.local/share/nvim ~/.local/share/nvim.backup
```

### 2. Install the Configuration

```bash
# Extract the zip file
unzip nvim-config.zip

# Move it to the correct location
mv nvim-config ~/.config/nvim
```

### 3. First Launch

Start Neovim:

```bash
nvim
```

On the first launch, `lazy.nvim` will automatically install all plugins. Wait for this process to complete, then restart Neovim.

### 4. Install Language Servers and Tools

After restarting, open Neovim and run:

```vim
:Mason
```

This opens the Mason UI. We recommend installing the following:
-   **LSP Servers**: `typescript-language-server`, `lua-language-server`, `pyright`
-   **Formatters**: `prettier`, `stylua`, `black`
-   **Linters**: `eslint_d`

> [!NOTE]
> You can press `i` on a package in the Mason UI to install it.

### 5. Test the Configuration

1.  **Open a file**:
    ```bash
    nvim test.js
    ```

2.  **Test Manual Formatting**:
    -   Type some unformatted code.
    -   Run `:Autoformat` or press `gA` in normal mode.
    -   The code should be formatted.

3.  **Test LSP**:
    -   Hover over a symbol with `K`.
    -   Go to definition with `gd`.

## Troubleshooting

> [!NOTE]
> For a more detailed guide, see [TROUBLESHOOTING.md](TROUBLESHOOTING.md).

-   **Plugins not loading?** Run `:Lazy sync`.
-   **LSP not working?** Run `:LspInfo` and check `:Mason` to ensure the server is installed.
-   **Icons not showing?** Make sure you have installed and configured a Nerd Font as described in [NERD_FONTS.md](NERD_FONTS.md) and [TERMINAL_SETUP.md](TERMINAL_SETUP.md).

## Next Steps

-   Read the [QUICKSTART.md](QUICKSTART.md) for essential keybindings and common tasks.
-   Explore the full documentation in [README.md](README.md).
