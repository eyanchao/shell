
#!/bin/bash
#author: eyanchao
#monitor mysql status via port
 
port=`netstat -nlt|grep 3306|wc -l`
if [ $port -ne 1 ]
then
 /etc/init.d/mysqld start
else
 echo "MySQL is running"
fi



