#!/bin/bash
#filename: monitor_mysql_status_4.sh
#date: 2016/4/14
#author: eyanchao
 
mysql -uroot -p123456 -e "select version();" &>/dev/null
if [ $? -ne 0 ]
then
 /etc/init.d/mysqld start
else
 echo "MySQL is running"
fi



