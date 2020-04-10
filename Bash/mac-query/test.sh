#!/usr/bin/bash

while read -r line
do
  cd "$line" || echo "Failed at line 5"
  while read -r subline
  do
    echo "$subline"
    echo "$(defaults read "$subline"/Contents/Info.plist "CFBundleShortVersionString")"
  done< <(find "$line"/* -maxdepth 0)
done< <(find /Applications/* -maxdepth 0 2>/dev/null | grep "Utilities")
