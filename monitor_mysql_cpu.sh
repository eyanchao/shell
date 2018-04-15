#!/bin/bash
#author: eyanchao

cpu=`ps aux | grep 'mysqld$' | cut -d " " -f6 | cut -d. -f1`
if [ $cpu -gt 300 ]
then
    service mysql restart && date >> /tmp/mysql.log
fi

#当mysql的CPU利用率超过300%的时候就不能提供服务了，近乎卡死状态，这时候最好的方法 就是重启mysql服务
