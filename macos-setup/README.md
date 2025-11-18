# macOS Development Environment Setup

A comprehensive, security-focused macOS setup with modern development tools, privacy enhancements, and productivity boosters.

## 🚀 Quick Start

```bash
# 1. Install Homebrew (if not already installed)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# 2. Install all packages from Brewfile
brew bundle --file=Brewfile

# 3. Set up fzf with Ctrl+R history search
./setup-fzf.sh

# 4. Follow the complete guide
open MACOS_SETUP_GUIDE.md
```

## 📦 What's Included

### Brewfile
A comprehensive package list including:
- **90+ command-line tools**: bat, eza, fd, fzf, ripgrep, zoxide, git, gh, lazygit
- **Programming languages**: Node.js, Python, Go, PHP, Java
- **Security tools**: pass, gnupg, browserpass, pinentry-mac
- **Databases**: Redis, MongoDB
- **AI tools**: Ollama (local LLM server)
- **40+ GUI applications**: iTerm2, Ungoogled Chromium, Signal, UTM, SQLiteStudio
- **6 Nerd Fonts**: For beautiful terminal customization

### Setup Scripts
- **setup-fzf.sh**: Automated fzf installation and configuration with Ctrl+R demo

### Documentation
- **MACOS_SETUP_GUIDE.md**: Complete setup guide with:
  - Security & privacy configuration
  - fzf usage and Ctrl+R demo
  - Shell customization
  - System tweaks
  - Troubleshooting

## 🔐 Security Features

This setup includes privacy-focused configurations:

- ✅ FileVault encryption (keeps it ON, unlike some guides)
- ✅ Firewall with blocked incoming connections
- ✅ Apple telemetry blocking
- ✅ Privacy-focused DNS (Cloudflare)
- ✅ Cloudflare time server
- ✅ GPG/SSH key management
- ✅ Password manager (pass + browserpass)
- ❌ **Does NOT disable Gatekeeper** (maintains security)

Based on recommendations from:
- [drduh's macOS Security Guide](https://github.com/drduh/macOS-Security-and-Privacy-Guide)
- [titanism's Security Hardened Setup](https://gist.github.com/titanism/af6c9da77d5dcbce9313e583588bac2b) (with modifications)

## ⌨️ fzf Ctrl+R Demo

The most powerful productivity feature in this setup is **fzf's Ctrl+R** for command history search.

### Before (Traditional Bash History)
```bash
# Press Ctrl+R, type search term
# See only ONE match, must cycle through with repeated Ctrl+R
(reverse-i-search)`git': git commit -m "Update README"
```

### After (fzf Enhanced)
```bash
# Press Ctrl+R
> git
  50/1247
> git commit -m "Fix bug in authentication"
  git push origin main
  git pull --rebase
  git status
  git log --oneline
  git checkout -b feature/new-feature
```

**Features**:
- 🔍 **Fuzzy matching**: Type `gcm` finds `git commit -m`
- 📊 **Multi-line preview**: See full commands with context
- ⚡ **Real-time filtering**: Results update as you type
- ⌨️ **Arrow keys**: Navigate through matches
- 🎯 **Exact match**: Prefix with `'` (e.g., `'git commit`)
- 🚫 **Exclude**: Prefix with `!` (e.g., `!test`)

## 📱 Recommended Applications

### Available via Homebrew (Already in Brewfile)

| App | Description | Command |
|-----|-------------|---------|
| Crystal Fetch | Windows 11 ISO creator | `brew install --cask crystalfetch` |
| Gifski | High-quality GIF converter | `brew install --cask gifski` |
| OpenRCT2 | RollerCoaster Tycoon 2 | `brew install --cask openrct2` |
| Raspberry Pi Imager | Bootable Pi media | `brew install --cask raspberry-pi-imager` |
| Unetbootin | Bootable USB creator | `brew install --cask unetbootin` |
| UTM | Virtual machines | `brew install --cask utm` |
| SQLiteStudio | SQLite browser | `brew install --cask sqlitestudio` |

### Manual Installation Required

| App | Description | Link |
|-----|-------------|------|
| **SquirrelDisk** | Fast disk usage analyzer | [GitHub](https://github.com/adileo/squirreldisk) |
| **swiftGuard** | USB port security monitor | [GitHub](https://github.com/Lennolium/swiftGuard) |
| **Display Pilot 2** | Display management | Commercial app |

## 🎨 System Tweaks

The setup guide includes these macOS customizations:

```bash
# Finder: List view by default
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

# Finder: Show hidden files
defaults write com.apple.finder AppleShowAllFiles TRUE

# Dock: No app indicators
defaults write com.apple.Dock show-process-indicators -bool false

# Dock: No recent apps
defaults write com.apple.Dock show-recents -bool false
```

## 📚 Files in This Package

```
macos-setup/
├── README.md                  # This file
├── MACOS_SETUP_GUIDE.md      # Complete setup guide
├── Brewfile                   # All packages to install
└── setup-fzf.sh              # fzf setup script
```

## 🔧 Installation Steps

### 1. Security Configuration (15 minutes)

Follow the **Security & Privacy Configuration** section in `MACOS_SETUP_GUIDE.md`:
- Enable FileVault
- Enable Firewall
- Block Apple telemetry
- Configure DNS

### 2. Package Installation (30-60 minutes)

```bash
# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install all packages
brew bundle --file=Brewfile
```

### 3. Shell Setup (10 minutes)

```bash
# Set up fzf
./setup-fzf.sh

# Configure Powerlevel10k
p10k configure

# Add shell enhancements to ~/.zshrc (see guide)
```

### 4. Application Configuration (30 minutes)

- Configure iTerm2 (theme, font, colors)
- Set up GPG/SSH keys
- Configure browser extensions (uBlock Origin, Vimium, Browserpass)
- Apply system tweaks

## 🎯 Quick Start Checklist

- [ ] Enable FileVault encryption
- [ ] Enable Firewall
- [ ] Block Apple telemetry
- [ ] Install Homebrew
- [ ] Run `brew bundle`
- [ ] Run `./setup-fzf.sh`
- [ ] Configure Powerlevel10k
- [ ] Set up iTerm2
- [ ] Apply Finder/Dock tweaks
- [ ] Test Ctrl+R with fzf

## 🆘 Troubleshooting

See the **Troubleshooting** section in `MACOS_SETUP_GUIDE.md` for solutions to common issues.

## 🔄 Maintenance

```bash
# Update everything
brew update && brew upgrade && brew cleanup

# Check for issues
brew doctor
```

## 📖 Additional Resources

- [drduh/macOS-Security-and-Privacy-Guide](https://github.com/drduh/macOS-Security-and-Privacy-Guide)
- [fzf GitHub Repository](https://github.com/junegunn/fzf)
- [Powerlevel10k](https://github.com/romkatv/powerlevel10k)
- [Homebrew Documentation](https://docs.brew.sh/)

## 📝 Notes

- **FileVault**: This setup keeps FileVault **enabled** for security (unlike some guides that disable it)
- **Gatekeeper**: This setup does **not** disable Gatekeeper (maintains macOS security)
- **Privacy**: Blocks Apple telemetry while maintaining system functionality
- **Optional**: All security hardening steps are optional and can be customized

## 🤝 Contributing

Suggestions and improvements welcome! This is a living document that evolves with macOS updates and new tools.

## 📄 License

This setup guide is provided as-is for educational and personal use.
