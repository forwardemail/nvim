#!/bin/bash
# fzf Setup Script for macOS
# This script installs and configures fzf with Ctrl+R history search

set -e

echo "======================================"
echo "fzf Setup for macOS"
echo "======================================"
echo ""

# Check if fzf is installed
if ! command -v fzf &> /dev/null; then
    echo "❌ fzf is not installed"
    echo "Installing fzf via Homebrew..."
    brew install fzf
else
    echo "✓ fzf is already installed"
fi

# Install fzf key bindings and fuzzy completion
echo ""
echo "Installing fzf key bindings and fuzzy completion..."

# Determine shell configuration file
if [ -n "$ZSH_VERSION" ]; then
    SHELL_RC="$HOME/.zshrc"
    SHELL_NAME="zsh"
elif [ -n "$BASH_VERSION" ]; then
    SHELL_RC="$HOME/.bashrc"
    SHELL_NAME="bash"
else
    echo "⚠ Unknown shell. Please configure manually."
    exit 1
fi

echo "Detected shell: $SHELL_NAME"
echo "Configuration file: $SHELL_RC"

# Run fzf install script
if [ -f "$(brew --prefix)/opt/fzf/install" ]; then
    echo ""
    echo "Running fzf install script..."
    "$(brew --prefix)/opt/fzf/install" --key-bindings --completion --no-update-rc

    # Add fzf configuration to shell RC if not already present
    if ! grep -q "fzf" "$SHELL_RC" 2>/dev/null; then
        echo "" >> "$SHELL_RC"
        echo "# fzf configuration" >> "$SHELL_RC"
        echo "[ -f ~/.fzf.$SHELL_NAME ] && source ~/.fzf.$SHELL_NAME" >> "$SHELL_RC"
        echo "✓ Added fzf configuration to $SHELL_RC"
    else
        echo "✓ fzf configuration already exists in $SHELL_RC"
    fi
else
    echo "❌ fzf install script not found"
    exit 1
fi

# Add custom fzf options
if ! grep -q "FZF_DEFAULT_OPTS" "$SHELL_RC" 2>/dev/null; then
    cat >> "$SHELL_RC" << 'EOF'

# fzf options
export FZF_DEFAULT_OPTS='
  --height 40%
  --layout=reverse
  --border
  --inline-info
  --color=fg:#d0d0d0,bg:#121212,hl:#5f87af
  --color=fg+:#d0d0d0,bg+:#262626,hl+:#5fd7ff
  --color=info:#afaf87,prompt:#d7005f,pointer:#af5fff
  --color=marker:#87ff00,spinner:#af5fff,header:#87afaf'

# Use fd instead of find if available
if command -v fd &> /dev/null; then
  export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
fi
EOF
    echo "✓ Added custom fzf options to $SHELL_RC"
else
    echo "✓ Custom fzf options already configured"
fi

echo ""
echo "======================================"
echo "✓ fzf setup complete!"
echo "======================================"
echo ""
echo "Key bindings enabled:"
echo "  • Ctrl+R - Search command history"
echo "  • Ctrl+T - Search files"
echo "  • Alt+C  - Change directory"
echo ""
echo "To apply changes, run:"
echo "  source $SHELL_RC"
echo ""
echo "Or restart your terminal."
