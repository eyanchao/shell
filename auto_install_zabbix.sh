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
 echo -n "php-5.6.25依赖初始化完毕！"
fi


echo -n "正在添加zabbix用户……"
useradd -M -s /sbin/nologin zabbix && echo "OK"



echo -n "正在启动mysqld服务……"
service mysqld start
if [ $? -eq 0 ];then
        echo -n "Mysql启动完毕！"
fi

#echo -n "正在为mysql的root用户设置密码……"
#mysql_user_root_password="password"
#mysql_user_zabbix_password="zabbix"
#mysqladmin -uroot -p password $mysql_user_root_password
echo "正在执行mysql语句，创建zabbix数据库，授权zabbix访问数据库"
mysql -e "create database zabbix character set utf8;grant all privileges on zabbix.* to zabbix@'%' identified by 'zabbix';grant all privileges on zabbix.* to zabbix@'127.0.0.1' identified by 'zabbix';grant all privileges on zabbix.* to zabbix@localhost identified by 'zabbix';flush privileges;"
#echo "正在执行mysql语句，创建zabbix数据库，授权zabbix访问数据库"
#mysql -uroot -p"$mysql_user_root_password" -e "create database zabbix character set utf8" && echo "创建zabbix数据库完成"
#mysql -uroot -p"$mysql_user_root_password" -e "grant all privileges on zabbix.* to zabbix@localhost identified by '$mysql_user_zabbix_password'" && echo "授权zabbix本地登录数据库"
#mysql -uroot -p"$mysql_user_root_password" -e "grant all privileges on zabbix.* to zabbix@'%' identified by '$mysql_user_zabbix_password'" && echo "授权任何主机本地登录数据库"

#zabbix一键部署第三方软件包的解压目录
echo -n "编译安装php-5.6.25....可能需要几分钟"
tar zxf ${src_home}/php-5.6.25.tar.gz
cd ${src_home}/php-5.6.25 && ./configure --prefix=/usr/local/php --with-config-file-path=/etc --enable-fpm  --with-libxml-dir --with-gd --with-jpeg-dir --with-png-dir --with-freetype-dir --with-iconv-dir --with-zlib-dir --with-mcrypt --enable-soap --enable-gd-native-ttf  --enable-mbstring --enable-exif  --with-pear --with-curl --enable-bcmath --with-gettext --with-mysqli --enable-sockets
cd ${src_home}/php-5.6.25 && make -j 4 && make install
cd

echo -n "正在配置启动php-fpm....请稍等"
/bin/cp ${src_home}/php-5.6.25/php.ini-production /etc/php.ini
cp ${src_home}/php-5.6.25/sapi/fpm/init.d.php-fpm /etc/init.d/php-fpm
chmod 777 /etc/init.d/php-fpm
cd /usr/local/php/etc/ && cp php-fpm.conf.default php-fpm.conf
cd
service php-fpm start
if [ $? -eq 0 ];then
        echo -n "php-fpm启动完毕！"
fi


