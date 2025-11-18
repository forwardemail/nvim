
This guide will walk you through installing and configuring your complete voice-controlled AI system automation setup.

## Overview

You're installing a complete system that includes:
1. **Neovim** with modern plugins
2. **Parrot.nvim** for AI coding assistance (offline)
3. **Avante.nvim** for AI chat with system automation
6. **Voice Control** (speech-to-text and text-to-speech)

**Everything runs 100% offline** on your Mac for complete privacy.

---

## Prerequisites

### Required Software

1. **macOS** (M5 or any Apple Silicon/Intel Mac)
2. **Neovim 0.10.0+**
   ```bash
   brew install neovim
   nvim --version  # Should show 0.10.0 or higher
   ```

   ```bash
   brew install node
   node --version  # Should show 18.0.0 or higher
   ```

4. **Ollama** (for local AI)
   ```bash
   # Install Ollama
   brew install ollama

   # Start Ollama service
   brew services start ollama

   # Verify it's running
   curl http://localhost:11434/api/tags
   ```

5. **Git** (for version control)
   ```bash
   brew install git
   ```

### Recommended Software

1. **Nerd Font** (for icons in Neovim)
   ```bash
   brew tap homebrew/cask-fonts
   brew install font-hack-nerd-font

   # Then set your terminal to use "Hack Nerd Font"
   ```

2. **ripgrep** (for faster searching)
   ```bash
   brew install ripgrep
   ```

3. **fd** (for faster file finding)
   ```bash
   brew install fd
   ```

---

## Step 1: Install Neovim Configuration

### Backup Existing Config (if you have one)

```bash
# Backup your current Neovim config
mv ~/.config/nvim ~/.config/nvim.backup
mv ~/.local/share/nvim ~/.local/share/nvim.backup
mv ~/.local/state/nvim ~/.local/state/nvim.backup
mv ~/.cache/nvim ~/.cache/nvim.backup
```

### Install This Configuration

```bash
# Extract the zip file to ~/.config/nvim

# Or if you want to use git:
cd ~/.config
git clone https://github.com/forwardemail/nvim.git
```

### First Launch

```bash
# Launch Neovim (it will automatically install plugins)
nvim

# Wait for plugins to install (this may take 1-2 minutes)
# You'll see a Lazy.nvim window showing installation progress
```

**What happens on first launch:**
- Lazy.nvim installs all plugins
- Treesitter compiles language parsers
- LSP servers are configured (but not installed yet)

---

## Step 2: Install Ollama Models

Ollama provides the local AI that powers both Parrot.nvim and Avante.nvim.

### Install Default Model (Qwen2.5-Coder 32B)

```bash
# Pull the default model (~5GB)
ollama pull qwen2.5-coder:7b-instruct-q4_K_M

# Verify it's installed
ollama list
```

### Install Additional Models (Optional)

```bash
# Faster model for simple tasks
ollama pull yi-coder:9b

# Alternative powerful model
ollama pull deepseek-coder-v2:16b

# See OLLAMA_MODELS.md for full list of pre-configured models
```

### Test Ollama

```bash
# Test the model
ollama run qwen2.5-coder:7b-instruct-q4_K_M "Write a hello world in JavaScript"

# Should respond with code
```

---



### Install Playwright Browsers


```bash
# Install Chromium for Playwright
npx playwright install chromium

# Or install all browsers (Chrome, Firefox, Safari)
npx playwright install
```

This downloads the browsers that Playwright will control (~200MB for Chromium).


```bash


# Both should show help text without errors
```

### Grant macOS Permissions


1. **Accessibility Permission**:
   - System Settings → Privacy & Security → Accessibility
   - Add your terminal app (Terminal.app or iTerm.app)
   - Toggle it ON

2. **Automation Permission**:
   - System Settings → Privacy & Security → Automation
   - Allow your terminal to control other applications


---




```bash
```



```json
{
    "macos_automator": {
      "command": "npx",
      "env": {},
      "disabled": false
    },
    "playwright": {
      "command": "npx",
      "env": {},
      "disabled": false
    }
  }
}
```


```bash
# Launch Neovim
nvim

# Press: ,mm (leader key + ms)
# Should show both servers as "running"
```

---

## Step 5: Install Voice Control (Optional but Recommended)

### Install Handy (Speech-to-Text)

1. **Download Handy**:
   - Visit: https://handy.computer/
   - Or: https://github.com/cjpais/Handy/releases
   - Download latest `.dmg` for macOS

2. **Install**:
   - Open the `.dmg` file
   - Drag Handy to Applications folder
   - Open Handy from Applications

3. **Configure**:
   - Grant Microphone permission when prompted
   - Grant Accessibility permission when prompted
   - In Handy settings:
     - Set keyboard shortcut (e.g., `Cmd+Shift+Space`)
     - Choose Whisper model: `medium` (good balance)
     - Enable "Paste on completion"

4. **Test**:
   - Press your shortcut
   - Say "Hello world"
   - Text should appear in your active application

### Test macOS Text-to-Speech

```bash
# Test TTS
say "Hello, I am your AI assistant"

# List available voices
say -v ?

# Test specific voice
say -v Samantha "This is Samantha's voice"
```

**Recommended voices**:
- **Samantha** (female, natural)
- **Alex** (male, natural)
- **Ava** (premium, download from System Settings)

---

## Step 6: Test Everything

### Test 1: Parrot.nvim (AI Coding)

```bash
# Open Neovim
nvim test.js

# Start Parrot chat
:PrtChatToggle

# In the chat, type:
"Write a function to reverse a string in JavaScript"

# Should get AI response with code
```

### Test 2: Avante.nvim (AI Chat)

```bash
# In Neovim, press:
\aa  # (leader + aa)

# Should open Avante sidebar

# In the chat, type:

```


```bash
# In Avante chat, type:
"Open Chromium"

# (if you have Chromium installed)

# Or try:
```

### Test 4: Voice Control

```bash
# Open Neovim
nvim

# Start Avante chat (\aa)

# Click in the Avante input field

# Press your Handy shortcut (e.g., Cmd+Shift+Space)

# Say: "What is the weather like today"

# Text should appear in Avante

# Press Enter to send

# AI will respond (you can manually speak the response with `say`)
```

---

## Step 7: Customize (Optional)

### Change Default Ollama Model

Edit `~/.config/nvim/lua/plugins/avante.lua`:

```lua
openai = {
  endpoint = "http://localhost:11434/v1",
  model = "yi-coder:9b", -- Change to any installed model
  ...
},
```



```json
{
    "macos_automator": { ... },
    "playwright": { ... },
    "your_custom_server": {
      "command": "node",
      "args": ["/path/to/your/server.js"],
      "env": {},
      "disabled": false
    }
  }
}
```

### Customize Keybindings

Edit `~/.config/nvim/lua/config/keymaps.lua`:

```lua
-- Add your custom keybindings here
vim.keymap.set("n", "<leader>aa", "<cmd>AvanteToggle<cr>", { desc = "Toggle Avante" })
```

---

## Troubleshooting

### Neovim Won't Start

```bash
# Check Neovim version
nvim --version  # Must be 0.10.0+

# Check for errors
nvim --headless +checkhealth +qa

# Reset and reinstall
rm -rf ~/.local/share/nvim ~/.local/state/nvim ~/.cache/nvim
nvim  # Will reinstall plugins
```

### Ollama Not Working

```bash
# Check if Ollama is running
curl http://localhost:11434/api/tags

# If not running, start it
brew services start ollama

# Check logs
brew services info ollama
```


```bash
# Check Node.js version
node --version  # Must be 18+


# Press: \ml (leader + ml)
```

### Handy Not Working

1. **Check permissions**:
   - System Settings → Privacy & Security → Microphone → Enable for Handy
   - System Settings → Privacy & Security → Accessibility → Enable for Handy

2. **Restart Handy**:
   - Quit Handy completely
   - Reopen from Applications

3. **Check microphone**:
   ```bash
   # Test system audio
   say "Testing microphone"
   ```

### Avante Not Connecting to Ollama

```bash
# Check Ollama is running
curl http://localhost:11434/api/tags

# Check Avante config
nvim ~/.config/nvim/lua/plugins/avante.lua

# Make sure endpoint is: http://localhost:11434/v1
```

---

## Next Steps

### Learn the Basics

1. **Read the Quick Start**:
   ```bash
   nvim ~/.config/nvim/QUICKSTART.md
   ```

2. **Learn Keybindings**:
   ```bash
   nvim ~/.config/nvim/KEYBINDINGS.md
   ```

3. **Explore Plugins**:
   ```bash
   nvim ~/.config/nvim/PLUGINS.md
   ```

### Set Up Your Workflow

1. **Configure Linters** (if you use XO, ESLint, etc.):
   - See `LINTER_CONFIG_FILES.md`

2. **Set Up Ollama Models**:
   - See `OLLAMA_SETUP.md` and `OLLAMA_MODELS.md`


4. **Set Up Voice Control**:
   - See `VOICE_CONTROL.md`

### Try Advanced Features

1. **Voice-controlled system automation**:
   - Say: "Open Chromium and check the weather in San Francisco"

2. **AI-powered coding**:
   - Use Parrot.nvim for code completion, explanations, bug fixes

3. **Browser automation**:

---

## Getting Help

### Documentation

All documentation is in `~/.config/nvim/`:
- `README.md` - Overview
- `QUICKSTART.md` - 5-minute guide
- `TROUBLESHOOTING.md` - Common issues
- `VOICE_CONTROL.md` - Voice control guide
- `OLLAMA_SETUP.md` - Ollama guide

### Check Health

```bash
# In Neovim, run:
:checkhealth

# Check specific plugins:
:checkhealth lazy
:checkhealth lsp
:checkhealth treesitter
```

### Community

- **GitHub**: https://github.com/forwardemail/nvim
- **Issues**: https://github.com/forwardemail/nvim/issues

---

## Summary

You now have a complete voice-controlled AI system automation setup:

✅ **Neovim** with modern plugins
✅ **Parrot.nvim** for AI coding (offline)
✅ **Avante.nvim** for AI chat
✅ **Voice Control** (Handy + macOS TTS)

**Everything runs 100% offline** on your Mac.

**Example workflow**:
1. Press Handy shortcut
2. Say: "Open Chromium and check the weather in San Francisco"
3. Handy converts to text
4. Avante processes with Ollama
6. macOS `say` speaks the response

Enjoy your new AI-powered development environment! 🚀
