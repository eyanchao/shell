
#/bin/sh

dir= /data/redis/bin7K/

n=100000000
for ((i=n;i>=1;i--))
do
    echo $i
    sh $dir/redis-cli -p 7000 dbsize | xargs redis-cli -p 7000 set name$i xxxx       
done
~     



