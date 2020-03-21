#!/usr/bin/bash

# Bonjour Name
scutil --get LocalHostName

# Computer Name
scutil --get ComputerName

# OS Version
sw_vers -productVersion

# Disk Space Information
# Main disk on iMac Machines is /dev/disk2
# Ask Jeremy on Monday about other machines on VU network

# Computer IP address
ifconfig en0 | grep "inet " | awk '{print 2}'


# Last user signed in
last -1 | awk '{print $1}'


