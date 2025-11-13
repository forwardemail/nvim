# IR Black Theme for Neovim

This package includes a fully functional IR Black color scheme ported from the classic vim-irblack theme.

## Credits

**Original Theme:**
- Created by [Todd Werth](https://x.com/twerth)
- Original Vim implementation by [Wes Gibbs](https://github.com/wesgibbs/vim-irblack) (similar to <https://github.com/twerth/ir_black>)

**Neovim Port:**
- Ported to Neovim Lua with modern Treesitter and LSP support
- Included in this configuration

## Theme Features

### Pure Black Background
- Background: `#000000` (pure black)
- Foreground: `#E8E8D3` (light grey)

### Original IR Black Colors
- **Strings:** Bright green (`#A8FF60`)
- **Numbers:** Magenta (`#FF73FD`)
- **Keywords:** Light blue (`#96CBFE`)
- **Functions:** Peach (`#FFD2A7`)
- **Classes:** Light yellow (`#FFFFB6`)
- **Comments:** Grey (`#7C7C7C`)
- **Operators:** White
- **Variables:** Light purple (`#C6C5FE`)

### Modern Neovim Support
✅ **Treesitter** - Full syntax highlighting with tree-sitter parsers
✅ **LSP Semantic Tokens** - Enhanced highlighting with language servers
✅ **Diagnostics** - Error/warning/info/hint colors
✅ **Git Signs** - Add/change/delete indicators
✅ **Neo-tree** - File explorer colors
✅ **Telescope** - Fuzzy finder colors
✅ **Terminal Colors** - All 16 ANSI colors configured

### Tested File Types
- ✅ JavaScript/TypeScript
- ✅ Markdown
- ✅ JSON
- ✅ Python
- ✅ Shell scripts
- ✅ YAML
- ✅ And more...

## Installation

```bash
# Extract and install
unzip nvim-xo-final.zip
mv nvim-xo-final ~/.config/nvim

# Clear cache
rm -rf ~/.local/share/nvim ~/.cache/nvim

# Launch Neovim
nvim
```

The IR Black theme will load automatically on startup.

## Theme Location

The theme is located at: `~/.config/nvim/colors/ir_black.lua`

## Manual Theme Switching

If you want to switch themes manually:

```vim
:colorscheme ir_black
```

## Customization

To modify colors, edit `~/.config/nvim/colors/ir_black.lua` and change the color palette values.

## Comparison with Original

This Neovim port maintains 100% color compatibility with the original vim-irblack theme while adding modern features like Treesitter and LSP support.
