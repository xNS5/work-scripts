#!/usr/bin/bash

#echo $(defaults read /Aplications/Runescape.app/Contents/Info.plist CFBundleShortVersionString) # this gets the application version information


function main(){
while read -r line
do
  if [[ "$line" != "Utilities" || "$line" != "Python" ]]; then
   version="$(defaults read /Applications/"$line"/Contents/Info.plist "CFBundleShortVersionString" 2>/dev/null)"
   printf "$line Version: %s\n" $version
 fi
done< <( ls -1 /Applications/ )
}

function subVersion(){
  echo "Hello!"
}

main
