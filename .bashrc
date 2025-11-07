# --- Basic ---
[ -f "$HOME/.profile" ] && source "$HOME/.profile"

export VISUAL="nvim"
export EDITOR="$VISUAL"

export GITHUB_TOKEN=""
export GOOGLE_CLOUD_PROJECT=""

export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --border --ansi"
export FZF_DEFAULT_COMMAND="fd --type file --color=always --strip-cwd-prefix --hidden --follow --exclude .git"
export _Z_DATA="$HOME/.local/state/z/zdata"

PROXY_ADDR="http://127.0.0.1:7897"


# --- Alias ---
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias lines="wc -l"

alias sc-status="systemctl status"
alias sc-enable="systemctl enable"
alias sc-disable="systemctl disable"
alias sc-start="systemctl start"
alias sc-stop="systemctl stop"
alias sc-restart="systemctl restart"
alias sc-isolate="systemctl isolate"

if command -v eza &> /dev/null; then
    alias eza="eza --group-directories-first"
    alias ls="eza"
    alias ll="eza -l"
    alias la="eza -la"
    alias lt="eza -lT -L 5"
    alias lta="eza -lTa -L 5 -I .git"
else
    alias ll="ls -lGFh"
    alias la="ls -lAGFh"
fi

alias nv="nvim"
alias lzg="lazygit"
alias wget="wget --no-hsts"


# --- Prompt ---
__px_flag() { [ -n "$HTTP_PROXY" ] && echo " [PROXY]" }

export PS1='\
\[\e[35m\]\u\[\e[0m\]@\
\[\e[34m\]\h\[\e[0m\] \
\[\e[36m\]\w\[\e[0m\]\
\[\e[31m\]$(__git_ps1 " (%s)")\[\e[0m\]\
$(__proxy_flag)\
\n\
\[\e[32m\]\$\[\e[0m\] '


# --- Shell opt ---
HISTSIZE=50000
HISTFILESIZE=50000
shopt -s histappend
PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

__prepend_sudo() {
    if [[ "$READLINE_LINE" != "sudo "* ]]; then
        READLINE_LINE="sudo $READLINE_LINE"
    fi
    READLINE_POINT=${#READLINE_LINE}
}
bind -x '"\e\e": __prepend_sudo'

BASH_CONF_DIR="$HOME/.config/bash"
if [ -d "$BASH_CONF_DIR" ]; then
    for conf in "$BASH_CONF_DIR"/*.sh; do
        [ -f "$conf" ] && . "$conf"
    done
fi
source /usr/share/bash-completion/bash_completion


# --- Rust ---
export RUSTUP_UPDATE_ROOT=https://mirrors.tuna.tsinghua.edu.cn/rustup/rustup
export RUSTUP_DIST_SERVER=https://mirrors.tuna.tsinghua.edu.cn/rustup

source "$HOME/.cargo/env"


# --- Python ---
# >>> mamba initialize >>>
# !! Contents within this block are managed by 'micromamba shell init' !!
export MAMBA_EXE='/usr/bin/micromamba';
export MAMBA_ROOT_PREFIX='/home/user/micromamba';
__mamba_setup="$("$MAMBA_EXE" shell hook --shell bash --root-prefix "$MAMBA_ROOT_PREFIX" 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__mamba_setup"
else
    alias micromamba="$MAMBA_EXE"  # Fallback on help from micromamba activate
fi
unset __mamba_setup
# <<< mamba initialize <<<

alias condac="conda activate"
alias condad="conda deactivate"
alias mm="micromamba"
alias pipp="pip --proxy $PROXY_ADDR"
alias pyserver="python -m http.server -d"


# --- Nodejs ---
eval "$(fnm env --use-on-cd --shell bash)"


# --- Functions ---
__px_on() {
    export HTTP_PROXY="$PROXY_ADDR"
    export HTTPS_PROXY="$PROXY_ADDR"
    export ALL_PROXY="$PROXY_ADDR"
    export http_proxy="$PROXY_ADDR"
    export https_proxy="$PROXY_ADDR"
    export all_proxy="$PROXY_ADDR"
}
__px_off() { unset HTTP_PROXY HTTPS_PROXY ALL_PROXY http_proxy https_proxy all_proxy }

px() {
    if [ -z "$PROXY_ADDR" ]; then
        echo "ERROR: env var PROXY_ADDR not set yet" >&2
        return 1
    fi

    if [ $# -eq 0 ]; then
        if [ -n "$HTTP_PROXY" ]; then
            __px_off && echo "PROXY off"
        else
            __px_on && echo "PROXY on, at $PROXY_ADDR"
        fi
        return
    fi

    if [[ -n "$HTTP_PROXY" ]]; then
        "$@"
        return
    fi

    (
        trap '__px_off' EXIT
        __px_on
        "$@"
    )
}

lessj() { head -100 "$1" | fx }


# --- Other ---
eval $(thefuck --alias fk)

