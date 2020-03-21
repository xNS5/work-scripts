#!/usr/bin/bash

# Bonjour Name
scutil --get LocalHostName

# Computer Name
scutil --get ComputerName

# OS Version
sw_vers -productVersion

# Computer IP address
ifconfig en0 | grep "inet " | awk '{print 2}'

# Last user signed in
last -1 | awk '{print $1}'


