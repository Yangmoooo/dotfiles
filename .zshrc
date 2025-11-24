# --- basic ---
[ -f "$HOME/.config/shell/common.sh" ] && source "$HOME/.config/shell/common.sh"

export VISUAL="nvim"
export EDITOR="$VISUAL"

export LESSHISTFILE="$HOME/.local/state/lesshst"
export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --border --ansi"
export FZF_DEFAULT_COMMAND="fd --type file --color=always --strip-cwd-prefix --hidden --follow --exclude .git"
export _Z_DATA="$HOME/.local/state/z/zdata"


# --- alias ---
alias eza="eza --group-directories-first"
alias ls="eza"
alias ll="eza -l"
alias la="eza -la"
alias lt="eza -lT -L 5"
alias lta="eza -lTa -L 5 -I .git"
alias nv="nvim"
alias lzg="lazygit"
alias wget="wget --no-hsts"


# --- shell opt ---
ZSH_CACHE_DIR="$HOME/.cache/zsh"
[ ! -d "$ZSH_CACHE_DIR" ] && mkdir -p "$ZSH_CACHE_DIR"
ZSH_COMPDUMP="$ZSH_CACHE_DIR/zcompdump"
autoload -Uz compinit && compinit -C -d "$ZSH_COMPDUMP"
zstyle ':completion:*' menu select
setopt completealiases

ZSH_STATE_DIR="$HOME/.local/state/zsh"
[ ! -d "$ZSH_STATE_DIR" ] && mkdir -p "$ZSH_STATE_DIR"
HISTFILE="$ZSH_STATE_DIR/zsh_history"
HISTSIZE=50000
SAVEHIST=50000
setopt hist_ignore_dups     # 忽略重复命令
setopt hist_ignore_all_dups # 如果新命令和旧命令完全一样，则移除旧的
setopt hist_find_no_dups    # 搜索历史时不显示重复项
setopt append_history       # 追加历史，而不是覆盖
setopt inc_append_history   # 立即将命令写入历史文件
setopt share_history        # 在所有打开的 shell 间共享历史

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

source "$HOME/.config/shell/z.sh"
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh

__sudo_toggle() {
    [[ -z $BUFFER ]] && zle up-history
    if [[ "$BUFFER" == "sudo "* ]]; then
        BUFFER="${BUFFER#sudo }"
    else
        BUFFER="sudo $BUFFER"
    fi
    zle end-of-line
}
zle -N __sudo_toggle
bindkey -M emacs '\e\e' __sudo_toggle
bindkey -M viins '\e\e' __sudo_toggle
bindkey -M vicmd '\e\e' __sudo_toggle


# --- prompt ---
setopt prompt_subst
autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
zstyle ':vcs_info:git:*' formats ' %F{yellow}%b'
PROMPT='%F{magenta}%n%f@%F{blue}%m%f %F{cyan}%~%f${vcs_info_msg_0_}%f$(__px_flag)
%# '


# --- Rust ---
export RUSTUP_UPDATE_ROOT=https://mirrors.tuna.tsinghua.edu.cn/rustup/rustup
export RUSTUP_DIST_SERVER=https://mirrors.tuna.tsinghua.edu.cn/rustup

source "$HOME/.cargo/env"


# --- python ---
export PYTHON_HISTORY="$HOME/.local/state/python/python_history"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/user/miniforge3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/user/miniforge3/etc/profile.d/conda.sh" ]; then
        . "/home/user/miniforge3/etc/profile.d/conda.sh"
    else
        export PATH="/home/user/miniforge3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

alias condac="conda activate"
alias condad="conda deactivate"
alias pipp="pip --proxy $PROXY_ADDR"
alias pyserver="python -m http.server -d"


# --- nodejs ---
eval "$(fnm env --use-on-cd --shell zsh)"


# --- func ---
lessj() { head -100 "$1" | fx }


# --- other ---
eval $(thefuck --alias fk)

