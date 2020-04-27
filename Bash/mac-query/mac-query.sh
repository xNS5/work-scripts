#!/usr/bin/bash

#set -x
set -m
if [[ $1 ]]; then
    file=$1
else
  echo -n "Please drag and drop text file: "
  read -r file
fi

printf "Bonjour Name,Computer Name,OS Version,RAM,Available Disk Space,Total Disk Space,Percent Used,Percent Available,IP Address,Last User\n" >> computer_info.csv
printf "Computer Name,Application Name, Application Version\n" >> application_info.csv

overallStart="$(date +%s)"
while IFS= read -r addr || [ -n "$addr" ];
do
        start="$(date +%s)"
        printf "Beginning Query On: %s\n" "$addr"
        output="$(ssh vumaint@"$addr" 'bash -s' < computer-info.sh &)"
        echo "$output" | sed -n '1 p' >> computer_info.csv
        echo "$output" | sed -n '2,$p' >> application_info.csv
        wait
        end="$(date +%s)"
        printf "Completed: $addr\nTime: %s seconds\n" "$((end-start))"
done < "$file"
overallEnd="$(date +%s)"
#set +x

printf "Finished in: %s seconds" "$((overallEnd-overallStart))"