if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

export HISTFILESIZE=20000
export TERM=xterm-256color

# Command prompt
# VHS Wave '87: comment 7A86C8, path cyan 61E2FF, git branch lilac C08CF5, $ magenta E865F2
PS1='\[\e[38;2;122;134;200m\]\u@\h \[\e[38;2;97;226;255;1m\]\w \[\e[0;38;2;192;140;245m\]$(git branch 2>/dev/null | grep '"'"'*'"'"' | colrm 1 2) \[\e[38;2;232;101;242m\]\$\[\e[0m\] '
# Gruvbox
#PS1='\[\e[38;5;142m\]\u@\h \[\e[38;5;115;1m\]\w \[\e[0;38;5;142m\]$(git branch 2>/dev/null | grep '"'"'*'"'"' | colrm 1 2) \[\e[38;5;133m\]\$\[\e[0m\] '

# User aliases
alias ls='ls --color=auto'
alias ll='ls -lFh'
alias la='ls -lFAh --group-directories-first'
alias lt='ls -lFR'
alias ta='tmux attach-session'

# Activate autojump
[[ -s /home/gjalin/.autojump/etc/profile.d/autojump.sh  ]] && source /home/gjalin/.autojump/etc/profile.d/autojump.sh

# Extra environment variables definitions
export PATH=$PATH:$HOME/.local/bin
#export LD_LIBRARY_PATH=$HOME/.local/lib:$LD_LIBRARY_PATH

# Extra user functions
for file in ~/.bash.d/*.sh; do
    [ -r "$file" ] && source "$file"
done

