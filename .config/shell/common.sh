export LANG="en_US.UTF-8"
export PATH="$HOME/bin:$HOME/.local/bin:$PATH"
export VISUAL="vim"
export EDITOR="$VISUAL"

export GTK_IM_MODULE=fcitx5
export QT_IM_MODULE=fcitx5
export XMODIFIERS=@im=fcitx5

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

alias ll="ls -lGFh"
alias la="ls -lAGFh"
alias lines="wc -l"

alias sc-status="systemctl status"
alias sc-enable="systemctl enable"
alias sc-disable="systemctl disable"
alias sc-start="systemctl start"
alias sc-stop="systemctl stop"
alias sc-restart="systemctl restart"
alias sc-isolate="systemctl isolate"

stty -ixon  # 禁用终端的流控功能，避免与 tmux 的 ctrl+s prefix 混淆

PROXY_ADDR="http://127.0.0.1:7897"
__px_flag() { [ -n "$HTTP_PROXY" ] && echo " [PROXY]" }
__px_off() { unset HTTP_PROXY HTTPS_PROXY ALL_PROXY http_proxy https_proxy all_proxy }
__px_on() {
    export HTTP_PROXY="$PROXY_ADDR"
    export HTTPS_PROXY="$PROXY_ADDR"
    export ALL_PROXY="$PROXY_ADDR"
    export http_proxy="$PROXY_ADDR"
    export https_proxy="$PROXY_ADDR"
    export all_proxy="$PROXY_ADDR"
}
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

shconfig() {
    local sh_name rc_file

    if [ -n "$ZSH_VERSION" ]; then
        sh_name="zsh"
        rc_file="$HOME/.zshrc"
    elif [ -n "$BASH_VERSION" ]; then
        sh_name="bash"
        rc_file="$HOME/.bashrc"
    else
        echo "Error: Unsupported shell. Only bash and zsh are supported."
        return 1
    fi

    ${EDITOR:-vim} "$rc_file"

    if [ $? -ne 0 ]; then
        echo "${sh_name}config: Edit cancelled."
        return 1
    fi
    if ! "$sh_name" -n "$rc_file"; then
        echo "${sh_name}config: Reload cancelled due to syntax error."
        return 1
    fi

    echo "${sh_name}config: Reloading..."
    if [ "$sh_name" = "bash" ]; then
        history -a
    elif [ "$sh_name" = "zsh" ]; then
        fc -W
    fi
    exec "$sh_name"
}
