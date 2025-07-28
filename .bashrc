# 设置 history 文件大小
HISTSIZE=500000
HISTFILESIZE=500000
# 实时更新 history，而不是在 shell 退出时才写入
shopt -s histappend
PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

if [ -f ~/.bash_env ]; then
    . ~/.bash_env
fi

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

if [ -f ~/.bash_script ]; then
    . ~/.bash_script
fi
