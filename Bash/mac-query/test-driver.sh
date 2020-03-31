#!/usr/bin/bash

printf "Bonjour Name,Computer Name,OS Version,Available Disk Space,Total Disk Space,Percent Used,Percent Available,IP Address,Last User\n" >> output.csv

var="$( bash test.sh  | tr '\n' ',')"
echo ${var:: -1} >> output.csv

