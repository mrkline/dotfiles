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
HISTSIZE=1000000000
SAVEHIST=$HISTSIZE

setopt extended_history
setopt hist_ignore_dups # Don't record sequential duplicates.
#setopt hist_ignore_all_dups # Axe any previous instances of a command.
setopt hist_expire_dups_first # Remove duplicates before unique commands.
setopt hist_ignore_space # Don't record entries starting with a space.
setopt hist_reduce_blanks # Strip extra whitespace.
setopt hist_verify
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
alias el="exa -lh"
alias es="exa -lhs size"
alias ed="exa -lhs date"
alias e1="exa -1"

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

# Other compiler fun.
CPPFLAGS="-D_FORTIFY_SOURCE=2"
CFLAGS="-march=native -pipe -fstack-protector-strong"
CXXFLAGS="-march=native -pipe -fstack-protector-strong"
LDFLAGS="-Wl,-O1,--sort-common,--as-needed,-z,relro,-z,now"

# Stop libstdc++ misadventures:
# https://www.zerotier.com/blog/2017-05-05-theleak.shtml
# https://gcc.gnu.org/onlinedocs/libstdc++/manual/memory.html
export GLIBCXX_FORCE_NEW=y

# Neovim!
if type nvim >/dev/null; then
    export EDITOR=nvim
elif type vim >/dev/null; then
    export EDITOR=vim
elif type vi >/dev/null; then
    export EDITOR=vi
fi

# Saves some stat() calls, FWIW:
# https://blog.packagecloud.io/eng/2017/02/21/set-environment-variable-save-thousands-of-system-calls/
export TZ=":/etc/localtime"

# LESS Options
export LESS=-x4RSX

# Emulate a 32-bit Windows machine with wine
export WINEARCH=win32

# Add some user scripts to the path
export PATH=~/scripts:$PATH
export PATH=$PATH:~/src/charge

# Set up our prompt
setopt prompt_subst
setopt prompt_percent

export PATH=$PATH:~/src/promptoglyph/build

if promptoglyph-vcs --version >/dev/null; then
    export PS1='%F{red}%(?..[%?] )%f%F{green}%~%f$(promptoglyph-vcs --zsh --prefix " [") $ '
else
    export PS1='%F{red}%(?..[%?] )%f%F{green}%~%f $ '
fi
export RPS1=''

# warm fuzzies
source "/usr/share/fzf/key-bindings.zsh"
source "/usr/share/fzf/completion.zsh"

# bat (syntax-highlighting cat) - white text on light term is bad, mmmk?
export BAT_THEME=ansi

# ditto for fd (colorized find)
export LS_COLORS=""

# Machine-specific nonsense
[[ -f ~/.zshrc-machine ]] && source ~/.zshrc-machine
# Clear error code so I'm not greeted with a red "1" at home
true

if [ -e /home/mrkline/.nix-profile/etc/profile.d/nix.sh ]; then . /home/mrkline/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
