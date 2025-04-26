
function x 
    set -l current_dir (pwd)
    if test (count $argv) -ge 1
        set current_dir $argv[1]
    end

    set -l selected (find $current_dir -type d 2>/dev/null | fzf)

    if test -n "$selected"
        cd "$selected"
    end
end
