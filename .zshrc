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
setopt hist_ignore_dups # ignore duplication command history list
setopt hist_ignore_space
setopt hist_verify
setopt inc_append_history_time
setopt share_history # share history between sessions

bindkey -e

# Key bindings from the Arch wiki:

# create a zkbd compatible hash;
# to add other keys to this hash, see: man 5 terminfo
typeset -A key

key[Insert]=${terminfo[kich1]}
key[Delete]=${terminfo[kdch1]}
key[Up]=${terminfo[kcuu1]}
key[Down]=${terminfo[kcud1]}
key[Left]=${terminfo[kcub1]}
key[Right]=${terminfo[kcuf1]}

# setup key accordingly
[[ -n "${key[Insert]}"   ]]  && bindkey  "${key[Insert]}"   overwrite-mode
[[ -n "${key[Delete]}"   ]]  && bindkey  "${key[Delete]}"   delete-char
[[ -n "${key[Up]}"       ]]  && bindkey  "${key[Up]}"       up-line-or-history
[[ -n "${key[Down]}"     ]]  && bindkey  "${key[Down]}"     down-line-or-history
[[ -n "${key[Left]}"     ]]  && bindkey  "${key[Left]}"     backward-char
[[ -n "${key[Right]}"    ]]  && bindkey  "${key[Right]}"    forward-char

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

# Useful commands
alias dmap="tree --du -h --dirsfirst --sort=size"
alias pacdiff='sudo DIFFSEARCHPATH="/boot /etc /usr" DIFFPROG="meld" pacdiff'
alias lss="ls -lShr"
alias lst="ls -lthr"

# Patience diff is best diff
alias pdiff=git diff --patience --no-index

# Self-deprecating humor
alias :w="echo E_NOTVIM"
alias :wq="echo E_I_AM_A_SHELL"
alias :q="echo In Russia, shell quits you!"
alias :qa="echo No escape"

# ...
alias rot13="tr '[A-Za-z]' '[N-ZA-Mn-za-m]'"

# Helps pinentry behave when unlocking GPG keys
export GPG_TTY=$(tty)

# Clang!
if type clang >/dev/null; then
    export CC=clang
    export CXX=clang++
fi

# Other compiler fun.
CPPFLAGS="-D_FORTIFY_SOURCE=2"
CFLAGS="-march=native -pipe -fstack-protector-strong"
CXXFLAGS="-march=native -pipe -fstack-protector-strong"
LDFLAGS="-Wl,-O1,--sort-common,--as-needed,-z,relro,-z,now"

# Stop libstdc++ misadventures:
# https://www.zerotier.com/blog/2017-05-05-theleak.shtml
export GLIBCXX_FORCE_NEW=y

# Native rust builds!
export RUSTFLAGS="-C target-cpu=native"

# Neovim!
if type nvim >/dev/null; then
    alias vim="nvim"
    alias vimterm="nvim -c 'terminal'"
    export EDITOR=nvim
elif type vim >/dev/null; then
    export EDITOR=vim
elif type vi >/dev/null; then
    export EDITOR=vi
else
    export EDITOR=nano
fi

# Saves some stat() calls, FWIW:
# https://blog.packagecloud.io/eng/2017/02/21/set-environment-variable-save-thousands-of-system-calls/
export TZ=":/etc/localtime"

# LESS Options
export LESS=-x4RSX

# Add some user scripts to the path
export PATH=~/scripts:$PATH

# Add the crap I wrote to the path
export PATH=$PATH:~/src/promptoglyph/build
export PATH=$PATH:~/src/charge

# Emulate a 32-bit Windows machine with wine
export WINEARCH=win32

# dem gems
#export PATH=$PATH:$(ruby -rubygems -e "puts Gem.user_dir")/bin

# Set up our prompt
setopt PROMPT_SUBST
setopt PROMPT_PERCENT
if [[ -x $(which promptoglyph-vcs) && -x $(which promptoglyph-path) ]] then
    PROMPT='%B%F{red}%(?..%? )%f$(promptoglyph-path -n 3)$(promptoglyph-vcs --zsh -t 300 --prefix " [") $%b '
else
    PROMPT='%F{red}%(?..%? )%f%1d $ '
fi

# Machine-specific nonsense
[[ -f ~/.zshrc-machine ]] && source ~/.zshrc-machine
# Clear error code so I'm not greeted with a red "1" at home
true
