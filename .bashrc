#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\n> '
export PS1="\[$(tput setaf 5)\]\u\[$(tput setaf 220)\]@\[$(tput setaf 10)\]\h \[$(tput setaf 11)\]\w \[$(tput sgr0)\]\n> "

export HISTCONTROL=ignoreboth:erasedups
export HISTSIZE=10000
export HISTFILESIZE=100000

source ~/.profile

eval "$(zoxide init bash)"

setfont ter-132n
