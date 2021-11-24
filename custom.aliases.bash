# my custom alias

# activate a python virtual environment
# usage: activate venv/
function pyenv() { source "$1"/bin/activate ;}

# run testsuite using nosetests + coverage
# usage: testme (from the root of your project)
#alias nosetest='clear && nosetests -v --with-coverage --cover-package="${PWD##*/}" --cover-erase'
alias unittest='clear && coverage run --source "${PWD##*/}" -m unittest discover && coverage report -m || python -m unittest discover'

# set default editor
alias vim=nvim
alias vi=nvim
export QT_AUTO_SCREEN_SCALE_FACTOR=0
export EDITOR=nvim
export TERM=xterm-256color

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/.cargo/bin:$HOME/bin:$HOME/.local/bin:$PATH"
fi
