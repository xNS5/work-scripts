#!/usr/bin/bash

# Bonjour Name
scutil --get LocalHostName

# Computer Name
scutil --get ComputerName

# OS Version
sw_vers -productVersion

# Disk Space Information 

AVAILABLE="$(system_profiler SPStorageDataType | grep -m1 "Available" | xargs)"
CAPACITY="$(system_profiler SPStorageDataType | grep -m1 "Capacity" | xargs)"
availableLen="${#AVAILABLE}"

# MacOS Catalina differs from Mojave in that it uses "free" instead of "available" when doing a system_profiler query
if [[ $availableLen -ne 0 ]];
then
   #Total available space
   echo $AVAILABLE | awk '{print $2 " " $3}'
   #Total space capacity
   echo $CAPACITY | awk '{print $2 " " $3}'
   BITSFREE="$(echo $AVAILABLE | awk '{print $4}' | sed  's/[^0-9]*//g')"
   BITSTOTAL="$(echo $CAPACITY | awk '{print $4}' | sed 's/[^0-9]*//g')"
   # Percent Used
   printf "%.2f%s\n" "$(bc <<< "scale=4; (1-($BITSFREE/$BITSTOTAL))*100")"
   # Percent Free
   printf "%.2f%s\n" "$(bc <<< "scale=4; ($BITSFREE/$BITSTOTAL)*100")"
   
else
   FREE="$(system_profiler SPStorageDataType | grep -m1 "Free" | xargs)"
   #Space Free
   echo $FREE | awk '{print $2 " " $3}'
   #Total Capacity
   echo $CAPACITY | awk '{print $2 " " $3}'

   BITSFREE="$(echo $FREE | awk '{print $4}' | sed  's/[^0-9]*//g')"
   BITSTOTAL="$(echo $CAPACITY | awk '{print $4}' | sed 's/[^0-9]*//g')"
   # Percent Used
   printf "%.2f%s\n" "$(bc <<< "scale=4; (1-($BITSFREE/$BITSTOTAL))*100")"
   #Percent Free
   printf "%.2f%s\n" "$(bc <<< "scale=4; ($BITSFREE/$BITSTOTAL)*100")"
fi

# Computer IP address
ifconfig en0 | grep "inet " | awk '{print $2}'

# Last user signed in
last -2 | grep -v -e 'reboot' -e 'shutdown' | awk '{print $1}' | sed -n '2 p'

appName=""
appVersion=0

while read -r line
do
   #set -x
   appName="$line"
   appVersion="$(defaults read /Applications/"$line"/Contents/Info.plist "CFBundleShortVersionString" 2>/dev/null)"
   if [[ $? -ne 0 ]]; then
      while read -r subLine
      do
      #   if [[ "$line"
         subVersion="$(defaults read "$subLine"/Contents/Info.plist "CFBundleShortVersionString" 2>/dev/null)"
         if [[ $? -eq 0 ]]; then
           appVersion="$subVersion"
           appName="$(echo "$subLine" | sed -E 's/(\/Applications\/)(.*\/)//g')"
         fi
     done< <(find /Applications/"$line"/* -maxdepth 0 2>/dev/null)
   fi

   if [[ ${#appVersion} -ne 0 && ${#appName} -ne 0 ]]; then
      printf "%s Version: %s\n" "$appName" "$appVersion"
   else
      printf "%s Version: N/A\n" "$appName"
   fi
   #set +x
done< <( find /Applications/* -maxdepth 0 2>/dev/null | sed -e 's/\/Applications\///g')


