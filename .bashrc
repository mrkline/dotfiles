# Ignore duplicate lines
HISTCONTROL=ignoreboth

# Append to history, don't overwrite it
shopt -s histappend

# Set history size
HISTSIZE=1000
HISTFILESIZE=2000

PS1='${debian_chroot:+($debian_chroot)}\u $ '

# ls aliases
alias ll='ls -alF'
alias la='ls -A'

# Color
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
