#!/usr/bin/bash

echo -n "Please drag and drop .txt file here: "
read path
echo
echo -n "Please input Vumaint password: "
read -s  password
echo
while IFS= read -r line;
do
   echo $line
done < temp.txt
echo "Beginning Program"


