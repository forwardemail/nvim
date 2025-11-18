# macOS Development Environment Setup Guide

This comprehensive guide will help you set up a secure, privacy-focused, and productive macOS development environment with modern tools and best practices.

## Table of Contents

- [Initial System Setup](#initial-system-setup)
- [Security & Privacy Configuration](#security--privacy-configuration)
- [Homebrew Installation](#homebrew-installation)
- [Package Installation](#package-installation)
- [fzf Setup and Demo](#fzf-setup-and-demo)
- [Shell Configuration](#shell-configuration)
- [Recommended Applications](#recommended-applications)
- [System Tweaks](#system-tweaks)
- [Additional Resources](#additional-resources)

---

## Initial System Setup

### First Boot Configuration

When setting up your Mac for the first time, follow these privacy-focused recommendations:

1. **Disable unnecessary services** during onboarding:
   - Location Services
   - Siri
   - Analytics and tracking
   - iCloud (if you prefer local-only storage)

2. **Clean up the Dock**: Remove unused applications to maintain a minimal workspace. Keep only essential apps like Finder, your browser, and terminal.

3. **Network Configuration**: Set up DNS servers for better privacy and performance.

---

## Security & Privacy Configuration

### FileVault Encryption

**Enable FileVault** to encrypt your entire disk:

1. Open **System Settings** → **Privacy & Security**
2. Click on **FileVault** tab
3. Click **Turn On FileVault**
4. **Important**: Create a recovery key and **do not use iCloud**
5. Store the recovery key securely (write it down and keep in a safe place)

### Firewall Configuration

Enable the built-in macOS firewall:

1. Go to **System Settings** → **Privacy & Security** → **Firewall**
2. Click **Turn On Firewall**
3. Click **Firewall Options**
4. Check **Block all incoming connections**

### Password Requirements

Set immediate password requirement:

1. **System Settings** → **Privacy & Security** → **General**
2. Under **Require password**, change to **immediately** after sleep or screen saver begins

### Privacy Hardening

Block Apple telemetry and tracking domains by adding them to `/etc/hosts`:

```bash
# Block Apple telemetry
echo "0.0.0.0 iprofiles.apple.com" | sudo tee -a /etc/hosts
echo "0.0.0.0 mdmenrollment.apple.com" | sudo tee -a /etc/hosts
echo "0.0.0.0 deviceenrollment.apple.com" | sudo tee -a /etc/hosts
echo "0.0.0.0 gdmf.apple.com" | sudo tee -a /etc/hosts
echo "0.0.0.0 ocsp.apple.com" | sudo tee -a /etc/hosts

# Apply changes
sudo defaults write /Library/Preferences/com.apple.security.revocation.plist OCSPStyle None
sudo defaults write com.apple.security.revocation.plist OCSPStyle None
```

### DNS Configuration

Use privacy-focused DNS servers:

1. **System Settings** → **Network** → **Advanced** → **DNS**
2. Add DNS servers:
   - **Cloudflare**: `1.1.1.1` and `1.0.0.1`
   - **Cloudflare for Families** (blocks malware): `1.1.1.2` and `1.0.0.2`
   - **Cloudflare for Families** (blocks malware + adult content): `1.1.1.3` and `1.0.0.3`

### Time Server

Use Cloudflare's time server instead of Apple's:

1. **System Settings** → **General** → **Date & Time**
2. Change time server to: `time.cloudflare.com`

---

## Homebrew Installation

Homebrew is the essential package manager for macOS. Install it first:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

After installation, follow the on-screen instructions to add Homebrew to your PATH. Then update and upgrade:

```bash
brew update
brew upgrade
```

---

## Package Installation

### Using the Brewfile

This repository includes a comprehensive `Brewfile` with all recommended packages. Install everything at once:

```bash
# Navigate to the setup directory
cd /path/to/macos-setup

# Install all packages from Brewfile
brew bundle --file=Brewfile
```

The Brewfile includes:

- **Command-line tools**: bat, eza, fd, fzf, ripgrep, zoxide
- **Development tools**: git, gh, lazygit, neovim
- **Programming languages**: Node.js, Python, Go, PHP
- **Security tools**: pass, gnupg, browserpass
- **Databases**: Redis, MongoDB
- **AI tools**: Ollama (local LLM server)
- **GUI applications**: iTerm2, Ungoogled Chromium, Signal, UTM
- **Nerd Fonts**: For terminal customization

### Selective Installation

If you prefer to install packages selectively, you can install individual items:

```bash
# Install a specific formula
brew install fzf

# Install a specific cask
brew install --cask iterm2
```

---

## fzf Setup and Demo

**fzf** is a powerful fuzzy finder that dramatically improves your command-line productivity. The most useful feature is **Ctrl+R** for searching command history.

### Automatic Setup

Run the included setup script:

```bash
./setup-fzf.sh
```

This script will:
- Install fzf via Homebrew
- Configure key bindings
- Set up fuzzy completion
- Add custom color scheme
- Integrate with fd for better file searching

### Manual Setup

If you prefer manual setup:

```bash
# Install fzf
brew install fzf

# Install key bindings and fuzzy completion
$(brew --prefix)/opt/fzf/install

# Add to your shell configuration (~/.zshrc or ~/.bashrc)
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh  # For zsh
[ -f ~/.fzf.bash ] && source ~/.fzf.bash  # For bash
```

### Using Ctrl+R for History Search

The **Ctrl+R** binding is the most powerful fzf feature. Here's how it works:

#### Traditional Bash History (Without fzf)

```bash
# Press Ctrl+R and type search term
# You see only one match at a time
# Must press Ctrl+R repeatedly to cycle through matches
(reverse-i-search)`git': git commit -m "Update README"
```

#### Enhanced History Search (With fzf)

Press **Ctrl+R** and you'll see an interactive fuzzy finder:

```
> git
  50/1247
> git commit -m "Fix bug in authentication"
  git push origin main
  git pull --rebase
  git status
  git log --oneline
  git checkout -b feature/new-feature
  git add .
  git diff HEAD~1
  git branch -a
  git merge develop
```

**Key features**:
- **Fuzzy matching**: Type `gcm` to find `git commit -m`
- **Multi-line preview**: See full command with context
- **Arrow keys**: Navigate up/down through matches
- **Real-time filtering**: Results update as you type
- **Exact match**: Prefix with `'` for exact matching (e.g., `'git commit`)
- **Inverse match**: Prefix with `!` to exclude (e.g., `!test`)

**Example workflow**:

```bash
# You want to find that docker command you ran last week
$ # Press Ctrl+R
> docker
  15/1247
> docker run -it --rm -v $(pwd):/app node:18 npm test
  docker compose up -d
  docker ps -a
  docker logs container_name
  docker exec -it container_name bash

# Type more to narrow down: "docker run node"
> docker run node
  3/1247
> docker run -it --rm -v $(pwd):/app node:18 npm test
  docker run -d -p 3000:3000 node:18
  docker run --name myapp node:18 npm start

# Press Enter to execute, or Tab to edit first
```

### Other fzf Key Bindings

- **Ctrl+T**: Search and insert file paths
  ```bash
  $ vim # Press Ctrl+T, select file
  $ vim /path/to/selected/file.txt
  ```

- **Alt+C**: Change to a directory using fuzzy search
  ```bash
  $ # Press Alt+C, type "doc"
  $ cd ~/Documents/projects/my-project
  ```

### Custom fzf Configuration

The setup script adds these enhancements to your shell:

```bash
# Custom color scheme
export FZF_DEFAULT_OPTS='
  --height 40%
  --layout=reverse
  --border
  --inline-info'

# Use fd instead of find (faster, respects .gitignore)
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
```

---

## Shell Configuration

### Switch to zsh

macOS uses zsh as the default shell. Ensure it's set:

```bash
chsh -s $(which zsh)
```

### Install Powerlevel10k Theme

Powerlevel10k is a fast, customizable zsh theme:

```bash
# Already installed via Brewfile
# Configure it
p10k configure
```

Follow the interactive configuration wizard to customize your prompt.

### Shell Enhancements

Add these to your `~/.zshrc`:

```bash
# Enable zsh plugins (installed via Homebrew)
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# fzf integration
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# zoxide (smarter cd)
eval "$(zoxide init zsh)"

# Aliases for modern tools
alias ls='eza --icons'
alias ll='eza -l --icons'
alias la='eza -la --icons'
alias cat='bat'
alias cd='z'  # Use zoxide

# Suppress last login message
touch ~/.hushlogin
```

### iTerm2 Configuration

1. **Set as default terminal**: iTerm2 → Make iTerm2 Default Term
2. **Theme**: Preferences → Appearance → Theme → Dark
3. **Font**: Preferences → Profiles → Text → Font → 14pt Inconsolata Nerd Font (or any Nerd Font)
4. **Color scheme**: Import a color scheme or use built-in "Solarized Dark"

---

## Recommended Applications

### Applications with GitHub Pages

The following applications are recommended for a complete macOS setup. Most are available via Homebrew, but some require manual installation.

| Application | Description | Installation | GitHub |
|------------|-------------|--------------|--------|
| **SquirrelDisk** | Fast disk usage analyzer (Rust-based) | [Manual Download](https://github.com/adileo/squirreldisk/releases) | [GitHub](https://github.com/adileo/squirreldisk) |
| **Crystal Fetch** | Windows 11 ISO creator for VMs | `brew install --cask crystalfetch` | [GitHub](https://github.com/TuringSoftware/CrystalFetch) |
| **Gifski** | High-quality GIF converter | `brew install --cask gifski` | [GitHub](https://github.com/sindresorhus/Gifski) |
| **OpenRCT2** | RollerCoaster Tycoon 2 reimplementation | `brew install --cask openrct2` | [GitHub](https://github.com/OpenRCT2/OpenRCT2) |
| **Raspberry Pi Imager** | Create bootable Raspberry Pi media | `brew install --cask raspberry-pi-imager` | [GitHub](https://github.com/raspberrypi/rpi-imager) |
| **swiftGuard** | USB port monitoring for security | [Manual Download](https://github.com/Lennolium/swiftGuard/releases) | [GitHub](https://github.com/Lennolium/swiftGuard) |
| **Unetbootin** | Create bootable USB drives | `brew install --cask unetbootin` | [Website](https://unetbootin.github.io/) |
| **UTM** | Virtual machines for macOS | `brew install --cask utm` | [GitHub](https://github.com/utmapp/UTM) |
| **SQLiteStudio** | SQLite database browser | `brew install --cask sqlitestudio` | [Website](https://sqlitestudio.pl/) |

### Display Pilot 2

**Display Pilot 2** is a commercial display management utility. It's not available via Homebrew and must be purchased/downloaded from the manufacturer's website.

### Optional Security Tools

Consider these additional security applications:

- **LuLu**: Free, open-source firewall (blocks outgoing connections)
  - Download: [Objective-See](https://objective-see.org/products/lulu.html)
  - Recommended settings: Block Apple processes, review all new connections

- **Mullvad VPN**: Privacy-focused VPN service
  - Website: [mullvad.net](https://mullvad.net/)
  - No account required, pay with cryptocurrency for maximum privacy

- **BlockBlock**: Monitors persistence locations (auto-start programs)
  - Already included in Brewfile
  - Download: [Objective-See](https://objective-see.org/products/blockblock.html)

---

## System Tweaks

### Finder Configuration

```bash
# Show hidden files
defaults write com.apple.finder AppleShowAllFiles TRUE

# Use list view by default
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

# Show path bar
defaults write com.apple.finder ShowPathbar -bool true

# Show status bar
defaults write com.apple.finder ShowStatusBar -bool true

# Restart Finder to apply changes
killall Finder
```

### Dock Configuration

```bash
# Remove dock indicators for open applications
defaults write com.apple.Dock show-process-indicators -bool false

# Don't show recent applications
defaults write com.apple.Dock show-recents -bool false

# Restart Dock
killall Dock
```

### Keyboard Shortcuts

Disable Mission Control shortcuts to free up Command+Arrow keys for terminal:

1. **System Settings** → **Keyboard** → **Keyboard Shortcuts** → **Mission Control**
2. Uncheck:
   - **Move left a space**
   - **Move right a space**

This allows you to use Command+Left/Right to jump words in iTerm2.

### Text Editing

Disable auto-correct and smart quotes:

1. **System Settings** → **Keyboard** → **Text**
2. Uncheck all options

### TextEdit Configuration

1. Open **TextEdit** → **Preferences**
2. **Format**: Plain text
3. **Font**: Inconsolata Nerd Font, 14pt
4. **Wrap**: 80 characters
5. Uncheck all auto-formatting options

---

## Additional Resources

### Security & Privacy Guides

- **drduh's macOS Security Guide**: Comprehensive security hardening guide
  - [GitHub Repository](https://github.com/drduh/macOS-Security-and-Privacy-Guide)

- **Objective-See**: Free macOS security tools
  - [Website](https://objective-see.org/)

### Dotfiles & Configuration

Consider managing your dotfiles with Git for easy synchronization across machines:

```bash
# Create a dotfiles repository
mkdir ~/dotfiles
cd ~/dotfiles
git init

# Add your configuration files
cp ~/.zshrc .
cp ~/.gitconfig .
cp ~/.vimrc .

# Create symlinks
ln -sf ~/dotfiles/.zshrc ~/.zshrc
ln -sf ~/dotfiles/.gitconfig ~/.gitconfig
```

### File Permissions

If you symlink `.gnupg` or `.ssh` from cloud storage (e.g., Dropbox), fix permissions:

```bash
# Fix .gnupg permissions
chown -R $(whoami) ~/.gnupg/
chmod 700 ~/.gnupg
chmod 600 ~/.gnupg/*

# Fix .ssh permissions
chmod 700 ~/.ssh
chmod 600 ~/.ssh/*
chmod 644 ~/.ssh/known_hosts
chmod 644 ~/.ssh/config
chmod 644 ~/.ssh/*.pub
```

### Node.js Version Management

Use `n` to manage Node.js versions:

```bash
# Already installed via Brewfile
# Set up directories
sudo mkdir -p /usr/local/n
sudo chown -R $(whoami) /usr/local/n
sudo chown -R $(whoami) /usr/local/bin /usr/local/lib /usr/local/include /usr/local/share

# Install LTS version
n lts

# Install specific version
n 18.17.0

# Switch versions
n
```

### Python Version Management

Use `pyenv` to manage Python versions:

```bash
# Already installed via Brewfile
# Install a Python version
pyenv install 3.11.5

# Set global version
pyenv global 3.11.5

# Set local version for a project
cd ~/my-project
pyenv local 3.11.5
```

---

## Quick Start Checklist

Use this checklist to ensure you've completed all essential setup steps:

- [ ] Enable FileVault encryption
- [ ] Enable Firewall (block all incoming)
- [ ] Set password requirement to "immediately"
- [ ] Configure DNS servers (Cloudflare)
- [ ] Block Apple telemetry domains
- [ ] Install Homebrew
- [ ] Run `brew bundle` to install all packages
- [ ] Run `./setup-fzf.sh` to configure fzf
- [ ] Configure zsh with Powerlevel10k
- [ ] Set up iTerm2 with Nerd Font
- [ ] Apply Finder tweaks (list view, show hidden files)
- [ ] Apply Dock tweaks (no indicators, no recents)
- [ ] Disable Mission Control keyboard shortcuts
- [ ] Install optional security tools (LuLu, Mullvad)
- [ ] Set up dotfiles repository
- [ ] Test Ctrl+R history search with fzf

---

## Troubleshooting

### Homebrew Permissions

If you encounter permission issues with Homebrew:

```bash
sudo chown -R $(whoami) /usr/local/bin /usr/local/lib /usr/local/share
chmod u+w /usr/local/bin /usr/local/lib /usr/local/share
```

### fzf Not Working

If Ctrl+R doesn't trigger fzf:

```bash
# Ensure fzf is sourced in your shell config
echo '[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh' >> ~/.zshrc
source ~/.zshrc
```

### Shell Plugins Not Loading

If zsh plugins aren't working:

```bash
# Verify plugin paths
ls $(brew --prefix)/share/zsh-autosuggestions
ls $(brew --prefix)/share/zsh-syntax-highlighting

# Ensure they're sourced in ~/.zshrc
grep "zsh-autosuggestions" ~/.zshrc
grep "zsh-syntax-highlighting" ~/.zshrc
```

---

## Maintenance

### Keep Everything Updated

```bash
# Update Homebrew and all packages
brew update && brew upgrade

# Cleanup old versions
brew cleanup

# Check for issues
brew doctor
```

### Backup Important Data

Regularly backup:
- `~/.ssh` (SSH keys)
- `~/.gnupg` (GPG keys)
- `~/dotfiles` (configuration files)
- FileVault recovery key

---

## Contributing

If you find issues or have suggestions for this setup guide, please open an issue or submit a pull request.

---

## License

This guide is provided as-is for educational and personal use. Individual applications and tools are subject to their own licenses.
