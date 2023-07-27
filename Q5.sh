#!/bin/bash

echo "Enter the directory name : "
read directName

if [ ! -d "$directName" ];then
    echo "Directory doesn't exist"
    exit 1
fi

echo "Directories under $directName"
ls "$directName"

echo -e "Files in sorted order: "
ls -v "$directName"

newDirect="$directName/sorted"
mkdir -p "$newDirect"

cnt=0
for file in "$directName"/*; do
    if [ -f "$file" ] && [ "$file" != "$newDirect" ]; then
        mv "$file" "$newDirect"
        ((cnt++))
    fi
done

echo -e "\n Success: $cnt files moved "