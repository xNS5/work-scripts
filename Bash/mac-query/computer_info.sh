#!/usr/bin/bash

# Bonjour Name
printf "%s," "$(scutil --get LocalHostName)"

# Computer Name
printf "%s," "$(scutil --get ComputerName)"

# OS Version
printf "%s," "$(sw_vers -productVersion)"

# RAM
printf "%s," "$(system_profiler SPHardwareDataType | grep "Memory:" | awk '{print $2 $3}')"
#=======================================================================================================================
# Disk Space Information 
#=======================================================================================================================
available="$(system_profiler SPStorageDataType | grep -m1 "Available" | xargs)"
capacity="$(system_profiler SPStorageDataType | grep -m1 "Capacity" | xargs)"
availableLen="${#available}"

# MacOS Catalina differs from Mojave in that it uses "free" instead of "available" when doing a system_profiler query
if [[ $availableLen -ne 0 ]];
then
   #Total available space
   printf "%s," "$( echo "$available" | awk '{print $2 $3}' )"
   #Total space capacity
   printf "%s," "$(echo "$capacity" | awk '{print $2 $3}')"
   BITSFREE="$(echo "$available" | awk '{print $4}' | sed  's/[^0-9]*//g')"
   BITSTOTAL="$(echo "$capacity" | awk '{print $4}' | sed 's/[^0-9]*//g')"
   # Percent Used
   printf "%.2f," "$(bc <<< "scale=4; (1-($BITSFREE/$BITSTOTAL))*100")"
   # Percent Free
   printf "%.2f," "$(bc <<< "scale=4; ($BITSFREE/$BITSTOTAL)*100")"
   
else
   free="$(system_profiler SPStorageDataType | grep -m1 "Free" | xargs)"
   #Space Free
   printf "%s," "$(echo "$free" | awk '{print $2 $3}')"
   #Total Capacity
   echo "$capacity"| awk '{print $2 $3}'

   BITSFREE="$(echo "$free" | awk '{print $4","}' | sed  's/[^0-9]*//g')"
   BITSTOTAL="$(echo "$capacity" | awk '{print $4","}' | sed 's/[^0-9]*//g')"
   # Percent Used
   printf "%.2f," "$(bc <<< "scale=4; (1-($BITSFREE/$BITSTOTAL))*100")"
   #Percent Free
   printf "%.2f," "$(bc <<< "scale=4; ($BITSFREE/$BITSTOTAL)*100")"
fi

#=======================================================================================================================

# Computer IP address
printf "%s," "$(ifconfig en0 | grep "inet " | awk '{print $2}')"

# Last user signed in
printf "%s\n" "$(last -2 | grep -v -e 'reboot' -e 'shutdown' | awk '{print $1}' | sed -n '2 p')"

#=======================================================================================================================
# Application Information: Name and Version
#=======================================================================================================================
# Getting application name and version information from /Applications folder
appName=""
appVersion=0

# Printing out the computer name to associate apps with a computer
printf "%s" "$(scutil --get ComputerName)"
# Line is the name of an application located in a computer's /Applications folder
while read -r line
do
   #set -/+x is used for debugging.
#   set -x
   appName="$line"

   # appVersion is the captured output from defaults read... and checks for number associated with "CFBundleShortVersionString".
   # 2>/dev/null suppresses errors in the event that a CFBundleShortVersionString isn't found (which is expected behavior)

   # $? checks the exit status of the previously run command and moves 1 level deeper into .app file.
   # This is required for Adobe and some other applications.
   appVersion="$(defaults read /Applications/"$line"/Contents/Info.plist "CFBundleShortVersionString" 2>/dev/null)"
   if [[ ! $appVersion ]]; then
      while read -r subLine
      do
         subVersion="$(defaults read "$subLine"/Contents/Info.plist "CFBundleShortVersionString" 2>/dev/null)"
         if [[ $subVersion ]]; then
           appVersion="$subVersion"
           # Cleaning up the application's name
           appName="$(echo "$subLine" | sed -E 's/(\/Applications\/)(.*\/)//g')"
         fi
     done< <(find /Applications/"$line"/* -maxdepth 0 2>/dev/null)
   fi

  # Removing .app extension
  # Note: Some computers have an extension called ".appdownload".
  if [[ $appName != *".appdownload" ]]; then
    appName="${appName//.app/}"
   fi
   # Checks if both appVersion and appName are valid
   if [[ $appVersion && $appName ]]; then
      printf ",%s,%s\n" "$appName" "$appVersion"
   else
      printf ",%s,N/A\n" "$appName"
   fi
#   set +x
done< <( find /Applications/* -maxdepth 0 2>/dev/null | sed -e 's/\/Applications\///g')

