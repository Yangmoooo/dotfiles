if status is-interactive
    # Commands to run in interactive sessions can go here
end

set -U fish_greeting
fish_add_path --move ~/.local/bin

set -gx EDITOR nvim
set -x NNN_OPTS dH
set -x FZF_DEFAULT_OPTS "--height 40% --layout=reverse --border --ansi"
set -x FZF_DEFAULT_COMMAND "fd --type file --color=always --strip-cwd-prefix --hidden --follow --exclude .git"
set -x RUSTUP_UPDATE_ROOT https://mirrors.tuna.tsinghua.edu.cn/rustup/rustup
set -x RUSTUP_DIST_SERVER https://mirrors.tuna.tsinghua.edu.cn/rustup

alias aptu="sudo apt update && sudo apt upgrade"
alias apts="apt search"
alias apti="sudo apt install"
alias aptr="sudo apt remove"
alias apta="sudo apt autoremove"

alias rcfish="nvim ~/.config/fish/config.fish"
alias wget="wget --no-hsts"
alias cfmt="clang-format -i --style=file:/mnt/d/Develop/Resources/clang.format"

abbr --add nv nvim
abbr --add mu micro
abbr --add lzg lazygit

zoxide init fish | source
