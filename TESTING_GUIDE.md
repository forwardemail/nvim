# Testing Guide: Voice-Controlled AI System

This guide provides step-by-step tests to verify your complete voice-controlled AI system automation setup.

## Prerequisites

Before testing, ensure you have:
- ✅ Neovim installed with all plugins
- ✅ Ollama running with at least one model
- ✅ Handy installed (for voice input)
- ✅ macOS permissions granted (Accessibility, Automation)

---

## Test 1: Verify Ollama

### Test 1.1: Check Ollama Service

```bash
# Check if Ollama is running
curl http://localhost:11434/api/tags

# Expected output: JSON with list of installed models
# Should include "qwen2.5-coder:7b-instruct-q4_K_M" or other models
```

**If it fails**:
```bash
# Start Ollama
brew services start ollama

# Or run manually
ollama serve
```

### Test 1.2: Test Model Directly

```bash
# Test the model
ollama run qwen2.5-coder:7b-instruct-q4_K_M "Write a hello world in JavaScript"

# Expected output: JavaScript code like:
# console.log("Hello, World!");
```

**Result**: ✅ Ollama is working

---

## Test 2: Verify Neovim Plugins

### Test 2.1: Check Plugin Installation

```bash
# Open Neovim
nvim

# In Neovim, run:
:Lazy

# Expected: Lazy.nvim UI showing all plugins installed
# Look for:
# - parrot.nvim
# - avante.nvim
# All should show green checkmarks
```

### Test 2.2: Check Parrot.nvim

```bash
# In Neovim, run:
:PrtChatToggle

# Expected: Parrot chat window opens
# Type: "Write a function to add two numbers"
# Press Enter
# Expected: AI responds with JavaScript code
```

### Test 2.3: Check Avante.nvim

```bash
# In Neovim, press:
\aa  # (leader + aa, default leader is \)

# Expected: Avante sidebar opens on the right
# Type: "Hello, are you working?"
# Press Enter
# Expected: AI responds
```

**Result**: ✅ Neovim plugins are working

---



```bash

# Expected: Help text showing available commands


# Expected: Help text showing available commands
```


```bash
# Open Neovim
nvim

# Press: ,mm (leader + ms)
# Should show:
# - macos_automator (status: running)
# - playwright (status: running)
```


```bash
# In Neovim, press: ,mm (leader + mt)
# Should show tools from both servers:
# - execute_script (from macos-automator)
# - navigate (from playwright)
# - click (from playwright)
# - etc.
```


---

## Test 4: Verify Voice Input (Handy)

### Test 4.1: Check Handy Installation

```bash
# Check if Handy is installed
ls -la /Applications/Handy.app

# Expected: Directory exists
```

### Test 4.2: Test Handy

1. Open any text editor (TextEdit, Notes, etc.)
2. Press your Handy shortcut (e.g., `Cmd+Shift+Space`)
3. Say: "Hello world, this is a test"
4. Expected: Text appears in the editor

**If it fails**:
- Check Handy is running (should see icon in menu bar)
- Check permissions: System Settings → Privacy & Security → Microphone → Handy
- Check permissions: System Settings → Privacy & Security → Accessibility → Handy

**Result**: ✅ Handy is working

---

## Test 5: Verify Voice Output (macOS TTS)

### Test 5.1: Test Basic TTS

```bash
# Test default voice
say "Hello, I am your AI assistant"

# Expected: You hear the text spoken
```

### Test 5.2: Test Different Voices

```bash
# List available voices
say -v ?

# Test Samantha (female)
say -v Samantha "This is Samantha's voice"

# Test Alex (male)
say -v Alex "This is Alex's voice"

# Expected: You hear different voices
```

**Result**: ✅ macOS TTS is working

---

## Test 6: Integration Tests

### Test 6.1: Parrot.nvim + Ollama

**Goal**: Verify AI coding assistance works

```bash
# Open Neovim
nvim test.js

# Start Parrot chat
:PrtChatToggle

# In chat, type:
"Write a function to reverse a string in JavaScript"

# Press Enter

# Expected:
# - AI responds with code
# - Code is syntactically correct
# - Response appears in chat window
```

**Result**: ✅ Parrot.nvim + Ollama integration working

### Test 6.2: Avante.nvim + Ollama

**Goal**: Verify AI chat works

```bash
# In Neovim, press: \aa

# In Avante chat, type:
"Explain what is a closure in JavaScript"

# Press Enter

# Expected:
# - AI responds with explanation
# - Response appears in Avante sidebar
```

**Result**: ✅ Avante.nvim + Ollama integration working



```bash
# In Neovim, press: \aa

# In Avante chat, type:

# Press Enter

# Expected:
# - AI responds with list of tools
# - Should mention tools from macos-automator and playwright
```


### Test 6.4: Voice Input + Avante

**Goal**: Verify voice input works with Avante

```bash
# Open Neovim
nvim

# Press: \aa (open Avante)

# Click in Avante input field

# Press Handy shortcut (e.g., Cmd+Shift+Space)

# Say: "What is the weather like today"

# Expected:
# - Handy converts speech to text
# - Text appears in Avante input field

# Press Enter

# Expected:
```

**Result**: ✅ Voice input + Avante integration working

### Test 6.5: Complete Voice Workflow

**Goal**: Verify complete voice-controlled workflow

```bash
# Open Neovim
nvim

# Press: \aa (open Avante)

# Click in Avante input field

# Press Handy shortcut

# Say: "Tell me a fun fact about JavaScript"

# Expected:
# - Handy converts to text
# - Text appears in Avante
# - Press Enter
# - AI responds with a fun fact

# Copy the AI response

# In terminal, run:
say "Paste the AI response here"

# Expected:
# - macOS speaks the AI response
```

**Result**: ✅ Complete voice workflow working

---

## Test 7: System Automation Tests

### Test 7.1: Test macOS Automation


```bash
# In Neovim, press: \aa

# In Avante chat, type:
"Use AppleScript to tell me what applications are currently running"

# Press Enter

# Expected:
# - Returns list of running applications
```

**Note**: This test requires macOS permissions:
- System Settings → Privacy & Security → Automation
- Allow Terminal/iTerm to control other applications

### Test 7.2: Test Browser Automation (if Chromium installed)


```bash
# In Neovim, press: \aa

# In Avante chat, type:
"Open a browser and navigate to example.com"

# Press Enter

# Expected:
# - Browser opens (Chromium/Chrome/Firefox)
# - Navigates to example.com
```

**Note**: This test requires:
- A browser installed (Chromium, Chrome, Firefox, etc.)
- First run may download Playwright browser binaries

---

## Test 8: Voice Assistant Script

### Test 8.1: Test Voice Assistant Script

```bash
# Navigate to config directory
cd ~/.config/nvim

# Run voice assistant in one-shot mode
./voice-assistant.sh "What is 2 plus 2?"

# Expected:
# - Script processes with Ollama
# - AI responds: "4" (or explanation)
# - macOS speaks the response
```

### Test 8.2: Test Interactive Mode

```bash
# Run in interactive mode
./voice-assistant.sh

# At prompt, type:
"Tell me a joke"

# Press Enter

# Expected:
# - AI responds with a joke
# - macOS speaks the joke

# Type: exit
# Expected: Script exits
```

**Result**: ✅ Voice assistant script working

---

## Test 9: End-to-End Voice Control

### Test 9.1: Complete Voice-Controlled System Automation

**Goal**: Test the complete workflow from voice input to system action to voice output

**Scenario**: Check the weather via voice

1. **Open Neovim**:
   ```bash
   nvim
   ```

2. **Open Avante**:
   - Press `\aa`

3. **Use voice input**:
   - Click in Avante input field
   - Press Handy shortcut (e.g., `Cmd+Shift+Space`)
   - Say: "What can you help me with?"
   - Handy converts to text

4. **Send to AI**:
   - Press Enter
   - AI processes via Ollama
   - AI responds with capabilities

5. **Voice output**:
   - Copy AI response
   - In terminal: `say "Paste response here"`
   - macOS speaks the response

**Expected**:
- ✅ Voice input works (Handy)
- ✅ AI processing works (Avante + Ollama)
- ✅ Voice output works (macOS TTS)

**Result**: ✅ End-to-end voice control working

---

## Troubleshooting Failed Tests

### Ollama Tests Failing

```bash
# Check Ollama service
brew services list | grep ollama

# Restart Ollama
brew services restart ollama

# Check logs
tail -f ~/Library/Logs/Homebrew/ollama/ollama.log
```

### Neovim Plugin Tests Failing

```bash
# Reset Neovim
rm -rf ~/.local/share/nvim ~/.local/state/nvim ~/.cache/nvim

# Reopen Neovim (will reinstall plugins)
nvim

# Check health
:checkhealth
```


```bash
# Check Node.js version
node --version  # Must be 18+


# Press: \ml
```

### Handy Tests Failing

1. **Check permissions**:
   - System Settings → Privacy & Security → Microphone → Handy
   - System Settings → Privacy & Security → Accessibility → Handy

2. **Restart Handy**:
   - Quit Handy completely
   - Reopen from Applications

3. **Check microphone**:
   ```bash
   # Test system microphone
   say "Testing microphone"
   ```

### Voice Output Tests Failing

```bash
# Check audio output
say "Testing audio"

# Check volume
# Make sure system volume is not muted

# List voices
say -v ?
```

---

## Success Criteria

All tests should pass:

- ✅ Test 1: Ollama working
- ✅ Test 2: Neovim plugins working
- ✅ Test 4: Voice input (Handy) working
- ✅ Test 5: Voice output (TTS) working
- ✅ Test 6: Integration tests passing
- ✅ Test 7: System automation working
- ✅ Test 8: Voice assistant script working
- ✅ Test 9: End-to-end voice control working

**If all tests pass**: 🎉 Your voice-controlled AI system is fully functional!

**If any tests fail**: See troubleshooting section above or check:
- `TROUBLESHOOTING.md`
- `VOICE_CONTROL.md`
- `OLLAMA_SETUP.md`

---

## Next Steps

Once all tests pass:

1. **Learn the workflow**:
   - Practice using voice input with Handy
   - Experiment with different AI commands
   - Try system automation tasks

2. **Customize**:
   - Change Ollama models (see `OLLAMA_MODELS.md`)
   - Customize keybindings (see `KEYBINDINGS.md`)

3. **Explore advanced features**:
   - AI-powered coding with Parrot.nvim

Enjoy your voice-controlled AI system! 🚀
