export PATH=$HOME/.local/bin:$PATH
export EDITOR="nvim"
export ZSH=$HOME/.zsh
export ZSH_COMPDUMP=$ZSH/.zcompdump-$HOST
export HISTFILE=$ZSH/.zsh_history
export HISTSIZE=10000
export SAVEHIST=10000
export _Z_DATA=$HOME/.local/share/z/.z
export NNN_OPTS="dH"
export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --border --ansi"
export FZF_DEFAULT_COMMAND="fd --type file --color=always --strip-cwd-prefix --hidden --follow --exclude .git"
export MICRO_TRUECOLOR=1
export RUSTUP_UPDATE_ROOT=https://mirrors.tuna.tsinghua.edu.cn/rustup/rustup
export RUSTUP_DIST_SERVER=https://mirrors.tuna.tsinghua.edu.cn/rustup
export CONDA_CHANGEPS1=false
export CRYPTOGRAPHY_OPENSSL_NO_LEGACY=1

autoload -Uz compinit && compinit -d "$ZSH_COMPDUMP"
zstyle ':completion:*' menu select
setopt completealiases

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

alias sc-status="systemctl status"
alias sc-enable="systemctl enable"
alias sc-disable="systemctl disable"
alias sc-start="systemctl start"
alias sc-stop="systemctl stop"
alias sc-restart="systemctl restart"
alias sc-isolate="systemctl isolate"

alias rczsh="nvim $HOME/.zshrc"
alias icat="kitten icat"
alias ll="lsd -l"
alias la="lsd -a"
alias lla="lsd -la"
alias lt="lsd --tree"
alias nv="nvim"
alias mu="micro"
alias hx="helix"
alias ncdu="ncdu --color dark"
alias tldr="tldr -L en"
alias lzg="lazygit"
alias lzd="sudo lazydocker"
alias wget="wget --no-hsts"
alias cfmt="clang-format -i --style=file:$HOME/.config/clangd/clang.format"
alias redroid="scrcpy -s localhost:5555 --audio-codec=aac"
alias caesium="Caesium_Image_Compressor-x86_64_v2.6.0_ubu20_qt66.AppImage &"

# zsh 插件
source $HOME/.zsh/functions.zsh
[[ -r /usr/share/z/z.sh ]] && source /usr/share/z/z.sh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-you-should-use/you-should-use.plugin.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh

# rust python nodejs 环境
source $HOME/.cargo/env
[ -f /opt/miniconda3/etc/profile.d/conda.sh ] && source /opt/miniconda3/etc/profile.d/conda.sh
conda activate panic
source /usr/share/nvm/init-nvm.sh
# 终端工具
eval "$(thefuck --alias fk)"
# Check that the function `starship_zle-keymap-select()` is defined.
# xref: https://github.com/starship/starship/issues/3418
type starship_zle-keymap-select >/dev/null || eval "$(starship init zsh)"
