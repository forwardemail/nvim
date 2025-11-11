# Terminal Setup for Icons

The icons in neo-tree require a **Nerd Font** to be installed AND configured in your terminal.

## Current Issue

You're seeing `[+]`, `[-]`, `[o]` instead of proper file icons because your terminal isn't using a Nerd Font.

## Solution

### Step 1: Install a Nerd Font

You mentioned you already installed fonts with brew. Verify:

```sh
# Check if Nerd Fonts are installed
ls ~/Library/Fonts | grep -i nerd
# or
brew list --cask | grep nerd-font
```

If not installed:

```sh
# Install our recommended Nerd Font
brew tap homebrew/cask-fonts && brew install --cask font-inconsolata-lgc-nerd-font
```

### Step 2: Configure Your Terminal

**The fonts are installed, but your terminal needs to USE them.**

#### iTerm2

1. Open iTerm2 → Preferences (`Cmd+,`)
2. Go to **Profiles** → **Text**
3. Click **Change Font** under "Font"
4. Search for "Inconsolata" in the font list
5. Select: **Inconsolata LGC Nerd Font**
6. Set size to **12** or **13**
7. Click **OK**
8. Restart iTerm2

#### Terminal.app (macOS default)

1. Open Terminal → Preferences (`Cmd+,`)
2. Go to **Profiles** tab
3. Select your profile (usually "Basic" or "Pro")
4. Click **Change** button next to Font
5. Search for "Inconsolata" in the font picker
6. Select: **Inconsolata LGC Nerd Font**
7. Set size to **12** or **13**
8. Close preferences
9. Restart Terminal

#### Alacritty

Edit `~/.config/alacritty/alacritty.yml`:

```yaml
font:
  normal:
    family: "Inconsolata LGC Nerd Font"
  size: 12.0
```

#### Kitty

Edit `~/.config/kitty/kitty.conf`:

```
font_family "Inconsolata LGC Nerd Font"
font_size 12.0
```

#### WezTerm

Edit `~/.wezterm.lua`:

```lua
return {
  font = wezterm.font("Inconsolata LGC Nerd Font"),
  font_size = 12.0,
}
```

### Step 3: Verify It Works

After configuring your terminal:

1. **Restart your terminal completely** (quit and reopen)
2. Test if Nerd Font icons work:

```sh
echo -e "\ue0a0 \ue0b0 \uf1d3 \uf015"
```

You should see: `  📁 🏠` (git branch, arrow, folder, home icons)

If you see weird boxes or question marks, the font isn't configured correctly.

3. Open nvim and check neo-tree:

```sh
nvim
# Press ,n to open neo-tree
```

You should now see proper file type icons instead of `[+]` and `[-]`.

## Troubleshooting

### Icons still not showing

1. **Verify font is installed:**
   ```sh
   ls ~/Library/Fonts | grep -i inconsolata
   ```

2. **Check terminal font setting:**
   - The font name MUST include "Nerd Font" or "NF"
   - Use "Mono" variant for best results
   - Example: "Inconsolata LGC Nerd Font" NOT just "Inconsolata"

3. **Restart terminal:**
   - Quit terminal completely (Cmd+Q)
   - Reopen and test again

4. **Try a different Nerd Font:**
   ```sh
   brew install --cask font-meslo-lg-nerd-font
   ```
   Then set terminal to "MesloLGS Nerd Font Mono"

### Which Nerd Font should I use?

**Recommended (in order):**

1. **Inconsolata LGC Nerd Font** - Our top recommendation for clarity and developer experience.
2. **MesloLGLDZ Nerd Font Mono** - A great alternative.
3. **JetBrains Mono Nerd Font** - Modern, popular with developers
4. **Fira Code Nerd Font** - Has ligatures
5. **Hack Nerd Font** - Clean, readable, well-tested

**All work equally well for icons - choose based on your preference.**

## Alternative: Disable Icons

If you don't want to use Nerd Fonts, the config already has ASCII fallbacks configured:

- `[+]` = closed folder
- `[-]` = open folder
- `[o]` = empty folder
- `*` = file

This works with any font, but you won't get file-type-specific icons.

## Summary

**To get icons working:**

1. ✅ Install Nerd Font (you did this)
2. ❌ Configure terminal to USE the Nerd Font (you need to do this)
3. ✅ Restart terminal
4. ✅ Open nvim and check

**The key step you're missing is #2 - configuring your terminal to use the Nerd Font.**
