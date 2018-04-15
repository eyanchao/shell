
#!/bin/bash  
#filename: mysql_auto_backup.sh
#date: 2016/4/14
#author: eyanchao
#Used For Linux 

#保存备份个数  
number=3  
#备份保存路径  
backup_dir=/root/mysqlbackup  
#日期  
dd=`date +%Y%m%d`  
#备份工具  
tool=mysqldump  
#用户名  
username=root  
#密码  
password=******  
#将要备份的数据库  
database_name=users  
  
#简单写法  mysqldump -u root -p123456 users > /root/mysqlbackup/users-$filename.dump  
$tool -u $username -p$password $database_name > $backup_dir/$database_name-$dd.dump  
  
#写创建备份日志  
echo "create $backup_dir/$database_name-$dd.dupm" >> $backup_dir/log.txt  
  
#找出需要删除的备份  
delfile=`ls -l -crt  $backup_dir/*.dump | awk '{print $9 }' | head -1`  
  
#判断现在的备份数量是否大于$number  
count=`ls -l -crt  $backup_dir/*.dupm | awk '{print $9 }' | wc -l`  
  
if [ $count -gt $number ]  
then  
  rm $delfile  //删除最早生成的备份，只保留number数量的备份  
  #写删除文件日志  
  echo "delete $delfile" >> $backup_dir/log.txt  
fi  






