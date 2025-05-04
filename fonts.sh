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
