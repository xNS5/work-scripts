#!/usr/bin/bash

appName=""
appVersion=0

while read -r line
do
#  set -x
   appName=$line
   appVersion="$(defaults read /Applications/"$appName"/Contents/Info.plist "CFBundleShortVersionString" 2>/dev/null)"
   if [[ $? -ne 0 ]]; then
      while read -r subLine
      do
         subVersion="$(defaults read "$subLine"/Contents/Info.plist "CFBundleShortVersionString" 2>/dev/null)"
         if [[ $? -eq 0 ]]; then
           appVersion="$subVersion"
           appName="$( "$subLine" |  sed -e 's/(\/Applications\/).*(\/)//g')"
        fi
     done< <(find /Applications/"$line"/* -maxdepth 0 | grep ".app")
   fi

   if [[ ${#appVersion} -ne 0 ]]; then
      printf "%s Version: %s\n" "$appName" "$appVersion"
   else
      printf "%s Version: N/A\n" "$appName"
   fi

#   set +x
done< <( find /Applications/* -maxdepth 0 2>/dev/null | sed -e 's/\/Applications\///g' | grep "Intel Power Gadget")


