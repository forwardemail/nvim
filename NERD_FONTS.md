# Nerd Fonts Installation Guide

## Why You See Question Marks ()

If you see question marks or boxes instead of icons in neo-tree and other plugins, it's because your terminal font doesn't include the special icon glyphs.

## Quick Fix

I've configured the setup to use simple ASCII characters (`+`, `-`, `*`) for folders and files, so you should see basic icons even without a Nerd Font.

However, for the best experience with proper file type icons, you should install a Nerd Font.

## Installing a Nerd Font

### macOS

**Option 1: Using Homebrew (Recommended)**

```sh
# Install our recommended Nerd Font
brew tap homebrew/cask-fonts && brew install --cask font-inconsolata-lgc-nerd-font
```

**Option 2: Manual Installation**

1. Download **Inconsolata LGC Nerd Font** from https://www.nerdfonts.com/font-downloads
2. Unzip and double-click the `.ttf` files to install
3. Restart your terminal

### Linux

```sh
# Ubuntu/Debian
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/InconsolataLGC.zip
unzip InconsolataLGC.zip
rm InconsolataLGC.zip
fc-cache -fv

# Arch Linux
yay -S nerd-fonts-inconsolata-lgc
# or
pacman -S ttf-inconsolata-lgc-nerd
```

### Windows

1. Download from https://www.nerdfonts.com/font-downloads
2. Extract the zip file
3. Right-click on the `.ttf` files and select "Install"
4. Restart your terminal

## Configure Your Terminal

After installing a Nerd Font, configure your terminal to use it:

### iTerm2 (macOS)
1. Open iTerm2 → Preferences → Profiles → Text
2. Change Font to "Inconsolata LGC Nerd Font"
3. Size: 13-14 works well

### Terminal.app (macOS)
1. Terminal → Preferences → Profiles → Font
2. Click "Change" and select your Nerd Font

### Alacritty
```yaml
# ~/.config/alacritty/alacritty.yml
font:
  normal:
    family: "Inconsolata LGC Nerd Font"
  size: 13.0
```

### Kitty
```conf
# ~/.config/kitty/kitty.conf
font_family "Inconsolata LGC Nerd Font"
font_size 13.0
```

### WezTerm
```lua
-- ~/.wezterm.lua
return {
  font = wezterm.font("Inconsolata LGC Nerd Font"),
  font_size = 13.0,
}
```

### VS Code Terminal
```json
{
  "terminal.integrated.fontFamily": "Inconsolata LGC Nerd Font",
  "terminal.integrated.fontSize": 13
}
```

## Verify Installation

After installing and configuring:

1. Restart your terminal completely
2. Open nvim
3. Press `<leader>n` to open neo-tree
4. You should now see proper file icons instead of question marks

## Alternative: Disable Icons

If you prefer not to use Nerd Fonts, the configuration already uses simple ASCII characters that work with any font:
- `+` for closed folders
- `-` for open folders
- `*` for files

These should display correctly without any special font.

## Recommended Fonts

Our top recommendation:

1. **Inconsolata LGC Nerd Font** - Our top recommendation for clarity and developer experience.
2. **MesloLGLDZ Nerd Font Mono** - A great alternative.
3. **JetBrains Mono Nerd Font** - Modern, excellent ligatures
4. **Fira Code Nerd Font** - Popular, good ligatures
5. **Hack Nerd Font** - Clean, highly readable, great for coding

All of these are free and open source.
