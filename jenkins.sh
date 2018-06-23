#!/bin/bash
#filename: auto_pub.sh
#describe:auto update to publish 
#author： udax.kr
#date: 2018/6/23

$bizservice_war=/opt/udax/bizservice
$bizweb_war=/opt/udax/bizweb
$bizservice_dir=/opt/apache-tomcat-8.0.52
$bizweb_dir=/opt/tomcat

sh $bizservice_dir/shutdown.sh&& sh $bizweb_dir/shutdown.sh

#check_status=`netstat -ntpl| grep '8080' | grep '8081'

mkdir -p $bizservice_war backup && mv $bizservice_war/* backup | grep -v *.war
mkdir -p $bizweb_war backup && mv $bizweb_war/* backup | grep -v *.war

if [!-f *.war $bizservice_war];then
      jar -xvf $bizservice_war/*war
else
    beak 
     
if [`echo $0` == 0];then
   
sh $bizservice_dir/startup.sh&& sh $bizweb_dir/starup.sh

echo "The biz-service & biz-web has started..  "

fi








