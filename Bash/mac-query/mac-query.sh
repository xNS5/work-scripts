#!/usr/bin/bash

#set -x
#if [[ $1 ]]; then
#    file=$1
#else
#  echo -n "Please drag and drop text file: "
#  read -r file
#fi
Sanitizing Input


#printf "Bonjour Name,Computer Name,OS Version,RAM,Available Disk Space,Total Disk Space,Percent Used,Percent Available,IP Address,Last User\n" >> computer_info.csv
#printf "Computer Name,Application Name, Application Version\n" >> application_info.csv

while read -r addr
do
      if [[ ${#addr} -ne 0 ]]; then
        printf "Beginning Query On: %s\n" "$addr"
        start="$(date +%s)"
        output="$(ssh vumaint@"$addr" 'bash -s' < computer_info.sh)"
        echo "$output" | sed -n '1 p' >> computer_info.csv
        echo "$output" | sed -n '2,$p' >> application_info.csv
        end="$(date +%s)"
        printf "Completed: $addr\n Time: %s seconds\n" "$((end-start))"
    fi
done < "$file"
#set +x