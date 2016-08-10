# my custom alias

# activate a python virtual environment
# usage: activate venv/
function activate() { source "$1"bin/activate ;}

# symlink pyside from maya 2014 libraries
# usage: lnmaya venv/
function lnmaya() {
    rm -rf "$1"lib/python2.7/site-packages/maya;
	ln -s /usr/autodesk/maya/devkit/other/pymel/extras/completion/py/maya "$1"lib/python2.7/site-packages/maya;
    rm -rf "$1"lib/python2.7/site-packages/pymel;
	ln -s /usr/autodesk/maya/devkit/other/pymel/extras/completion/py/pymel "$1"lib/python2.7/site-packages/pymel;

    rm -rf "$1"lib/python2.7/site-packages/PySide;
	ln -s /usr/autodesk/maya/lib/python2.7/site-packages/PySide "$1"lib/python2.7/site-packages/PySide;
	rm -rf "$1"lib/python2.7/site-packages/shiboken.so;
	ln -s /usr/autodesk/maya/lib/python2.7/site-packages/shiboken.so "$1"lib/python2.7/site-packages/shiboken.so;
	rm -rf "$1"lib/libshiboken-python2.7.so.1.1;
	ln -s /usr/autodesk/maya/lib/libshiboken-python2.7.so.1.1.1 "$1"lib/libshiboken-python2.7.so.1.1;
	rm -rf "$1"lib/python2.7/site-packages/pysideuic;
	ln -s /usr/autodesk/maya/lib/python2.7/site-packages/pysideuic "$1"lib/python2.7/site-packages/pysideuic;
}

# run testsuite using nosetests + coverage
# usage: testme (from the root of your project)
#alias nosetest='clear && nosetests -v --with-coverage --cover-package="${PWD##*/}" --cover-erase'
alias unittest='clear && coverage run --source "${PWD##*/}" -m unittest discover && coverage report -m || python -m unittest discover'

# set default editor
alias vim=nvim
alias vi=nvim
export EDITOR=nvim
export TERM=xterm-256color
