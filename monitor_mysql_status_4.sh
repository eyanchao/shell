#!/bin/bash

 
mysql -uroot -p123456 -e "select version();" &>/dev/null
if [ $? -ne 0 ]
then
 /etc/init.d/mysqld start
else
 echo "MySQL is running"
fi



