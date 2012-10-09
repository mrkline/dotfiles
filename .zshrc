# The following lines were added by compinstall
zstyle ':completion:*' completer _expand _complete _ignored
zstyle ':completion:*' list-colors ''
zstyle :compinstall filename '/home/mrkline/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
# Ignore duplicate lines
HISTCONTROL=ignoreboth
setopt appendhistory nomatch
unsetopt autocd beep extendedglob notify
# Use vim bindings
bindkey -v

PS1='%n $ '

# ls aliases
alias ll='ls --color=auto -alF'
alias la='ls --color=auto -A'

# Color
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
