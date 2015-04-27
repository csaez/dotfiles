# my custom alias

# activate a python virtual environment
# usage: activate venv/
function activate() { source "$1"bin/activate ;}

# symlink pyside from maya 2014 libraries
# usage: lnmaya venv/
function lnmaya() {
	ln -s /usr/autodesk/maya/lib/python2.7/site-packages/PySide "$1"lib/python2.7/site-packages/PySide ;
	ln -s /usr/autodesk/maya/lib/python2.7/site-packages/shiboken.so "$1"lib/python2.7/site-packages/shiboken.so ;
	ln -s /usr/autodesk/maya/lib/libshiboken-python2.7.so.1.1.1 "$1"lib/libshiboken-python2.7.so.1.1 ;
	ln -s /usr/autodesk/maya/lib/python2.7/site-packages/pysideuic "$1"lib/python2.7/site-packages/pysideuic ;
}

# run testsuite using nosetests + coverage
# usage: testme (from the root of your project)
alias testme='clear && nosetests -v --with-coverage --cover-package="${PWD##*/}" --cover-erase'
alias unittest='coverage erase && clear && coverage run --source "${PWD##*/}" -m unittest discover && coverage report -m'

# cd ..
alias ..='cd ..'
alias cd..='..'

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

# set default editor, used by yaourt
export EDITOR=vim
