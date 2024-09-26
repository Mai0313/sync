#!/bin/bash

USERNAME=$(whoami)
TARGET_IP=${1:-172.21.148.163}
EXCLUDE_FOLDERS=('.ssh')  # 在這裡添加你要排除的資料夾

echo "Syncing files to $USERNAME's home directory on $TARGET_IP"

# 構建 --exclude 選項
EXCLUDE_OPTIONS=""
for folder in "${EXCLUDE_FOLDERS[@]}"; do
    EXCLUDE_OPTIONS+="--exclude='$folder' "
done

echo "Excluding folders: ${EXCLUDE_FOLDERS[@]}"

eval rsync -avz $EXCLUDE_OPTIONS ~/* $USERNAME@$TARGET_IP:~/
