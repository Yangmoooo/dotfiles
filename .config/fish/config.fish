if status is-interactive
    # Commands to run in interactive sessions can go here
end

set -gx PATH $HOME/.local/bin $PATH
set -gx EDITOR nvim
set -x RUSTUP_UPDATE_ROOT https://mirrors.tuna.tsinghua.edu.cn/rustup/rustup
set -x RUSTUP_DIST_SERVER https://mirrors.tuna.tsinghua.edu.cn/rustup

alias aptu="sudo apt update && sudo apt upgrade"
alias apts="apt search"
alias apti="sudo apt install"
alias aptr="sudo apt remove"
alias apta="sudo apt autoremove"
alias rcfish="nvim ~/.config/fish/config.fish"
alias cfmt="fd -e c -e h -e cpp -x clang-format -i --style=file:/mnt/d/Develop/Resources/clang.format"

abbr --add sd sudo
abbr --add nv nvim
abbr --add mu micro
abbr --add lzg lazygit
abbr --add ex exercism

zoxide init fish | source
