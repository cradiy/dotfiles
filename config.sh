#!/bin/bash

sudo dnf install fcitx5 fcitx5-chinese-addons fcitx5-gtk fcitx5-qt fcitx5-configtool fcitx5-rime

sudo dnf install neovim kitty fish fzf git cmake
sudo dnf copr enable lihaohong/yazi
sudo dnf install yazi zellij gitui bat
sudo dnf install clang shfmt hexyl
curl https://install.duckdb.org | sh
cp /usr/share/applications/org.fcitx.Fcitx5.desktop ~/.config/autostart/
sudo dnf remove ibus\*

# Yazi install plugins
ya pakc -i

# Check if Node.js is installed
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

npm install -g bash-language-server
npm install -g pnpm

# Prompt the user to input their email address
read -p "Enter your email address: " email

# Check if the email is provided
if [ -z "$email" ]; then
    echo "Email address is required."
    exit 1
fi

# Generate the SSH key using the provided email
ssh-keygen -t ed25519 -C "$email"

# Provide feedback
echo "SSH key generated with the email: $email"
ehco "id_ed25519.pub: "
cat ~/.ssh/id_ed25519.pub

read -p "Enter your git username: " username

if [ -z "$username" ]; then
    echo "Username is required."
    exit 1
fi

git config --global user.name $username

git config --global user.email $email

# Check the response
echo "Download dotfiles to ~/github/dotfiles"
mkdir -p ~/github
git clone https://github.com/cradiy/dotfiles.git ~/github/dotfiles
cd ~/github/dotfiles
bash run.sh
bash run-zed.sh
cd -
bash

export RUSTUP_DIST_SERVER="https://rsproxy.cn"
export RUSTUP_UPDATE_ROOT="https://rsproxy.cn/rustup"

curl --proto '=https' --tlsv1.2 -sSf https://rsproxy.cn/rustup-init.sh | sh

echo '[source.crates-io]
replace-with = "rsproxy-sparse"
[source.rsproxy]
registry = "https://rsproxy.cn/crates.io-index"
[source.rsproxy-sparse]
registry = "sparse+https://rsproxy.cn/index/"
[registries.rsproxy]
index = "https://rsproxy.cn/crates.io-index"
[net]
git-fetch-with-cli = true' >>~/.cargo/config.toml

. "$HOME/.cargo/env"

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
ehco "

set -x HTTP_PROXY http://127.0.0.1:7897
set -x HTTPS_PROXY http://127.0.0.1:7897
" >>~/.config/fish/private/proxy.fish

# Define the download URL and target directory
url="https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/JetBrainsMono.zip"
download_dir="$HOME/Downloads"

# Download the font zip file
echo "Downloading JetBrainsMono.zip..."
curl -L "$url" -o "$download_dir/JetBrainsMono.zip"

# Extract the zip file to the font directory
echo "Extracting JetBrainsMono.zip..."
unzip "$download_dir/JetBrainsMono.zip" -d "$download_dir/JetBrainsMono"

# Move the fonts to the local font directory
echo "Installing fonts..."
sudo mv "$download_dir/JetBrainsMono" /usr/share/fonts/

# Clean up the downloaded and extracted files
rm -rf "$download_dir/JetBrainsMono.zip"

# Refresh the font cache
echo "Refreshing font cache..."
sudo fc-cache -fv

# Confirm the installation
echo "JetBrainsMono font has been installed and font cache has been refreshed."
