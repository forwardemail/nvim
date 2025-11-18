#!/bin/bash
# Voice-controlled AI Assistant
# Integrates speech-to-text (Handy/macOS dictation) + Ollama + macOS TTS
#
# Usage:
#   ./voice-assistant.sh                    # Interactive mode
#   ./voice-assistant.sh "your command"     # One-shot mode
#   ./voice-assistant.sh --help             # Show help

set -e

# Configuration
OLLAMA_URL="${OLLAMA_URL:-http://localhost:11434/api/generate}"
MODEL="${OLLAMA_MODEL:-qwen2.5-coder:32b}"
VOICE="${TTS_VOICE:-Samantha}"
TEMP_DIR="${TEMP_DIR:-/tmp/voice-assistant}"
RESPONSE_FILE="$TEMP_DIR/response.txt"
AUDIO_FILE="$TEMP_DIR/response.aiff"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Create temp directory
mkdir -p "$TEMP_DIR"

# Function to print colored output
print_info() {
    echo -e "${BLUE}ℹ${NC} $1"
}

print_success() {
    echo -e "${GREEN}✓${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}⚠${NC} $1"
}

print_error() {
    echo -e "${RED}✗${NC} $1"
}

# Function to check dependencies
check_dependencies() {
    local missing=()

    # Check Ollama
    if ! curl -s "$OLLAMA_URL" &>/dev/null; then
        missing+=("Ollama (not running at $OLLAMA_URL)")
    fi

    # Check say command (built-in on macOS)
    if ! command -v say &>/dev/null; then
        missing+=("macOS 'say' command (TTS)")
    fi

    # Check jq for JSON parsing
    if ! command -v jq &>/dev/null; then
        print_warning "jq not found, installing..."
        brew install jq || missing+=("jq (for JSON parsing)")
    fi

    if [ ${#missing[@]} -gt 0 ]; then
        print_error "Missing dependencies:"
        for dep in "${missing[@]}"; do
            echo "  - $dep"
        done
        exit 1
    fi
}

# Function to send prompt to Ollama
ask_ollama() {
    local prompt="$1"
    local stream="${2:-false}"

    print_info "Processing with AI..."

    # Create JSON payload
    local json_payload=$(jq -n \
        --arg model "$MODEL" \
        --arg prompt "$prompt" \
        --argjson stream "$stream" \
        '{model: $model, prompt: $prompt, stream: $stream}')

    # Call Ollama API
    local response=$(curl -s -X POST "$OLLAMA_URL" \
        -H "Content-Type: application/json" \
        -d "$json_payload")

    # Extract response text
    local ai_response=$(echo "$response" | jq -r '.response // empty')

    if [ -z "$ai_response" ]; then
        print_error "No response from Ollama. Is the model loaded?"
        echo "Try: ollama run $MODEL"
        return 1
    fi

    echo "$ai_response"
}

# Function to speak response
speak() {
    local text="$1"
    local save_audio="${2:-false}"

    print_info "Speaking response..."

    if [ "$save_audio" = "true" ]; then
        # Save to audio file
        say -v "$VOICE" -o "$AUDIO_FILE" "$text"
        print_success "Audio saved to: $AUDIO_FILE"
    else
        # Speak directly
        say -v "$VOICE" "$text"
    fi
}

# Function to process command
process_command() {
    local user_input="$1"

    if [ -z "$user_input" ]; then
        print_warning "No input provided"
        return 1
    fi

    echo ""
    print_info "You: $user_input"
    echo ""

    # Get AI response
    local ai_response=$(ask_ollama "$user_input")

    if [ $? -ne 0 ]; then
        return 1
    fi

    # Save response to file
    echo "$ai_response" > "$RESPONSE_FILE"

    # Display response
    echo ""
    print_success "AI Response:"
    echo "$ai_response"
    echo ""

    # Speak response
    speak "$ai_response"

    print_success "Done!"
}

# Function to show help
show_help() {
    cat << EOF
Voice-controlled AI Assistant

Usage:
  $0                    Interactive mode (continuous)
  $0 "your command"     One-shot mode (single command)
  $0 --help             Show this help

Configuration (environment variables):
  OLLAMA_URL            Ollama API endpoint (default: http://localhost:11434/api/generate)
  OLLAMA_MODEL          Ollama model to use (default: qwen2.5-coder:32b)
  TTS_VOICE             macOS voice for TTS (default: Samantha)
  TEMP_DIR              Temporary directory (default: /tmp/voice-assistant)

Examples:
  # Interactive mode
  $0

  # One-shot command
  $0 "What is the weather like today?"

  # Use different model
  OLLAMA_MODEL="yi-coder:9b" $0

  # Use different voice
  TTS_VOICE="Alex" $0 "Hello world"

Available macOS voices:
  $(say -v ? | head -5)
  ... (run 'say -v ?' for full list)

Integration with Handy (Speech-to-Text):
  1. Install Handy from https://handy.computer/
  2. Configure keyboard shortcut (e.g., Cmd+Shift+Space)
  3. Press shortcut, speak your command
  4. Handy converts to text
  5. Paste into terminal or Neovim

Integration with Neovim + Avante:
  1. Open Neovim
  2. Press <leader>aa to open Avante
  3. Use Handy to speak your command
  4. Text appears in Avante input
  5. Press Enter to send to AI

For more information, see:
  - VOICE_CONTROL.md
  - OLLAMA_SETUP.md
EOF
}

# Main function
main() {
    # Check for help flag
    if [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
        show_help
        exit 0
    fi

    # Check dependencies
    check_dependencies

    print_success "Voice-controlled AI Assistant"
    print_info "Using model: $MODEL"
    print_info "Using voice: $VOICE"
    echo ""

    # One-shot mode
    if [ $# -gt 0 ]; then
        process_command "$*"
        exit 0
    fi

    # Interactive mode
    print_info "Interactive mode (press Ctrl+C to exit)"
    print_warning "Tip: Use Handy (Cmd+Shift+Space) to speak instead of typing"
    echo ""

    while true; do
        echo -n "You: "
        read -r user_input

        if [ -z "$user_input" ]; then
            continue
        fi

        # Exit commands
        if [ "$user_input" = "exit" ] || [ "$user_input" = "quit" ]; then
            print_success "Goodbye!"
            break
        fi

        # Process command
        process_command "$user_input"
        echo ""
    done
}

# Run main function
main "$@"
