
#!/bin/sh
#set -x
#file is slave_repl.sh

 mstool="/usr/local/mysql-3307/bin/mysql -h 192.168.1.106 -uroot -pw!zl7POg27 -P 3307"
sltool="/usr/local/mysql-3307/bin/mysql -h 192.168.1.107 -uroot -pw!zl7POg27 -P 3307"
declare -a slave_stat
slave_stat=($($sltool -e "show slave status\G"|grep Running |awk '{print $2}'))
if [ "${slave_stat[0]}" = "Yes" -a "${slave_stat[1]}" = "Yes" ]
   then
   echo "OK slave is running"
   exit 0
else
   echo "Critical slave is error"
   echo
   echo "*********************************************************"
   echo "Now Starting replication with Master Mysql!"
    file=`$mstool -e "show master status\G"|grep "File"|awk '{print $2}'` 
    pos=`$mstool -e "show master status\G"|grep "Pos"|awk '{print $2}'` 
    $sltool -e "slave stop;change master to master_host='192.168.1.106',master_port=3307,master_user='repl',master_password='w!zl7POg27',master_log_file='$file',master_log_pos=$pos;slave start;"
    sleep 3
    $sltool -e "show slave status\G;"|grep Running
  echo
  echo "Now Replication is Finished!"
  echo
  echo "**********************************************************"
    exit 2
fi



