#!/bin/bash
#filename: scp_to_others.sh
#date: 2016/4/14
#author: eyanchao

DEBUG=true
debug(){
if [ "$DEBUG" = "true" ];then
$@
fi
}
func_expect(){
expect -c "
set timeout 30;
spawn $*;
expect {
\"(yes/no)?\" {send \"yes\r\";exp_continue}
\"*ssword:\" {send \"$pass\r\";exp_continue}
#\"*~]\$\" {send \"df -h\r exit\r\";interact}
}
"
}
func_exec(){
#command="scp $1 $2@$3:."
command="scp $1 $2@$3:./agent/bin/"
debug echo '$command' : $command
func_expect $command
}
if [ $# -ne 2 ];then
echo -e "\nwrong call !\nfor eample: $0 file cfg\n"
exit 1
else
dir='.'
debug echo '$dir' : $dir

file1=$dir/$1

debug echo '$file1' : $file1

debug echo '$#': $#
cat $2 | grep -v '^#' | awk '{print $1,$2,$3,$4}' | while read type ip user pass 
do
func_exec $file1 $user $ip
sleep 1
done
fi


#$1:要传输的文件
#$2:主机信息 如： ssh 127.0.0.1 user password






