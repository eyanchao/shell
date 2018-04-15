#!/bin/bash
#author: eyanchao
#monitor mysql status via process
 
process=`ps -ef |grep mysql|grep -v grep |wc -l`
if [ $process -ne 2 ]
then
 /etc/init.d/mysqld start
else
 echo "MySQL is running"
fi


