#!/usr/bin/env bash

TARGET_LABEL="Data"
TARGET_UUID="01D53A0C57BF6FC0"
TARGET_SIZE="931.5G"

devices=$(lsblk -o name,label,uuid,size,mountpoint)

while read -r line; do
    # name=$(echo "$line" | awk '{print $1}')
    # label=$(echo "$line" | awk '{print $2}')
    # uuid=$(echo "$line" | awk '{print $3}')
    # size=$(echo "$line" | awk '{print $4}')
    # mountpoint=$(echo "$line" | awk '{print $5}')

    read -r name label uuid size mountpoint <<< "$line"

    if [ "$label" == "$TARGET_LABEL" ] &&
       [ "$uuid" == "$TARGET_UUID" ] &&
       [ "$size" == "$TARGET_SIZE" ] &&
       [ -z "$mountpoint" ] &&  # zero length
       [ "$prev_name" == "${name:2:-1}" ]
    then
        target="/dev/${name#??}"
        udisksctl mount --block-device=$target
        echo "mounted target: $target"
        break
    fi

    prev_name=$name

    echo "name=\"$name\", label=\"$label\", uuid=\"$uuid\", size=\"$size\", mountpoint=\"$mountpoint\" prev_name=\"$prev_name\""
    echo
done <<< "$devices"

