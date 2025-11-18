#!/bin/bash
# Run this after installation to verify everything is set up correctly

set -e

echo "========================================"
echo ""

# Color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Check functions
check_command() {
    if command -v "$1" &> /dev/null; then
        echo -e "${GREEN}✓${NC} $1 is installed"
        return 0
    else
        echo -e "${RED}✗${NC} $1 is NOT installed"
        return 1
    fi
}

check_file() {
    if [ -f "$1" ]; then
        echo -e "${GREEN}✓${NC} $1 exists"
        return 0
    else
        echo -e "${RED}✗${NC} $1 NOT found"
        return 1
    fi
}

check_dir() {
    if [ -d "$1" ]; then
        echo -e "${GREEN}✓${NC} $1 exists"
        return 0
    else
        echo -e "${RED}✗${NC} $1 NOT found"
        return 1
    fi
}

# Track failures
FAILURES=0

# 1. Check required commands
echo "1. Checking Required Commands"
echo "------------------------------"
check_command nvim || ((FAILURES++))
check_command node || ((FAILURES++))
check_command npx || ((FAILURES++))
check_command ollama || ((FAILURES++))
echo ""

# 2. Check Neovim version
echo "2. Checking Neovim Version"
echo "--------------------------"
NVIM_VERSION=$(nvim --version | head -n1 | grep -oE '[0-9]+\.[0-9]+\.[0-9]+')
echo "Neovim version: $NVIM_VERSION"
if [[ $(echo "$NVIM_VERSION" | cut -d. -f1) -ge 0 ]] && [[ $(echo "$NVIM_VERSION" | cut -d. -f2) -ge 10 ]]; then
    echo -e "${GREEN}✓${NC} Version is 0.10.0 or higher"
else
    echo -e "${RED}✗${NC} Version is too old (need 0.10.0+)"
    ((FAILURES++))
fi
echo ""

# 3. Check Node.js version
echo "3. Checking Node.js Version"
echo "---------------------------"
NODE_VERSION=$(node --version | sed 's/v//' | cut -d. -f1)
echo "Node.js version: $(node --version)"
if [[ $NODE_VERSION -ge 18 ]]; then
    echo -e "${GREEN}✓${NC} Version is 18 or higher (major: $NODE_VERSION)"
else
    echo -e "${RED}✗${NC} Version is too old (need 18+, found: $NODE_VERSION)"
    ((FAILURES++))
fi
echo ""

# 4. Check configuration files
echo "4. Checking Configuration Files"
echo "--------------------------------"
check_file ~/.config/nvim/init.lua || ((FAILURES++))
check_file ~/.config/nvim/lua/plugins/avante.lua || ((FAILURES++))
check_file ~/.config/nvim/lua/plugins/parrot.lua || ((FAILURES++))
echo ""

# 5. Check critical configuration settings
echo "5. Checking Critical Settings"
echo "------------------------------"

else
    ((FAILURES++))
fi

# Check auto_approve
    echo -e "${GREEN}✓${NC} Auto-approve enabled"
else
    echo -e "${YELLOW}⚠${NC} Auto-approve not enabled (you'll get confirmation dialogs)"
fi

# Check disabled_tools
if grep -q "disabled_tools = {" ~/.config/nvim/lua/plugins/avante.lua; then
    echo -e "${GREEN}✓${NC} Avante disabled_tools configured"
else
    echo -e "${RED}✗${NC} Avante disabled_tools NOT configured"
    ((FAILURES++))
fi

# Check custom_tools
if grep -q "custom_tools = function()" ~/.config/nvim/lua/plugins/avante.lua; then
    echo -e "${GREEN}✓${NC} Avante custom_tools configured"
else
    echo -e "${RED}✗${NC} Avante custom_tools NOT configured"
    ((FAILURES++))
fi
echo ""

# 6. Check Ollama
echo "6. Checking Ollama"
echo "------------------"
if curl -s http://localhost:11434/api/tags > /dev/null 2>&1; then
    echo -e "${GREEN}✓${NC} Ollama is running"

    # Check for required model
    if curl -s http://localhost:11434/api/tags | grep -q "qwen2.5-coder:7b-instruct-q4_K_M"; then
        echo -e "${GREEN}✓${NC} Required model is installed"
    else
        echo -e "${RED}✗${NC} Required model NOT installed"
        echo "   Run: ollama pull qwen2.5-coder:7b-instruct-q4_K_M"
        ((FAILURES++))
    fi
else
    echo -e "${RED}✗${NC} Ollama is NOT running"
    echo "   Run: ollama serve"
    ((FAILURES++))
fi
echo ""

echo "-----------------------"
        echo -e "${GREEN}✓${NC} macos_automator server configured"
    else
        echo -e "${RED}✗${NC} macos_automator server NOT configured"
        ((FAILURES++))
    fi

        echo -e "${GREEN}✓${NC} playwright server configured"
    else
        echo -e "${RED}✗${NC} playwright server NOT configured"
        ((FAILURES++))
    fi
fi
echo ""

# 8. Check Playwright browsers
echo "8. Checking Playwright Browsers"
echo "--------------------------------"
if npx playwright --version > /dev/null 2>&1; then
    echo -e "${GREEN}✓${NC} Playwright is installed"

    # Check for Chromium (use compgen to expand glob patterns)
    CHROMIUM_FOUND=false
    if compgen -G "$HOME/Library/Caches/ms-playwright/chromium*" > /dev/null 2>&1 || \
       compgen -G "$HOME/.cache/ms-playwright/chromium*" > /dev/null 2>&1; then
        CHROMIUM_FOUND=true
    fi

    if [ "$CHROMIUM_FOUND" = true ]; then
        echo -e "${GREEN}✓${NC} Chromium browser installed"
    else
        echo -e "${YELLOW}⚠${NC} Chromium browser may not be installed"
        echo "   Run: npx playwright install chromium"
    fi
else
    echo -e "${RED}✗${NC} Playwright NOT installed"
    ((FAILURES++))
fi
echo ""

# Summary
echo "========================================"
echo "Summary"
echo "========================================"
if [ $FAILURES -eq 0 ]; then
    echo -e "${GREEN}✓ All checks passed!${NC}"
    echo ""
    echo "Next steps:"
    echo "1. Open Neovim: nvim"
    echo "3. Test Avante: ,aa"
    echo "4. Try: 'Open the Calculator app'"
    echo ""
    exit 0
else
    echo -e "${RED}✗ $FAILURES check(s) failed${NC}"
    echo ""
    echo "Please fix the issues above before testing."
    echo "See INSTALLATION_GUIDE.md for detailed setup instructions."
    exit 1
fi
