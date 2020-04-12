#!/usr/bin/bash


echo -n "Please drag and drop .txt file here: "
read -r path
#printf "Bonjour Name,Computer Name,OS Version,Available Disk Space,Total Disk Space,Percent Used,Percent Available,IP Address,Last User\n" >> computer_info.csv 
while read -r addr
do
   output="$(ssh vumaint@"$addr" 'bash -s' < app-info.sh < get-info.sh | tr '\n' ',')"
   machineInfo="$(echo "$output" | tail -9)"
   echo "$machineInfo"
done < $path
