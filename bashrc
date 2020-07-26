#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

bind 'set show-all-if-ambiguous on'
bind 'TAB:menu-complete'
