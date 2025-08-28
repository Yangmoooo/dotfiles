# --- alias ---

PROXY_ADDR="http://127.0.0.1:7897"

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

alias lines="wc -l"

alias pipp="pip --proxy $PROXY_ADDR"
alias condac="conda activate"
alias pyserve="python -m http.server -d"

if command -v eza &> /dev/null; then
    alias ls="eza --group-directories-first"
    alias ll="eza -l --group-directories-first"
    alias la="eza -lA --group-directories-first"
    alias lt="eza -lT --group-directories-first"
else
    alias ll="ls -lGFh"
    alias la="ls -lAGFh"
fi

alias s="doas"
alias nv="nvim"
alias lzg="lazygit"
alias lessj='function _lessjson() { cat "$1" | head -100 | fx; }; _lessjson'

# --- set prompt ---

__proxy_indicator() {
    [ -n "$HTTP_PROXY" ] && echo " [PROXY]"
}

export PS1='\
\[\e[35m\]\u\[\e[0m\]@\
\[\e[34m\]\h\[\e[0m\] \
\[\e[36m\]\w\[\e[0m\]\
\[\e[31m\]$(__git_ps1 " (%s)")\[\e[0m\]\
$(__proxy_indicator)\
\n\
\[\e[32m\]\$\[\e[0m\] '

# --- shell opt ---

# enhance history
HISTSIZE=500000
HISTFILESIZE=500000
shopt -s histappend
PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

# --- functions ---

px() {
    _px_on() {
        export HTTP_PROXY="$PROXY_ADDR"
        export HTTPS_PROXY="$PROXY_ADDR"
        export ALL_PROXY="$PROXY_ADDR"
    }
    _px_off() {
        unset HTTP_PROXY HTTPS_PROXY ALL_PROXY
    }

    if [ $# -eq 0 ]; then
        if [ -n "$HTTP_PROXY" ]; then
            _px_off
            echo "PROXY off"
        else
            _px_on
            echo "PROXY on, at $PROXY_ADDR"
        fi
        return 0
    fi

    local proxy_was_already_on=0
    [ -n "$HTTP_PROXY" ] && proxy_was_already_on=1

    _px_cleanup() {
        [ "$proxy_was_already_on" -eq 0 ] && _px_off
    }
    trap _px_cleanup RETURN EXIT INT TERM

    [ "$proxy_was_already_on" -eq 0 ] && _px_on

    "$@"
}

# --- other ---

export SUDO=doas

eval $(thefuck --alias fk)

BASH_CONF_DIR="$HOME/.config/bash"

if [ -d "$BASH_CONF_DIR" ]; then
    for conf in "$BASH_CONF_DIR"/*.sh; do
        [ -f "$conf" ] && . "$conf"
    done
fi
