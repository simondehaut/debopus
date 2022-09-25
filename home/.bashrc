#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# default primary prompt setting
#PS1='[\u@\h \W]\$ '

ORANGE="\[$(tput setaf 3)\]"
PINK="\[$(tput setaf 201)\]"
RESET="\[$(tput sgr0)\]"

# primary prompt setting
PS1="${PINK}\u \W ${RESET}> "

# bash completion
complete -c man which
complete -cf sudo

# aliases : color and human readable
alias ls='ls -hF --color=auto'
alias dmesg='dmesg -HL'
alias grep='grep --color=auto'
alias df='df -h'
alias du='du -c -h'
alias pacman='pacman --color=auto'
alias yay='yay --color=auto'

# privileged access
if (( UID != 0 )); then
    alias reboot='sudo systemctl reboot'
    alias poweroff='sudo systemctl poweroff'
fi

# safety features
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -I'
alias ln='ln -i'

# make bash tolerant
alias cd..='cd ..'

# colors for man page
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'
