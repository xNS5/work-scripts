#!/usr/bin/bash

# Bonjour Name
echo -n "Bonjour Name: "
scutil --get LocalHostName

# Computer Name
echo -n "Computer Name: "
scutil --get ComputerName

# OS Version
echo -n "OS Version: "
sw_vers -productVersion


# Disk Space Information

echo "DISK INFO:"
echo 

AVAILABLE="$(system_profiler SPStorageDataType | grep -m1 "Available" | xargs)"
CAPACITY="$(system_profiler SPStorageDataType | grep -m1 "Capacity" | xargs)"
availableLen="${#AVAILABLE}"

if [[ $availableLen -ne 0 ]];
then
   echo -n "Space "
   echo $AVAILABLE
   echo -n "Space "
   echo $CAPACITY
   BITSFREE="$(echo $AVAILABLE | awk '{print $4}' | sed  's/[^0-9]*//g')"
   BITSTOTAL="$(echo $CAPACITY | awk '{print $4}' | sed 's/[^0-9]*//g')"
   printf "Percent Used: %.2f%s\n" "$(bc <<< "scale=4; (1-($BITSFREE/$BITSTOTAL))*100")"
   printf "Percent Free: %.2f%s\n" "$(bc <<< "scale=4; ($BITSFREE/$BITSTOTAL)*100")"

else
   FREE="$(system_profiler SPStorageDataType | grep -m1 "Free" | xargs)"
   echo -n "Space "
   echo $FREE
   echo -n "Total "
   echo $CAPACITY
   BITSFREE="$(echo $FREE | awk '{print $4}' | sed  's/[^0-9]*//g')"
   BITSTOTAL="$(echo $CAPACITY | awk '{print $4}' | sed 's/[^0-9]*//g')"
   printf "Percent Used: %.2f%s\n" "$(bc <<< "scale=4; (1-($BITSFREE/$BITSTOTAL))*100")"
   printf "Percent Free: %.2f%s\n" "$(bc <<< "scale=4; ($BITSFREE/$BITSTOTAL)*100")"
   
fi
echo

# Computer IP address
echo -n "IP Address: "
ifconfig en0 | grep "inet " | awk '{print $2}'


# Last user signed in
echo -n "Last user: "
last -1 | awk '{print $1}'


