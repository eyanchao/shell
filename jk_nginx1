
#!/bin/bash
#filename: auto_check_nginx.sh(for monitor nginx)
#date: 2018/05/09
#author: uadx.kr

#################################################
# every 10s/time to auto check nginx status,    #
# if it has stopped then auto restart the nginx #
#################################################

WebPort=`netstat -nlt |grep 80|awk '{print $4}'| cut -d : -f 2`
        if [ "$WebPort" = "80" ];then
               echo "The nginx is running!"
               exit 0
           else
               systemctl start nginx.service
               exit 1

        fi
