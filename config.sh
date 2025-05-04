#!/bin/bash

# Yazi install plugins
ya pakc -i
#
# # Check if Node.js is installed
if command -v node >/dev/null 2>&1; then
    echo "Node.js is installed. Removing it..."
    # Remove Node.js using dnf
    sudo dnf remove nodejs -y
else
    echo "Node.js is not installed."
fi

# Install fnm (Fast Node Manager) if not installed
if ! command -v fnm >/dev/null 2>&1; then
    echo "Installing fnm..."
    curl -fsSL https://fnm.vercel.app/install | bash
    # Source fnm to make it available in the current session
    source ~/.bashrc
fi

# Use fnm to install the latest Node.js version
echo "Installing Node.js using fnm..."
fnm install --lts

# Verify Node.js installation
node -v
#

fish="fish"

# Check if the program exists
if command -v "$fish" >/dev/null 2>&1; then
    curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish
    omf install agnoster
else
    echo "$fish is not installed."
fi
bash

echo "
set -x PATH ~/.local/share/fnm \$PATH
fnm env --use-on-cd --shell fish | source
" >>~/.config/fish/private/dev.fish
