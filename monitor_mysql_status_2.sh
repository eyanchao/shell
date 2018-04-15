#!/bin/bash
#filename: monitor_mysql_status_2.sh
#date: 2016/4/14
#author: eyanchao
#monitor mysql status via process
 
process=`ps -ef |grep mysql|grep -v grep |wc -l`
if [ $process -ne 2 ]
then
 /etc/init.d/mysqld start
else
 echo "MySQL is running"
fi


