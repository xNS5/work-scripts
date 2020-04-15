#!/usr/bin/bash

addr="140.160.164.232"

#printf "Bonjour Name,Computer Name,OS Version,Available Disk Space,Total Disk Space,Percent Used,Percent Available,IP Address,Last User\n" >> computer_info.csv
#if [[ ! $1 ]]; then
#  echo "Please drag and drop text file: "
#  read -r path
#else
#  path="$1"
#fi
#while read -r addr
#do
   output="$(ssh vumaint@"$addr" 'bash -s' < computer_info.sh)"
   deviceName="$(echo "$output" | sed -n '2 p')"
   deviceInfo="$("")"

#done < "$path"
