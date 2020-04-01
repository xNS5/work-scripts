#!/usr/bin/bash

#profiler="$(system_profiler -detailLevel mini SPApplicationsDataType | grep -v -e "Get Info String" -e "Signed by" -e "Last Modified" -e "Obtained From" -e "Copyright")"

appNames="$(ls -1 /Applications/)"

#echo $(defaults read /Aplications/Runescape.app/Contents/Info.plist CFBundleShortVersionString)

for app in $appNames
do
   echo $app
done


