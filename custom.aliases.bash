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

    rm -rf "$1"lib/python2.7/site-packages/PySide2;
    ln -s /usr/autodesk/maya/lib/python2.7/site-packages/PySide2 "$1"lib/python2.7/site-packages/PySide2;
    rm -rf "$1"lib/python2.7/site-packages/shiboken2.so;
    ln -s /usr/autodesk/maya/lib/python2.7/site-packages/shiboken2.so "$1"lib/python2.7/site-packages/shiboken2.so;
    rm -rf "$1"lib/python2.7/site-packages/pyside2uic;
    ln -s /usr/autodesk/maya/lib/python2.7/site-packages/pyside2uic "$1"lib/python2.7/site-packages/pyside2uic;

    rm -rf "$1"lib/libpyside2-python2.7.so.2.0;
    ln -s /usr/autodesk/maya/lib/libpyside2-python2.7.so.2.0.0 "$1"lib/libpyside2-python2.7.so.2.0;
    rm -rf "$1"lib/libshiboken2-python2.7.so.2.0;
    ln -s /usr/autodesk/maya/lib/libshiboken2-python2.7.so.2.0.0 "$1"lib/libshiboken2-python2.7.so.2.0;
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

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/.cargo/bin:$HOME/bin:$PATH"
fi


source /etc/profile.d/undistract-me.sh
