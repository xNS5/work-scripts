#!/usr/bin/bash

addr="140.160.164.232"

#printf "Bonjour Name,Computer Name,OS Version,Available Disk Space,Total Disk Space,Percent Used,Percent Available,IP Address,Last User\n" >> computer_info.csv 
#while read -r addr
#do
   #deviceInfo="$(ssh vumaint@"$addr" 'bash -s' < get-info.sh)"
   #appInfo="$(ssh vumaint@"$addr" 'bash -s' < app-info.sh)"
   output="$(ssh vumaint@"$addr" 'bash -s' < computer_info.sh)"
   echo "$output"
#done < $path
