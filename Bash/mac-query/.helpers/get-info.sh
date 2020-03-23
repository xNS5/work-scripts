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
echo -n "Total Disk Space: "
diskutil info disk1 | grep "Disk Size" | awk '{print $3}'

# Computer IP address
echo -n "IP Address: "
ifconfig en0 | grep "inet " | awk '{print $2}'


# Last user signed in
echo -n "Last user: "
last -1 | awk '{print $1}'


