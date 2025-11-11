# Migration from Vim to Neovim

This document details the journey of migrating a long-standing Vim configuration to a modern Neovim setup at [@forwardemail](https://github.com/forwardemail). This is the actual configuration we use in production to develop all our code by hand, including our main repository at [forwardemail.net](https://github.com/forwardemail/forwardemail.net).

This project is a testament to the power of open-source and the Neovim community.

## The Original Vim Setup

For years, the Forward Email team used a battle-tested Vim configuration. It was built on top of:

- **Pathogen**: A simple and effective plugin manager.
- **A collection of classic Vim plugins**: `NERDTree`, `Syntastic`, `vim-autoformat`, and many more.
- **A `.vimrc` file**: A single, large file containing all our configurations and keybindings.

This setup served us well, but as the Neovim ecosystem matured, we saw an opportunity to modernize our development environment.

## Why Migrate to Neovim?

We decided to migrate for several key reasons:

- **Lua Configuration**: Neovim's use of Lua for configuration offered a more powerful and flexible alternative to Vimscript.
- **LSP (Language Server Protocol)**: Native LSP support in Neovim promised a more integrated and intelligent development experience.
- **Modern Plugin Ecosystem**: The Neovim community has produced a wealth of modern, Lua-based plugins that are faster and more feature-rich than their Vimscript counterparts.
- **Performance**: Neovim's asynchronous architecture offered significant performance improvements, especially for tasks like linting and formatting.

## The Migration Process

The migration was a multi-step process. Here's a summary of the key steps:

1.  **Plugin Manager**: We replaced `Pathogen` with `lazy.nvim`, a modern, fast, and feature-rich plugin manager for Neovim.

2.  **Plugin Replacement**: We replaced our classic Vim plugins with their modern Neovim equivalents:

| Old (Vim) | New (Neovim) | Reason |
| :--- | :--- | :--- |
| `Pathogen` | `lazy.nvim` | Modern, fast, lazy-loading |
| `NERDTree` | `neo-tree.nvim` | Lua-based, better performance, git integration |
| `Syntastic` | `nvim-lint` | Asynchronous, more flexible |
| `vim-autoformat` | `conform.nvim` | Smart config detection, faster |
| `vim-easymotion` | `flash.nvim` | More features, better performance |
| `supertab` | `nvim-cmp` | Modern completion engine |
| `vim-powerline` | `lualine.nvim` | Lua-based, more customizable |

3.  **Configuration Rewrite**: We rewrote our entire `.vimrc` in Lua, splitting it into a modular structure under `~/.config/nvim/lua/`.

4.  **LSP Integration**: We integrated Neovim's native LSP client, replacing `Syntastic` for real-time diagnostics and adding features like go-to-definition, find-references, and hover documentation.

5.  **Fixes and Improvements**: We went through numerous iterations to ensure 1:1 feature parity with our original Vim config, fixing issues with clipboard integration, formatting, linting, and more. You can see a complete history of these fixes in [FIXES.md](FIXES.md).

## Open Source and Contributions

We are sharing this configuration with the community in the hope that it will be useful to others. We welcome contributions of all kinds:

- **Bug reports**: If you find a bug, please open an issue.
- **Feature requests**: Have an idea for a new feature? Let us know!
- **Pull requests**: We welcome pull requests for bug fixes, new features, and documentation improvements.

### How to Contribute

1.  **Fork the repository**
2.  **Create a new branch** for your feature or bug fix
3.  **Make your changes**
4.  **Submit a pull request**

We believe in the power of open source and look forward to building a better Neovim configuration with the help of the community.

---

**Thank you for being a part of our journey!**
