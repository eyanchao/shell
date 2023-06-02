#!/bin/bash
#fuction: start the jar on backend
#date: 2023/6/2
#author: e

jar_name=xxxxxxxxx.jar

PID=$(ps -ef |grep  $jar_name | grep -v grep | awk '{print $2}'|awk -F '/' '{print $1}')
  
if [ -n "$PID" ]; then
        kill -9 $PID
        echo kill $PID successful
else
        echo jar is not running $PID
fi
nohup java -jar xxxxxx.jar --spring.config.location=application.properties > $jar_name.out 2>&1 &
tail  -f  $jar_name.out
