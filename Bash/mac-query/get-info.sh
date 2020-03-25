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
available="$(system_profiler SPStorageDataType | grep -m1 "Available" | xargs)"
free="$(system_profiler SPStorageDataType | grep -m1 "Free" | xargs)"
capacity="$(system_profiler SPStorageDataType | grep -m1 "Capacity" | xargs)"
availableLen="${#available}"

if [[ $availableLen -ne 0 ]];
then
   echo $available
   echo $capacity
else
   echo $free
   echo $capacity
   
fi

# Computer IP address
echo -n "IP Address: "
ifconfig en0 | grep "inet " | awk '{print $2}'


# Last user signed in
echo -n "Last user: "
last -1 | awk '{print $1}'


