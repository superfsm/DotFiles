source /usr/local/bin/virtualenvwrapper.sh

has_virtualenv() {
    if [ -e .venv ]; then
        workon `cat .venv`
    fi
}
venv_cd () {
    builtin cd "$@" && has_virtualenv
}
alias cd="venv_cd"
alias geany='subl'