# Ignore duplicate lines
HISTCONTROL=ignoreboth

# Append to history, don't overwrite it
shopt -s histappend

# Set history size
HISTSIZE=1000
HISTFILESIZE=2000

PS1='\u \$ '

# ls aliases
alias ll='ls --color=auto -alF'
alias la='ls --color=auto -A'

# Color
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
