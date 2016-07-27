export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$PATH"
export PATH="/usr/local/mysql/bin:~/arcanist/arcanist/bin:$PATH"

# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='subl -w'
# else
#   export EDITOR='vim'
# fi

alias geany='subl'
alias rrr='rsync -avz --progress --exclude=.pants.d/ --exclude=dist/pipeline.pex /houzz/c2dw/ frank@hdwu01.hz:/home/frank/c2dw'

gg()
{
grep -RiIs "$1" .
}

ff()
{
find . -name "$1"
}