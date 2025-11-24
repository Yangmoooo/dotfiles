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
HISTFILE="$HOME/.local/state/bash/bash_history"
HISTSIZE=50000
HISTFILESIZE=50000
shopt -s histappend
PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

__sudo_toggle() {
    if [[ -z "$READLINE_LINE" ]]; then
        READLINE_LINE=$(fc -ln -1 2>/dev/null)
        READLINE_LINE=${READLINE_LINE#"${READLINE_LINE%%[![:space:]]*}"}
    fi

    if [[ "$READLINE_LINE" == "sudo "* ]]; then
        READLINE_LINE="${READLINE_LINE#sudo }"
    else
        READLINE_LINE="sudo $READLINE_LINE"
    fi
    READLINE_POINT=${#READLINE_LINE}
}
bind -x '"\e\e": __sudo_toggle'

source "$HOME/.config/shell/z.sh"
source "$HOME/.config/shell/git-prompt.sh"
source /usr/share/bash-completion/bash_completion


# --- prompt ---
export PS1='\
\[\e[35m\]\u\[\e[0m\]@\
\[\e[34m\]\h\[\e[0m\] \
\[\e[36m\]\w\[\e[0m\]\
\[\e[31m\]$(__git_ps1 " (%s)")\[\e[0m\]\
$(__proxy_flag)\
\n\
\[\e[32m\]\$\[\e[0m\] '


# --- rust ---
export RUSTUP_UPDATE_ROOT=https://mirrors.tuna.tsinghua.edu.cn/rustup/rustup
export RUSTUP_DIST_SERVER=https://mirrors.tuna.tsinghua.edu.cn/rustup

source "$HOME/.cargo/env"


# --- python ---
export PYTHON_HISTORY="$HOME/.local/state/python/python_history"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/user/miniforge3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
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
eval "$(fnm env --use-on-cd --shell bash)"


# --- functions ---
lessj() { head -100 "$1" | fx }


# --- other ---
eval $(thefuck --alias fk)

