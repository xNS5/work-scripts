#!/usr/bin/bash

#tempIP="140.160.164.232"

echo -n "Please drag and drop .txt file here: "
read path
printf "Bonjour Name,Computer Name,OS Version,Available Disk Space,Total Disk Space,Percent Used,Percent Available,IP Address,Last User\n" >> output.csv 
for addr in $path;
do
   output="$(ssh vumaint@$addr 'bash -s' < get-info.sh | tr '\n' ',')"
   echo ${output::-1} >> output.csv
done
