#!/usr/bin/bash

tempIP="140.160.164.232"

# echo -n "Please drag and drop .txt file here: "
# read path
echo
ssh vumaint@$tempIP 'bash -s' < get-info.sh
