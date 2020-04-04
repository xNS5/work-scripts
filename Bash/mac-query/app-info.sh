#!/usr/bin/bash

#echo $(defaults read /Aplications/Runescape.app/Contents/Info.plist CFBundleShortVersionString) # this gets the application version information


while read -r line
do

   version="$(defaults read /Applications/"$line"/Contents/Info.plist "CFBundleShortVersionString")"
   printf "$line Version: %s\n" $version
done < <( ls -1 /Applications/ | grep -v "Utilities")
