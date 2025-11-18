# Complete Installation Guide

**Total Time**: 1-2 hours
**Difficulty**: Intermediate

This guide will walk you through setting up a complete macOS development environment with Neovim, AI capabilities, and system automation.

## Prerequisites

- macOS 12+ (Monterey or later)
- Administrator access
- Internet connection
- Basic terminal knowledge

## Part 1: macOS System Setup (45-60 minutes)

### Step 1: Security Configuration (15 minutes)

#### Enable FileVault

1. Open **System Settings** → **Privacy & Security** → **FileVault**
2. Click **Turn On FileVault**
3. Create a recovery key (**do not use iCloud**)
4. Write down the recovery key and store it securely

#### Enable Firewall

1. **System Settings** → **Privacy & Security** → **Firewall**
2. Click **Turn On Firewall**
3. Click **Firewall Options**
4. Check **Block all incoming connections**

#### Set Password Requirement

1. **System Settings** → **Privacy & Security** → **General**
2. Under **Require password**, select **immediately**

### Step 2: Install Homebrew (5 minutes)

```bash
# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Follow the on-screen instructions to add Homebrew to your PATH
# Usually something like:
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"

# Verify installation
brew --version
```

### Step 3: Install System Packages (30 minutes)

```bash
# Navigate to the macos-setup directory
cd /path/to/nvim-complete-final/macos-setup

# Install all packages from Brewfile
brew bundle --file=Brewfile

# This will take 20-30 minutes
# Homebrew will install:
# - 90+ command-line tools
# - 40+ GUI applications
# - 6 Nerd Fonts
# - Databases (Redis, MongoDB)
# - AI tools (Ollama)
```

### Step 4: Configure Shell (10 minutes)

#### Set up fzf

```bash
# Run the automated setup script
./setup-fzf.sh

# Reload your shell
source ~/.zshrc
```

#### Configure Powerlevel10k

```bash
# Run the configuration wizard
p10k configure

# Follow the interactive prompts to customize your prompt
```

### Step 5: Privacy Hardening (5 minutes)

```bash
# Block Apple telemetry domains
echo "0.0.0.0 iprofiles.apple.com" | sudo tee -a /etc/hosts
echo "0.0.0.0 mdmenrollment.apple.com" | sudo tee -a /etc/hosts
echo "0.0.0.0 deviceenrollment.apple.com" | sudo tee -a /etc/hosts
echo "0.0.0.0 gdmf.apple.com" | sudo tee -a /etc/hosts
echo "0.0.0.0 ocsp.apple.com" | sudo tee -a /etc/hosts

# Configure OCSP
sudo defaults write /Library/Preferences/com.apple.security.revocation.plist OCSPStyle None
sudo defaults write com.apple.security.revocation.plist OCSPStyle None
```

### Step 6: System Tweaks (5 minutes)

```bash
# Show hidden files in Finder
defaults write com.apple.finder AppleShowAllFiles TRUE

# Use list view by default
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

# Show path bar
defaults write com.apple.finder ShowPathbar -bool true

# Show status bar
defaults write com.apple.finder ShowStatusBar -bool true

# Remove dock indicators
defaults write com.apple.Dock show-process-indicators -bool false

# Don't show recent apps
defaults write com.apple.Dock show-recents -bool false

# Apply changes
killall Finder
killall Dock
```

### Step 7: Configure DNS (5 minutes)

1. **System Settings** → **Network** → **Advanced** → **DNS**
2. Add DNS servers:
   - `1.1.1.1` (Cloudflare)
   - `1.0.0.1` (Cloudflare backup)
3. Click **OK** → **Apply**

---

## Part 2: Neovim Setup (30-45 minutes)

### Step 1: Backup Existing Configuration (2 minutes)

```bash
# Backup your current Neovim config (if any)
mv ~/.config/nvim ~/.config/nvim.backup
mv ~/.local/share/nvim ~/.local/share/nvim.backup
mv ~/.local/state/nvim ~/.local/state/nvim.backup
```

### Step 2: Install Neovim Configuration (2 minutes)

```bash
# Copy the configuration
cp -r /path/to/nvim-complete-final ~/.config/nvim

# Verify the copy
ls ~/.config/nvim
```


```bash
# Navigate to the Neovim config directory
cd ~/.config/nvim


# This will:
# - Install @modelcontextprotocol/server-playwright
# - Install Playwright browsers
```

### Step 4: Grant macOS Permissions (5 minutes)

When prompted, grant these permissions:

1. **Accessibility**:
   - **System Settings** → **Privacy & Security** → **Accessibility**
   - Enable for Terminal/iTerm2

2. **Automation**:
   - **System Settings** → **Privacy & Security** → **Automation**
   - Enable for Terminal/iTerm2 → System Events
   - Enable for Terminal/iTerm2 → Finder

### Step 5: Start Ollama (5 minutes)

```bash
# Start Ollama service (in a separate terminal)
ollama serve

# In another terminal, pull the model
ollama pull qwen2.5-coder:7b-instruct-q4_K_M

# This will download ~4.4GB
# Wait for it to complete
```

### Step 6: Verify Installation (5 minutes)

```bash
# Run the verification script
cd ~/.config/nvim
./verify-installation.sh

# Check for:
# ✓ Neovim version 0.10+
# ✓ Node.js version 18+
# ✓ Git installed
# ✓ Ripgrep installed
# ✓ fd installed
# ✓ Ollama running
# ✓ Model downloaded
# ✓ Playwright browsers installed
```

### Step 7: First Launch (10 minutes)

```bash
# Start Neovim
nvim

# Lazy.nvim will automatically install all plugins
# Wait for installation to complete (2-3 minutes)

# You may see some errors - this is normal on first launch
# Close Neovim and restart:
# :qa

# Start Neovim again
nvim

# Everything should work now
```

### Step 8: Test Features (5 minutes)

#### Test File Explorer
```vim
" Press ,e to toggle Neo-tree
" Navigate with j/k
" Press Enter to open a file
```

#### Test Telescope
```vim
" Press ,ff to find files
" Type to search
" Press Enter to open
```

```vim
" Check that both servers show "Running"
" Press 'q' to close
```

#### Test Avante (AI Assistant)
```vim
" Press ,aa to open Avante
" Type: "Hello, can you help me?"
" Wait for response (5-10 seconds)
```

---

## Part 3: Optional Enhancements (15-30 minutes)

### Install Additional Applications

These applications are recommended but not included in the Brewfile:

#### SquirrelDisk (Disk Usage Analyzer)
```bash
# Download from GitHub
open https://github.com/adileo/squirreldisk/releases

# Install manually
```

#### swiftGuard (USB Security Monitor)
```bash
# Download from GitHub
open https://github.com/Lennolium/swiftGuard/releases

# Install manually
```

### Configure iTerm2

1. **Set as default terminal**: iTerm2 → Make iTerm2 Default Term
2. **Theme**: Preferences → Appearance → Theme → Dark
3. **Font**: Preferences → Profiles → Text → Font → 14pt Inconsolata Nerd Font
4. **Color scheme**: Preferences → Profiles → Colors → Import → Select a scheme

### Set Up GPG/SSH Keys

```bash
# Generate GPG key
gpg --full-generate-key

# Generate SSH key
ssh-keygen -t ed25519 -C "your_email@example.com"

# Add SSH key to agent
ssh-add ~/.ssh/id_ed25519
```

### Configure Git

```bash
# Set your name and email
git config --global user.name "Your Name"
git config --global user.email "your_email@example.com"

# Set default branch name
git config --global init.defaultBranch main

# Enable GPG signing (optional)
git config --global commit.gpgsign true
git config --global user.signingkey YOUR_GPG_KEY_ID
```

---

## Verification Checklist

### macOS System
- [ ] FileVault enabled
- [ ] Firewall enabled
- [ ] Password required immediately
- [ ] Homebrew installed
- [ ] All packages from Brewfile installed
- [ ] fzf configured (test with Ctrl+R)
- [ ] Powerlevel10k configured
- [ ] Apple telemetry blocked
- [ ] DNS configured (Cloudflare)
- [ ] Finder tweaks applied
- [ ] Dock tweaks applied

### Neovim
- [ ] Config copied to `~/.config/nvim/`
- [ ] macOS permissions granted
- [ ] Ollama running
- [ ] Model downloaded
- [ ] Verification script passed
- [ ] Plugins installed
- [ ] Neo-tree works (`,e`)
- [ ] Telescope works (`,ff`)
- [ ] Avante responds (`,aa`)

### Optional
- [ ] SquirrelDisk installed
- [ ] swiftGuard installed
- [ ] iTerm2 configured
- [ ] GPG keys set up
- [ ] SSH keys set up
- [ ] Git configured

---

## Troubleshooting

### Homebrew Issues

**Error: Permission denied**
```bash
sudo chown -R $(whoami) /usr/local/bin /usr/local/lib /usr/local/share
chmod u+w /usr/local/bin /usr/local/lib /usr/local/share
```

### Neovim Issues

**Plugins not loading**
```bash
rm -rf ~/.local/share/nvim/lazy
nvim
```

```bash
# Check Node.js version
node --version  # Should be 18+

cd ~/.config/nvim
```

**Avante not responding**
```bash
# Check Ollama
curl http://localhost:11434/api/tags

# Restart Ollama
pkill ollama
ollama serve
```

### fzf Issues

**Ctrl+R not working**
```bash
# Ensure fzf is sourced
echo '[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh' >> ~/.zshrc
source ~/.zshrc
```

---

## Next Steps

### Learn the Keybindings

Read [KEYBINDINGS.md](KEYBINDINGS.md) for a complete reference.

### Explore the Documentation

- [NEOVIM_README.md](NEOVIM_README.md) - Complete Neovim docs
- [macos-setup/MACOS_SETUP_GUIDE.md](macos-setup/MACOS_SETUP_GUIDE.md) - macOS guide

### Customize Your Setup

- Edit `~/.config/nvim/lua/config/options.lua` for Neovim settings
- Edit `~/.zshrc` for shell customization
- Edit `macos-setup/Brewfile` to add/remove packages

---

## Getting Help

### Documentation
- Check the relevant documentation file
- Search for your issue in [TROUBLESHOOTING.md](TROUBLESHOOTING.md)

### Known Issues

### Community
- [Neovim Discourse](https://neovim.discourse.group/)
- [Avante.nvim GitHub](https://github.com/yetone/avante.nvim)

---

## Maintenance

### Weekly
```bash
# Update Homebrew packages
brew update && brew upgrade && brew cleanup
```

### Monthly
```bash
# Update Neovim plugins
nvim
:Lazy update

# Update Ollama
brew upgrade ollama
ollama pull qwen2.5-coder:7b-instruct-q4_K_M
```

---

**Congratulations!** You now have a complete, modern, and secure macOS development environment. Happy coding! 🎉
