PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$PATH"
PATH="/usr/local/mysql/bin:/Users/houzz/arcanist/arcanist/bin:$PATH"
PATH="/Users/houzz/Library/Android/sdk/platform-tools:/Users/houzz/Library/Android/sdk/build-tools/24.0.1:$PATH"
PATH="/Users/houzz/Library/Android/sdk:$PATH"
PATH="/Users/houzz/Library/dex2jar-2.0:$PATH"
PATH="/Users/houzz/Library/androguard:$PATH"
PATH="/usr/local/mysql/lib:$PATH"
PATH="/Applications/Postgres.app/Contents/Versions/latest/bin:$PATH"
PATH="/Library/TeX/texbin:$PATH"

# export IMPALA_HOST=True
PATH=${CUDA_HOME}/bin:${PATH}
export PATH

# export PYTHONPATH="/usr/local/lib/python2.7/site-packages:$PYTHONPATH"
export PYTHONPATH="/Users/houzz/houzz/c2/python:$PYTHONPATH"

export CUDA_HOME=/usr/local/cuda
export LD_LIBRARY_PATH=${CUDA_HOME}/lib64

source /usr/local/bin/virtualenvwrapper.sh

if which jenv > /dev/null; then eval "$(jenv init -)"; fi
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='subl -w'
# else
#   export EDITOR='vim'
# fi

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

alias rrr='rsync -avz --progress --exclude=.pants.d/ --exclude=luigi.cfg --exclude=.cache/ --exclude=dist/ /houzz/c2dw/ frank@util.hzd:/home/frank/c2dw'

alias bbb='sudo -su hadoop $(readlink -f pants) binary bin:adwords_mgmt'
alias uuu='sudo -su hadoop $(readlink -f pants) binary bin:undo'
alias ppp='sudo -su hadoop $(readlink -f pants) binary bin:pipeline'
alias ttt='sudo -su hadoop $(readlink -f pants) test test/python:all'
alias pps='sudo -su hadoop $(readlink -f pants) binary bin:pipeline && bash ./script/pex_to_zip.sh /tmp/frank_deps.zip'

alias w0='ssh util.hzd'

alias hls='snakebite ls'
alias hcat='snakebite cat'
alias pyspark='/home/hadoop/spark-2.1.1-bin-hadoop2.6/bin/pyspark'

check()
{
	mysql -u dashy -h luigi-db.data.houzz.net -pdashy595 luigi -e "select * from houzz_task_run_times where task='$1' order by data_hour DESC, run_start DESC limit 30"
}

up()
{
	impala -q "SELECT * FROM (SELECT * FROM dm.houzz_sem_bids WHERE keyword_id = $1 ORDER BY dt DESC limit 10) AS tbl ORDER BY dt"
}

down()
{
	impala -q "SELECT * FROM (SELECT bids, dt FROM dm.keyword_structure_snapshot WHERE kw_id = $1 AND campaign NOT LIKE 'trial%' AND account_name='Houzz_SEM' ORDER BY dt DESC LIMIT 10) AS limited ORDER BY dt"
}

gg()
{
grep -RiIs "$1" .
}

ff()
{
find . -name "$1"
}
