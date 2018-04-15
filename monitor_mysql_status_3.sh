#!/bin/bash
#author: eyanchao
 
port=`netstat -nlt|grep 3306|wc -l`
process=`ps -ef |grep mysql|grep -v grep |wc -l`
if [ $port -eq 1 ] && [ $process -eq 2 ]
then
    echo "MySQL is running"
else
    /etc/init.d/mysqld start
fi




