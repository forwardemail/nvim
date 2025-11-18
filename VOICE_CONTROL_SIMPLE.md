# Voice Control for macOS (Simple Setup)

**No coding required. Just download apps and set hotkeys.**

## What You Get

- **Voice Input**: Press a hotkey, speak your command, AI processes it
- **Voice Output**: macOS speaks the AI response
- **100% Offline**: All processing happens locally (except Handy download)

## Quick Setup (5 minutes)

### Step 1: Install Handy (Voice Input)

1. **Download Handy**:
   - Visit: https://handyapp.ai/
   - Click "Download for Mac"
   - Open the DMG and drag Handy to Applications

2. **Configure Handy**:
   - Open Handy
   - Go to Settings
   - Set hotkey (recommended: `Cmd+Shift+Space`)
   - Choose Whisper model: `base` (good balance of speed/accuracy)
   - Enable "Auto-paste after transcription"

3. **Grant Permissions**:
   - System Settings → Privacy & Security → Microphone → Enable Handy
   - System Settings → Privacy & Security → Accessibility → Enable Handy

### Step 2: Test Voice Input

1. Open any text editor (TextEdit, Notes, etc.)
2. Press your Handy hotkey (`Cmd+Shift+Space`)
3. Say: "Hello world, this is a test"
4. Text should appear in the editor

✅ Voice input is working!

### Step 3: Use with Neovim + Avante

1. **Open Neovim**:
   ```bash
   nvim
   ```

   - Press `,aa` (comma then 'aa')
   - Avante sidebar opens on the right

3. **Use voice input**:
   - Click in Avante input field
   - Press Handy hotkey (`Cmd+Shift+Space`)
   - Say: "Open Chromium and navigate to example.com"
   - Press Enter

4. **Get voice output**:
   - Copy AI response
   - In terminal: `say "Paste response here"`
   - macOS speaks the response

## Example Workflows

### Workflow 1: Voice-Controlled Browser

**Say**: "Open Chromium and check the weather in San Francisco"

**What happens**:
1. Handy converts speech to text
2. Text goes to Avante
3. Ollama processes (local AI)
5. AI responds with weather info
6. macOS `say` speaks the response

### Workflow 2: Voice-Controlled Coding

**Say**: "Write a function to validate email addresses in JavaScript"

**What happens**:
1. Handy converts speech to text
2. Text goes to Avante (or Parrot)
3. Ollama generates code
4. Code appears in chat
5. You can insert it into your file

### Workflow 3: Voice-Controlled System

**Say**: "List all running applications"

**What happens**:
1. Handy converts speech to text
2. Text goes to Avante
4. Returns list of running apps
5. macOS `say` reads the list

## Hotkey Reference

| Hotkey | Action | Where |
|--------|--------|-------|
| `Cmd+Shift+Space` | Voice input | Anywhere (Handy) |
| `,aa` | Open AI chat | Neovim (Avante) |
| `:PrtChatToggle` | Open AI coding | Neovim (Parrot) |

## Voice Output Options

### Option 1: macOS Built-in TTS (Free)

```bash
# Basic usage
say "Hello world"

# Choose voice
say -v Samantha "Hello, I'm Samantha"
say -v Alex "Hello, I'm Alex"

# List all voices
say -v ?
```

### Option 2: Create a Quick Action (One-time setup)

1. Open **Automator**
2. Create new **Quick Action**
3. Add action: **Run Shell Script**
4. Paste this:
   ```bash
   say "$@"
   ```
5. Save as "Speak Text"
6. Now you can right-click any text → Services → Speak Text

### Option 3: Keyboard Shortcut for Selected Text

1. System Settings → Keyboard → Keyboard Shortcuts → Services
2. Find "Speak Text" (from Option 2)
3. Assign hotkey (e.g., `Cmd+Shift+S`)
4. Now: Select text → Press `Cmd+Shift+S` → macOS speaks it

## Advanced: Create a Voice Assistant Shortcut

### Using macOS Shortcuts App

1. Open **Shortcuts** app
2. Create new shortcut
3. Add these actions:
   - **Get Clipboard**
   - **Run Shell Script**: `echo "$1" | ollama run qwen2.5-coder:7b-instruct-q4_K_M`
   - **Speak Text**
4. Save as "Voice Assistant"
5. Assign keyboard shortcut in Shortcuts settings

**Usage**:
1. Press Handy hotkey → Speak command → Text copied to clipboard
2. Press Voice Assistant shortcut
3. AI processes and speaks response

## Troubleshooting

### Handy not working

- Check microphone permissions
- Check accessibility permissions
- Try restarting Handy
- Check hotkey isn't conflicting with other apps

### Voice output not working

```bash
# Test basic TTS
say "test"

# If no sound, check:
# - System Settings → Sound → Output
# - Volume is not muted
```


```bash

# Or press: ,mm

# Verify servers are running:
# - macos_automator (should be green)
# - playwright (should be green)
```

## Why No Wake Word?

Wake word detection (like "Hey Siri") requires:
- Constant microphone listening (privacy concern)
- Significant battery drain
- Complex setup with Python/Node.js
- Background process management

**Hotkey approach is better because**:
- ✅ No privacy concerns (mic only active when you press hotkey)
- ✅ No battery drain
- ✅ No background processes
- ✅ Simple setup (just install Handy)
- ✅ More reliable (no false activations)
- ✅ Works everywhere (not just in Neovim)

## Summary

**What you installed**:
- Handy (voice input)
- Ollama (local AI)

**What you can do**:
- Press hotkey → Speak → AI processes → System executes
- All offline, all private, all free

**No coding required!** 🎉
