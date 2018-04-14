
#!/bin/sh
#filename: auto-del-30-days-ago-log.sh
#date: 2016/4/14
#author: eyanchao
#Used For Linux 

dir= /opt/soft/log/   #删除指定目录下日志文件
find $dir -mtime +30 -name "*.log" -exec rm -rf {} \;
#find /mnt/sdb/backups -mtime +15 -name "*gz*" -exec rm -rf {} \;
#删除 /mnt/sdb/backups文件夹下 15天前的 文件名包含 "gz" 的文件
#如果要删除当前目录包括子目录下面的文件名包含"gz"﻿的文件，用
#find /mnt/sdb/backups/ -mtime +15 -type f -iname "*gz*" -exec rm -rf {} \;﻿

#crontab -e
#将auto-del-30-days-ago-log.sh执行脚本加入到系统计划任务，到点自动执行
#10 0 * * * /opt/soft/log/auto-del-7-days-ago-log.sh >/dev/null 2>&1
#这里的设置是每天凌晨0点10分执行auto-del-7-days-ago-log.sh文件进行数据清理任务了。



