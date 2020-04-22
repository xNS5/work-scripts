#!/usr/bin/bash

if [[ ! $1 ]]; then
  echo -n "Please drag and drop text file: "
  read -r path
else
  path="${1##*( )}"
fi

printf "Bonjour Name,Computer Name,OS Version,RAM,Available Disk Space,Total Disk Space,Percent Used,Percent Available,IP Address,Last User\n" >> computer_info.csv
printf "Computer Name,Application Name, Application Version\n" >> application_info.csv

while read -r addr
do
   #set -x
   output="$(ssh vumaint@"$addr" 'bash -s' < computer_info.sh)"
   echo "$output" | sed -n '1 p' >> computer_info.csv
   echo "$output" | sed -n '2,$p' >> application_info.csv
   echo "Completed: $addr"
   #set -x
done < "$path"
