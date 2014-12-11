#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
#PS1='[\u@\h \W]\$ '

# ubuntu settings
# remove in case of issues
# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# my custom alias

# activate a python virtual environment
# usage: activate venv/
function activate() { source "$1"bin/activate ;}

# symlink pyside from maya libraries
# usage: lnmaya venv/
function lnmaya() {
	ln -s /usr/autodesk/maya/lib/python2.7/site-packages/PySide "$1"lib/python2.7/site-packages/PySide ;
	ln -s /usr/autodesk/maya/lib/python2.7/site-packages/shiboken.so "$1"lib/python2.7/site-packages/shiboken.so ;
	ln -s /usr/autodesk/maya/lib/libshiboken-python2.7.so.1.1.1 "$1"lib/libshiboken-python2.7.so.1.1 ;
	ln -s /usr/autodesk/maya/lib/python2.7/site-packages/pysideuic "$1"lib/python2.7/site-packages/pysideuic ;
}

# run testsuite using nosetests + coverage + file watcher
# usage: testme (from the root of your project)
alias testme='nosetests -v --with-coverage --cover-package="${PWD##*/}" --with-watch'

# cd ..
alias ..='cd ..'
alias cd..='..'

# clear screen
alias cls='clear'

# override sublime text 2
function sublime() {
    subl "${@}" > /dev/null 2>&1 &
}

# set git prompt
source /usr/share/git/completion/git-prompt.sh

get_sha() {
    git rev-parse --short HEAD 2>/dev/null
}


GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWSTASHSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=1
GIT_PS1_SHOWUPSTREAM="verbose"
PS1='\[\e[1;32m\]\W$(__git_ps1 " ($(get_sha) %s)")\$\[\e[0m\] '

# default editor used by yaourt
export EDITOR=vim