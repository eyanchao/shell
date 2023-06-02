#!/bin/sh
#function: redis start && stop shell scripts
#date: 2023/06/02
#author: ywlx

REDIS_DIR=/opt/redis-6.2.9/src  #这里用的redis版本是6.2.9
#redis服务器监听的端口
REDISPORT=6379

#服务端所处位置
EXEC=$redis_dir/redis-server

#客户端位置
CLIEXEC=$REDIS_DIR/redis-cli

#redis的PID文件位置，需要修改
PIDFILE=/var/run/redis_${REDISPORT}.pid

#redis的配置文件位置，需将${REDISPORT}修改为文件名
CONF=/opt/redis-6.2.9/redis.conf

case "$1" in
    start)
        if [ -f $PIDFILE ]
        then
                echo "$PIDFILE exists, process is already running or crashed"
        else
                echo "Starting Redis server..."
                $EXEC $CONF
                echo "Redis server is started"
        fi
        ;;
    stop)
        if [ ! -f $PIDFILE ]
        then
                echo "$PIDFILE does not exist, process is not running"
        else
                PID=$(cat $PIDFILE)
                echo "Stopping ..."
                $CLIEXEC -p $REDISPORT -a "pass12345" -p $REDISPORT shutdown   #redis.conf里设置密码的，停止redis前需要预先提供密码，才能停止，这里提供了测试环境的密码。
                while [ -x /proc/${PID} ]
                do
                    echo "Waiting for Redis to shutdown ..."
                    sleep 1
                done
                echo "Redis stopped"
        fi
        ;;
    *)
        echo "Please use start or stop as first argument"
        ;;
esac




