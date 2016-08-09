export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$PATH"
export PATH="/usr/local/mysql/bin:/Users/houzz/arcanist/arcanist/bin:$PATH"
export PATH="/Users/houzz/Library/Android/sdk/platform-tools:$PATH"
if which jenv > /dev/null; then eval "$(jenv init -)"; fi
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='subl -w'
# else
#   export EDITOR='vim'
# fi

alias geany='subl'
alias rrr='rsync -avz --progress --exclude=.pants.d/ --exclude=dist/pipeline.pex /houzz/c2dw/ frank@hdwu01.hz:/home/frank/c2dw'
alias uuu='./pants binary bin:undo'
alias ppp='./pants binary bin:pipeline'

gg()
{
grep -RiIs "$1" .
}

ff()
{
find . -name "$1"
}