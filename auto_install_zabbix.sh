#!/bin/bash

#Zabbix 一键部署脚本
#Date: 2018/4/13
#Author: eyanchao
#Environment：Centos7

########################NOTICE #########################
#  安装zabbix3.0.4：依赖php-5.6.25,mysql,nginx or apache#
########################################################

src_home=`pwd`
echo -n "正在配置iptables防火墙……"

/etc/init.d/iptables save >> /dev/null
chkconfig  iptables off
if [ $? -eq 0 ];then
echo -n "Iptables防火墙初始化完毕！"
fi

echo -n "正在关闭SELinux……"
setenforce 0 > /dev/null 2>&1
sed -i '/^SELINUX=/s/=.*/=disabled/' /etc/selinux/config
if [ $? -eq 0 ];then
        echo -n "SELinux初始化完毕！"
fi

echo -n "正在安装nginx yum 源……"

yum -y install wget
wget http://nginx.org/packages/centos/7/noarch/RPMS/nginx-release-centos-7-0.el7.ngx.noarch.rpm
wget http://repo.zabbix.com/zabbix/3.4/rhel/7/x86_64/zabbix-release-3.4-2.el7.noarch.rpm
rpm -ivh nginx-release-centos-7-0.el7.ngx.noarch.rpm
rpm -ivh zabbix-release-3.4-2.el7.noarch.rpm


if [ $? -eq 0 ];then
        echo -n "Nginx&Zabbix yum源初始化完毕！"
fi

echo -n "正在安装epel-release yum 源……"

rpm -Uvh http://mirrors.ustc.edu.cn/epel/epel-release-latest-7.noarch.rpm
#rpm -Uvh
if [ $? -eq 0 ];then
        echo -n "epel-release yum 源 初始化完毕！"
fi

echo -n "正在安装php-5.6.25的编译所需相关软件……"
yum -y install make gcc nginx  libmcrypt php-mcrypt mysql-server mysql-devel net-snmp-devel libcurl-devel php php-mysql php-bcmath php-mbstring php-gd php-xml bzip2-devel libmcrypt-devel libxml2-devel gd gd-devel libcurl*
if [ $? -eq 0 ];then

