#!/usr/bin/bash

appName=""
appVersion=""

while read -r line
do
   appName=$line
   appVersion="$(defaults read /Applications/"$line"/Contents/Info.plist "CFBundleShortVersionString" 2>/dev/null)"
   if [[ $? -ne 0 ]]; then
      while read -r subLine
      do
         subVersion="$(defaults read "$subline"/Contents/Info.plist "CFBundleShortVersionString")"
         echo "$subLine"
         if [[ $? -eq 0 ]]; then
           appVersion="$subVersion"
           appName="$subLine"
        fi
      done< <(find $line/* -maxdepth 0 2>/dev/null | grep -e ".app")
   fi

   if [[ ${#appVersion} -ne 0 ]]; then
      printf "%s Version: %s\n" "$appName" "$appVersion"
   fi
done< <( find /Applications/* -maxdepth 0 2>/dev/null | sed -e 's/\/Applications\///g' | grep -v -e "Python" | grep -v -e "Utilities")


