# --- Alias ---
export EDITOR="nvim"

PROXY_ADDR="http://127.0.0.1:7897"

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias lines="wc -l"

if command -v eza &> /dev/null; then
    alias eza="eza --group-directories-first"
    alias ls="eza"
    alias ll="eza -l"
    alias la="eza -lA"
    alias lt="eza -lT"
else
    alias ll="ls -lGFh"
    alias la="ls -lAGFh"
fi

alias nv="nvim"
alias lzg="lazygit"
alias lessj='function _lessjson() { cat "$1" | head -100 | fx; }; _lessjson'


# --- Prompt ---
__px_flag() { [ -n "$HTTP_PROXY" ] && echo " [PROXY]" }

export PS1='\
\[\e[35m\]\u\[\e[0m\]@\
\[\e[34m\]\h\[\e[0m\] \
\[\e[36m\]\w\[\e[0m\]\
\[\e[31m\]$(__git_ps1 " (%s)")\[\e[0m\]\
$(__proxy_indicator)\
\n\
\[\e[32m\]\$\[\e[0m\] '


# --- Shell opt ---
HISTSIZE=50000
HISTFILESIZE=50000
shopt -s histappend
PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"


# --- Rust ---
export RUSTUP_UPDATE_ROOT=https://mirrors.tuna.tsinghua.edu.cn/rustup/rustup
export RUSTUP_DIST_SERVER=https://mirrors.tuna.tsinghua.edu.cn/rustup

source "$HOME/.cargo/env"


# --- Python ---
# >>> mamba initialize >>>
# !! Contents within this block are managed by 'micromamba shell init' !!
export MAMBA_EXE='/usr/bin/micromamba';
export MAMBA_ROOT_PREFIX='/home/username/micromamba';
__mamba_setup="$("$MAMBA_EXE" shell hook --shell bash --root-prefix "$MAMBA_ROOT_PREFIX" 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__mamba_setup"
else
    alias micromamba="$MAMBA_EXE"  # Fallback on help from micromamba activate
fi
unset __mamba_setup
# <<< mamba initialize <<<

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
}
__px_off() { unset HTTP_PROXY HTTPS_PROXY ALL_PROXY }

px() {
    if [ $# -eq 0 ]; then
        if [ -n "$HTTP_PROXY" ]; then
            __px_off && echo "PROXY off"
        else
            __px_on && echo "PROXY on, at $PROXY_ADDR"
        fi
        return 0
    fi

    local proxy_was_off=1
    [ -n "$HTTP_PROXY" ] && proxy_was_off=0

    if (( proxy_was_off )); then
        trap __px_off RETURN EXIT INT TERM
        _px_on
    fi

    "$@"
}


# --- Other ---
export GITHUB_TOKEN=""
export GOOGLE_CLOUD_PROJECT=""
export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --border --ansi"
export FZF_DEFAULT_COMMAND="fd --type file --color=always --strip-cwd-prefix --hidden --follow --exclude .git"

BASH_CONF_DIR="$HOME/.config/bash"
if [ -d "$BASH_CONF_DIR" ]; then
    for conf in "$BASH_CONF_DIR"/*.sh; do
        [ -f "$conf" ] && . "$conf"
    done
fi
source /usr/share/bash-completion/bash_completion

eval $(thefuck --alias fk)

