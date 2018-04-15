#/bin/bash
#filename: auto-del-30-days-ago-log.sh
#date: 2016/4/14
#author: eyanchao

echo -n "login:" 
read name
echo -n "password:"
read passwd
if [ $name = "cht" -a $passwd = "abc" ];then
echo "the host and password is right!"
else echo "input is error!"
fi



