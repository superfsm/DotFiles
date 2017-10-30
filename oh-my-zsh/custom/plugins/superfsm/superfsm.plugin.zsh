PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$PATH"
PATH="/usr/local/mysql/bin:/Users/houzz/arcanist/arcanist/bin:$PATH"
PATH="/Users/houzz/Library/Android/sdk/platform-tools:/Users/houzz/Library/Android/sdk/build-tools/24.0.1:$PATH"
PATH="/Users/houzz/Library/Android/sdk:$PATH"
PATH="/Users/houzz/Library/dex2jar-2.0:$PATH"
PATH="/Users/houzz/Library/androguard:$PATH"
PATH="/usr/local/mysql/lib:$PATH"
PATH="/Applications/Postgres.app/Contents/Versions/latest/bin:$PATH"

export IMPALA_HOST=True
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

alias rrr='rsync -avz --progress --exclude=.pants.d/ --exclude=.cache/ --exclude=dist/ /houzz/c2dw/ frank@data-util.hzd:/home/frank/c2dw'
# alias rrr2='rsync -avz --progress --exclude=.pants.d/ --exclude=dist/pipeline.pex /houzz/c2dw/ frank@hdwu01.hz:/home/frank/c2dw'

alias bbb='./pants binary bin:adwords_mgmt'
alias uuu='./pants binary bin:undo'
alias ppp='./pants binary bin:pipeline'
alias pps='./pants binary bin:pipeline && bash ./script/pex_to_zip.sh /tmp/frank_deps.zip'

alias w0='ssh data-util.hzd'
alias w1='ssh 10.4.0.198.hzd'
alias w2='ssh 10.4.1.224.hzd'
alias wt='ssh 10.4.2.121.hzd'

alias hls='hdfs dfs -ls'

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

apkunpack(){
	if [ -z $1 ]; then
		echo "Missing app name!"
		return
	fi
	DIR=~/workspace/debug-$1
	mkdir $DIR
	cd $DIR/
	cp ~/workspace/$1/app/build/outputs/apk/app-debug.apk ./
	apktool d -f $DIR/app-debug.apk
}

apkpack(){
	if [ -z $1 ]; then
		echo "Missing app folder!"
		return
	fi
	apktool b $1
	if [ $? -ne 0 ]; then
		return
	fi
	apk=$(ls $1/dist/*.apk)
	signapp $apk
	if [ $? -ne 0 ]; then
		return
	fi
	echo "apk: $apk"
	package=$(aapt dump badging $apk | grep -Eo "package: name=\'(.*?)\' " | cut -d\' -f2)
	echo "package: $package"
	adb uninstall $package
	adb install $apk
	adb shell monkey -p $package -c android.intent.category.LAUNCHER 1
}

signapp(){
	jarsigner -verbose -sigalg SHA1withRSA -digestalg SHA1 -keystore ~/.android/debug.keystore $1 androiddebugkey -storepass android -keypass android
}

verifyapp(){
	jarsigner -verify -verbose -certs $1
}

# sss()
# {
# rrr
# echo '--------------'
# ssh hdwu01.hz "hostname"
# ssh hdwu01.hz "cd ~/c2dw/ && ./pants binary bin:pipeline"
# scp hdwu01.hz:/home/frank/c2dw/dist/pipeline.pex ~/tmp/pipeline.pex
# scp -i ~/.ssh/hadoop_rsa ~/tmp/pipeline.pex hadoop@luigi-worker-bc50e513.hzd:~/pipeline/mypipeline.pex

# # ssh -i ~/.ssh/hadoop_rsa hadoop@hdwu01.hz "scp -i ~/.ssh/hadoop_rsa ~/tmp/franks_file hadoop@hdbs:~/franks_file"
# # scp -i ~/.ssh/hadoop_rsa ~/houzz/c2dw/dist/pipeline.pex hadoop@luigi-worker-bc50e513.hzd:~/pipeline/pipeline.pex
# # ssh -i ~/.ssh/hadoop_rsa hadoop@hdwu01.hz "scp -i ~/.ssh/hadoop_rsa ~/tmp/franks_file hadoop@hdbs:~/franks_file"
# # ssh -i ~/.ssh/hadoop_rsa hadoop@hdwu01.hz "ssh -i ~/.ssh/hadoop_rsa hadoop@hdbs 'rm /home/hadoop/frank/*'"
# # ssh -i ~/.ssh/hadoop_rsa hadoop@hdwu01.hz "ssh -i ~/.ssh/hadoop_rsa hadoop@hdbs 'hostname && /var/pyenv/rdb/bin/python /home/hadoop/franks_file FollowersRdbData'"
# }

# zzz()
# {
# scp ~/workspace/aws/diff.sh data-util.hzd:~/workspace/
# scp ~/workspace/aws/compare.py data-util.hzd:~/workspace/
# ssh data-util.hzd "cd ~/workspace/ && /bin/bash ~/workspace/diff.sh"
# }

# ttt()
# {
# scp /houzz/c2dw/script/impala_schema_export/impala_table_looper.sh hdwu01.hz:~/tmp/impala_table_looper.sh
# scp /houzz/c2dw/script/impala_schema_export/impala_datatype.txt hdwu01.hz:~/tmp/impala_datatype.txt
# ssh hdwu01.hz "cd /home/frank/tmp && /bin/bash ~/tmp/impala_table_looper.sh"
# scp hdwu01.hz:~/tmp/create_table.sql ./
# scp hdwu01.hz:~/tmp/create_database.sql ./
# }