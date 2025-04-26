set -g fish_greeting
for file in ~/.config/fish/private/*.fish
    if test -f $file
        source $file
    end
end
source ~/.config/fish/alias.fish
source ~/.config/fish/common.fish
source ~/.config/fish/functions/*.fish
zoxide init fish | source
