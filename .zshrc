# Completion options from oh-my-zsh:
unsetopt menu_complete
setopt auto_menu
setopt complete_in_word
setopt always_to_end

# Fire up completion
autoload -U compinit
compinit

# History options from oh-my-zsh:
if [ -z $HISTFILE ]; then
    HISTFILE=$HOME/.zsh_history
fi
HISTSIZE=10000
SAVEHIST=10000

setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_dups # ignore duplication command history list
setopt hist_ignore_space
setopt hist_verify
setopt inc_append_history
setopt share_history # share command history data

# Key bindings from the Arch wiki:

# create a zkbd compatible hash;
# to add other keys to this hash, see: man 5 terminfo
typeset -A key

key[Home]=${terminfo[khome]}

key[End]=${terminfo[kend]}
key[Insert]=${terminfo[kich1]}
key[Delete]=${terminfo[kdch1]}
key[Up]=${terminfo[kcuu1]}
key[Down]=${terminfo[kcud1]}
key[Left]=${terminfo[kcub1]}
key[Right]=${terminfo[kcuf1]}
key[PageUp]=${terminfo[kpp]}
key[PageDown]=${terminfo[knp]}

# setup key accordingly
[[ -n "${key[Home]}"     ]]  && bindkey  "${key[Home]}"     beginning-of-line
[[ -n "${key[End]}"      ]]  && bindkey  "${key[End]}"      end-of-line
[[ -n "${key[Insert]}"   ]]  && bindkey  "${key[Insert]}"   overwrite-mode
[[ -n "${key[Delete]}"   ]]  && bindkey  "${key[Delete]}"   delete-char
[[ -n "${key[Up]}"       ]]  && bindkey  "${key[Up]}"       up-line-or-history
[[ -n "${key[Down]}"     ]]  && bindkey  "${key[Down]}"     down-line-or-history
[[ -n "${key[Left]}"     ]]  && bindkey  "${key[Left]}"     backward-char
[[ -n "${key[Right]}"    ]]  && bindkey  "${key[Right]}"    forward-char
[[ -n "${key[PageUp]}"   ]]  && bindkey  "${key[PageUp]}"   beginning-of-buffer-or-history
[[ -n "${key[PageDown]}" ]]  && bindkey  "${key[PageDown]}" end-of-buffer-or-history

bindkey '^[[1;5C' forward-word # [Ctrl-RightArrow] - move forward one word
bindkey '^[[1;5D' backward-word # [Ctrl-LeftArrow] - move backward one word

# This implements a bash-style backward-kill-word.
# To use,
#   zle -N bash-backward-kill-word
#   bindkey '...' bash-backward-kill-word
function bash-backward-kill-word {
    local WORDCHARS=''
    zle .backward-kill-word
}

zle -N bash-backward-kill-word
bindkey '^W' bash-backward-kill-word

# Yay colors
autoload -U colors && colors

alias grep="grep --color=auto"
alias ls="ls --color=auto"
alias dmap="tree --du -h --dirsfirst --sort=size"

# Self-deprecating humor
alias :w="echo YOU FAIL"
alias :wq="echo YOU FAIL"
alias :q="echo YOU FAIL"

# ...
alias rot13="tr '[A-Za-z]' '[N-ZA-Mn-za-m]'"

#export EDITOR=vim

# LESS Options
export LESS=-x4RSX

# Add par to path
export PATH=$PATH:~/src/Par152/

# Add semtex to path
export PATH=$PATH:~/src/semtex/src/

# Add some user scripts to the path
export PATH=~/scripts:$PATH

export PATH=$PATH:~/src/promptoglyph/build
export PATH=$PATH:~/src/charge
export PATH=$PATH:~/src/bmpt

export WINEARCH=win32

# dem gems
export PATH=$PATH:$(ruby -rubygems -e "puts Gem.user_dir")/bin

# Custom D compiler
export PATH=~/src/dlang/dmd/src:~/src/dlang/tools/generated/linux/64:$PATH

# Set up our prompt
setopt PROMPT_SUBST
setopt PROMPT_PERCENT
if [[ -x $(which promptoglyph-vcs) && -x $(which promptoglyph-path) ]] then
    PROMPT='%B$(promptoglyph-path)$(promptoglyph-vcs --zsh -t 300 --prefix " [") $%b '
else
    PROMPT='%1d $ '
fi

[[ -f ~/.zshrc-work ]] && source ~/.zshrc-work
