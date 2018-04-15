#!/bin/sh 
#filename: monitor_redis_memery.sh
#date: 2016/4/14
#author: eyanchao
  
USEDMEMORY_77=$(redis-cli -h 192.168.119.77 info memory | grep used_memory_human: | awk -F ':' '{print $2}')  
USEDMEMORY_78=$(redis-cli -h 192.168.119.78 info memory | grep used_memory_human: | awk -F ':' '{print $2}')  
USEDMEMORY_76=$(redis-cli -h 192.168.119.76 -p 6379 info memory | grep used_memory_human: | awk -F ':' '{print $2}')  
USEDMEMORY_117=$(redis-cli -h 192.168.119.118 -p 6379 info memory | grep used_memory_human: | awk -F ':' '{print $2}')  
USEDMEMORY_118=$(redis-cli -h 192.168.119.118 -p 7379 info memory | grep used_memory_human: | awk -F ':' '{print $2}')  
  
WARN_COUNT=1  
WARM_G=3  
  
MEM_ARR=($USEDMEMORY_77 $USEDMEMORY_78 $USEDMEMORY_76 $USEDMEMORY_117 $USEDMEMORY_118)  
IP_ARR=("192.168.119.77:6379" "192.168.119.78:6379" "192.168.119.76:6379" "192.168.119.118:6379" "192.168.119.118:7379")  
ARR_LENGTH=${#IP_ARR[@]}  
  
for((i=1;i<$ARR_LENGTH;i++))  
do  
  
data=${MEM_ARR[i]}  
  
mem_c=$(echo $data |grep 'G'|wc -l)  
if [ "$mem_c" -eq "$WARN_COUNT" ]  
then  
mem=$(echo $data | cut -f 1 -d "G" | cut -f 1 -d ".")  
if [ "$mem" -ge "$WARN_G" ]  
then  
vmessage="{\"mobile\":[\"134*********\"],\"content\": \"[WARN] redis内存使用量:$mem G , ,Node:${IP_ARR[i]}\"}"  
echo $vmessage  
/opt/monitor/udpclient "*********" "10086" "$vmessage"  
fi  
fi  
  
done   




