#/bin/bash
#filename: find_max_file.sh
#date: 2016/4/14
#author: eyanchao

a=0
for  name in *.*
do
     b=$(ls -l $name | awk '{print $5}')
    if test $b -ge $a
    then a=$b
         namemax=$name
     fi
done
echo "the max file is $namemax"




