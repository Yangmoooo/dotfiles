# --- Basic ---
export EDITOR="nvim"

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
    alias la="eza -lA"
    alias lt="eza -lT"
else
    alias ll="ls -lGFh"
    alias la="ls -lAGFh"
fi

alias nv="nvim"
alias lzg="lazygit"
alias zshrc="nvim $HOME/.zshrc"
alias wget="wget --no-hsts"


# --- Prompt ---
setopt PROMPT_SUBST

autoload -Uz vcs_info
precmd() { vcs_info }
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git:*' formats ' (%b)'
zstyle ':vcs_info:git:*' actionformats ' (%b|%a)'

__px_flag() { [ -n "$HTTP_PROXY" ] && echo " [PROXY]" }
PROMPT='%F{magenta}%n%f@%F{blue}%m%f %F{cyan}%~%f%F{red}${vcs_info_msg_0_}%f$(__px_flag)
%# '


# --- Shell opt ---
ZSH_CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/zsh"
[ ! -d "$ZSH_CACHE_DIR" ] && mkdir -p "$ZSH_CACHE_DIR"
ZSH_COMPDUMP="$ZSH_CACHE_DIR/zcompdump"
autoload -Uz compinit && compinit -C -d "$ZSH_COMPDUMP"
zstyle ':completion:*' menu select
setopt completealiases

ZSH_STATE_DIR="${XDG_STATE_HOME:-$HOME/.local/state}/zsh"
[ ! -d "$ZSH_STATE_DIR" ] && mkdir -p "$ZSH_STATE_DIR"
HISTFILE="$ZSH_STATE_DIR/history"
HISTSIZE=50000
SAVEHIST=50000
setopt HIST_IGNORE_DUPS     # 忽略重复命令
setopt HIST_IGNORE_ALL_DUPS # 如果新命令和旧命令完全一样，则移除旧的
setopt HIST_FIND_NO_DUPS    # 搜索历史时不显示重复项
setopt APPEND_HISTORY       # 追加历史，而不是覆盖
setopt INC_APPEND_HISTORY   # 立即将命令写入历史文件
setopt SHARE_HISTORY        # 在所有打开的 shell 间共享历史

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh


# --- Rust ---
export RUSTUP_UPDATE_ROOT=https://mirrors.tuna.tsinghua.edu.cn/rustup/rustup
export RUSTUP_DIST_SERVER=https://mirrors.tuna.tsinghua.edu.cn/rustup

source "$HOME/.cargo/env"


# --- Python ---
# >>> mamba initialize >>>
# !! Contents within this block are managed by 'micromamba shell init' !!
export MAMBA_EXE='/usr/bin/micromamba';
export MAMBA_ROOT_PREFIX='/home/username/micromamba';
__mamba_setup="$("$MAMBA_EXE" shell hook --shell zsh --root-prefix "$MAMBA_ROOT_PREFIX" 2> /dev/null)"
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
eval "$(fnm env --use-on-cd --shell zsh)"


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
        return
    fi

    if [[ -n "$HTTP_PROXY" ]]; then
        "$@"
        return
    fi

    () {
        trap '__px_off' EXIT
        __px_on
        "$@"
    } "$@"
}

lessj() { head -100 "$1" | fx }


# --- Other ---
export GITHUB_TOKEN=""
export GOOGLE_CLOUD_PROJECT=""
export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --border --ansi"
export FZF_DEFAULT_COMMAND="fd --type file --color=always --strip-cwd-prefix --hidden --follow --exclude .git"

eval $(thefuck --alias fk)

