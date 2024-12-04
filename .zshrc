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
# autoload -Uz vcs_info
# zstyle ':vcs_info:*' enable git
# zstyle ':vcs_info:*' check-for-changes true
# zstyle ':vcs_info:*' unstagedstr "*"
# zstyle ':vcs_info:*' stagedstr "+"
# zstyle ':vcs_info:*' formats "%F{13}%b%f%F{11}%u%c%f"
# precmd() { vcs_info }
# setopt prompt_subst
# PROMPT='%F{9}%n%f@%F{9}%m%f %F{14}%~%f ${vcs_info_msg_0_}
# (%?) $ '

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
eval `keychain --eval --quiet ~/.ssh/id_ed25519_github`


# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
#ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
#plugins=(adb fd git thefuck systemd z zsh-interactive-cd)

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
