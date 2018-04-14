
#!/bin/sh
#filename: auto-del-30-days-ago-log.sh
#date: 2016/4/14
#author: eyanchao
find /opt/soft/log/ -mtime +30 -name "*.log" -exec rm -rf {} \;

#crontab -e
#将auto-del-30-days-ago-log.sh执行脚本加入到系统计划任务，到点自动执行
#10 0 * * * /opt/soft/log/auto-del-7-days-ago-log.sh >/dev/null 2>&1
#这里的设置是每天凌晨0点10分执行auto-del-7-days-ago-log.sh文件进行数据清理任务了。



