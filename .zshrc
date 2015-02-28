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

# Finally, make sure the terminal is in application mode
# when zle is active.
# Only then are the values from $terminfo valid.
if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
    function zle-line-init () {
        printf '%s' "${terminfo[smkx]}"
    }
    function zle-line-finish () {
        printf '%s' "${terminfo[rmkx]}"
    }
    zle -N zle-line-init
    zle -N zle-line-finish
    zle -N bash-backward-kill-word
fi

bindkey '^W' bash-backward-kill-word

# Yay colors
autoload -U colors && colors

# Get VCS info for the prompt
autoload -Uz vcs_info

zstyle ':vcs_info:*' stagedstr '%F{green}●%f'
zstyle ':vcs_info:*' unstagedstr '%F{yellow}●%f'
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%b%F{1}:%F{11}%r'
zstyle ':vcs_info:*' enable git svn
zstyle ':vcs_info:*' formats ' %F{green}[%b%c%u%f%B%F{green}]%f'

vcs_precmd () {
    vcs_info
}
autoload -U add-zsh-hook
add-zsh-hook precmd vcs_precmd # Add our hook

alias grep="grep --color=auto"
alias ls="ls --color=auto"

#export EDITOR=vim

# LESS Options
export LESS=-x4RSFX

# Add par to path
export PATH=$PATH:~/src/Par152/

# Add semtex to path
export PATH=$PATH:~/src/semtex/src/

# Add some user scripts to the path
export PATH=$PATH:~/scripts

export PATH=$PATH:~/src/promptd
export PATH=$PATH:~/src/charge
export PATH=$PATH:~/src/bmpt

export PATH=$PATH:~/.gem/ruby/2.1.0/bin

export WINEARCH=win32

# dem gems
export PATH=$PATH:~/.gem/ruby/2.2.0/bin

# Custom D compiler
export PATH=/home/mrkline/src/dlang/dmd/src:/home/mrkline/src/dlang/tools/generated/linux/64:$PATH

# Set up our prompt
setopt PROMPT_SUBST
if [[ -x $(which promptd) ]] then
    PROMPT='%B$(promptd) %% %b'
else
    PROMPT='%1d${vcs_info_msg_0_} %% %b'
fi

[[ -f ~/.zshrc-work ]] && source ~/.zshrc-work
