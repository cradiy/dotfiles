current_dir=$(pwd)

# Kitty
cp ./prettierrc.json ~/.prettierrc

for item in kitty nvim yazi zellij fish gitui; do
  config_dir="$HOME/.config/$item"
  dot_dir="$current_dir/$item"
  echo ""
  echo "$item..."
  if [[ -L $config_dir ]]; then
    unlink $config_dir
    ln -s $dot_dir $config_dir
    echo "$config_dir completed."
  elif [[ -d $config_dir ]]; then
    if [[ -z "$(ls -A $config_dir)" ]]; then
      rm -r $config_dir
      ln -s $dot_dir $config_dir
      echo "$config_dir completed."
    else
      echo "$config_dir exists. What would you like to do?"
      echo "1. Backup the original directory"
      echo "2. Delete the original directory"
      echo "3. Cancel the operation"

      read -p "Please choose 1, 2 or 3: " choice

      case $choice in
      1)
        backup_dir="${config_dir}_backup_$(date +%Y%m%d%H%M%S)"
        echo "Backing up the original directory to $backup_dir"
        mv $config_dir $backup_dir
        echo "Backup completed."
        ln -s $dot_dir $config_dir
        echo "$config_dir completed."
        ;;
      2)
        echo "Deleting the original directory $kitty_dir"
        rm -rf "$config_dir"
        echo "Delete completed."
        ln -s $dot_dir $config_dir
        echo "$config_dir completed."
        ;;
      3)
        # 取消操作
        echo "Operation cancelled."
        ;;
      *)
        # 处理无效输入
        echo "Invalid option, operation cancelled."
        ;;
      esac

    fi
  else
    ln -s $dot_dir $config_dir
    echo "$config_dir completed."
  fi
  echo ""
done

config_dir="$HOME/.config/zed"
mkdir -p $config_dir

if [[ -L $config_dir/settings.json ]]; then
  unlink $config_dir/settings.json
elif [[ -f $config_dir/settings.json ]]; then
  rm $config_dir/settings.json
fi
echo ""

ln -s $current_dir/zed/settings.json $config_dir/settings.json

echo "$config_dir/settings.json completed."

if [[ -L $config_dir/keymap.json ]]; then
  unlink $config_dir/keymap.json
elif [[ -f $config_dir/keymap.json ]]; then
  rm $config_dir/keymap.json
fi
echo ""
ln -s $current_dir/zed/keymap.json $config_dir/keymap.json

echo "$config_dir/keymap.json completed."
