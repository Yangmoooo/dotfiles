PROXY_ADDR="http://127.0.0.1:7897"

alias lines="wc -l"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias rc-reload="source ~/.bashrc"

alias pipp="pip --proxy $PROXY_ADDR"
alias condac="conda activate"
alias pyserve="python -m http.server -d"

alias nv="nvim"
alias tldr="tealdeer"
alias lzg="lazygit"
alias ls="eza -l --group-directories-first"
alias la="eza -la --group-directories-first"
alias lt="eza -lT --group-directories-first"
alias lessj='function _lessjson() { cat "$1" | head -100 | fx; }; _lessjson'

px() {
    _px_on() {
        export http_proxy="$PROXY_ADDR"
        export https_proxy="$PROXY_ADDR"
        export HTTP_PROXY="$PROXY_ADDR"
        export HTTPS_PROXY="$PROXY_ADDR"
    }
    _px_off() {
        unset http_proxy https_proxy HTTP_PROXY HTTPS_PROXY
    }

    if [ $# -eq 0 ]; then
        if [ -n "$https_proxy" ]; then
            _px_off
            echo "🔌 全局代理已关闭"
        else
            _px_on
            echo "🚀 全局代理已开启 ($PROXY_ADDR)"
        fi
        return 0
    fi

    local proxy_was_already_on=0
    [ -n "$https_proxy" ] && proxy_was_already_on=1

    _px_cleanup() {
        if [ "$proxy_was_already_on" -eq 0 ]; then
            _px_off
        fi
    }
    trap _px_cleanup RETURN EXIT INT TERM

    if [ "$proxy_was_already_on" -eq 0 ]; then
        _px_on
    fi

    "$@"
}
