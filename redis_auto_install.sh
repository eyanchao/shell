#!/bin/bash
#安装gcc
yum install gcc-c++
#接收参数：redis压缩包绝对路径
src=$1
#接收参数：redis安装绝对路径
target=$2
echo $src
unzipParentDir=${src%/*}
temp=${src%t*}
#解压缩后的目录
unzipDir=${temp%.*}
echo "directory :"$unzipParentDir
echo "file path :"$unzipDir
#unzip tar file to current directory
#解压缩
tar -xzvf $src -C $unzipParentDir
#进入解压后的目录
cd $unzipDir
echo `pwd`
#编译
make
#安装
make PREFIX=$target install
#复制redis配置文件
cp -f redis.conf $target"/"bin
#进入安装目录下的bin目录
cd $target"/bin"
./redis-server redis.conf #启动redis
systemctl stop firewalld.service

#首先我们需要将redis安装包上传到linux中，将我们编写好的shell脚本与安装包放在同一路径下。 
#执行shell脚本test.sh,此处传入两个参数：第一个参数是redis安装包绝对路径/home/gaoshanjinag/redis-3.0.0.tar.gz，第二个参数是要安装到的绝对路径 /usr/local/redis 
#[root@localhost gaoshanjiang]# ./redis-install.sh redis-3.0.0.tar.gz /usr/local/redis
