
#!/bin/sh
 
# check_mysql_slave status
 
ip=eth0 #网卡名称
 
mysql_binfile=/usr/local/mysql/bin/mysql
 
mysql_user=root #MySQL数据库账号
 
mysql_pass=123456 #密码
 
mysql_sockfile=/tmp/mysql.sock
 
datetime=`date +"%Y-%m-%d/%H:%M:%S"`  #获取当前时间
 
mysql_slave_logfile=/home/logs/check_mysql_slave.log  #日志文件路径，必须提前创建好
 
slave_ip=`ifconfig $ip|grep "inet addr" | awk -F[:" "]+ '{print $4}'`
 
status=$($mysql_binfile -u$mysql_user -p$mysql_pass -S $mysql_sockfile -e "show slave status\G" | grep -i "running")
 
Slave_IO_Running=`echo $status | grep Slave_IO_Running | awk ' {print $2}'`
 
Slave_SQL_Running=`echo $status | grep Slave_SQL_Running | awk '{print $2}'`
 
if [ "$Slave_IO_Running" = "Yes" -a "$Slave_SQL_Running" = "Yes" ]
 
then echo "Slave is Running!"
 
else
 
echo " $datetime $slave_ip Slave is not running!" >> $mysql_slave_logfile
 
$mysql_binfile -u$mysql_user -p$mysql_pass -S $mysql_sockfile -e "SLAVE STOP;"
 
$mysql_binfile -u$mysql_user -p$mysql_pass -S $mysql_sockfile -e "SET GLOBAL SQL_SLAVE_SKIP_COUNTER=1;"
 
$mysql_binfile -u$mysql_user -p$mysql_pass -S $mysql_sockfile -e "SLAVE START;"
 
$mysql_binfile -u$mysql_user -p$mysql_pass -S $mysql_sockfile -e "EXIT"
 
fi


