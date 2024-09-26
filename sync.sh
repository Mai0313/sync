#!/bin/bash

USERNAME=$(whoami)
TARGET_IP=${1:-172.21.148.163}
EXCLUDE_FOLDERS=('.ssh')  # 在這裡添加你要排除的資料夾
DELETE_NOT_EXIST=${2:-false}  # 默認不刪除目標目錄中來源目錄沒有的檔案

echo "Syncing files to $USERNAME's home directory on $TARGET_IP"

# 構建 --exclude 選項
EXCLUDE_OPTIONS=""
for folder in "${EXCLUDE_FOLDERS[@]}"; do
    EXCLUDE_OPTIONS+="--exclude='$folder' "
done

# 構建 --delete 選項
DELETE_OPTION=""
if [ "$DELETE_NOT_EXIST" = true ]; then
    DELETE_OPTION="--delete"
fi

echo "Excluding folders: ${EXCLUDE_FOLDERS[@]}"
echo "Delete not exist: $DELETE_NOT_EXIST"

eval rsync -avz $EXCLUDE_OPTIONS $DELETE_OPTION ~/* $USERNAME@$TARGET_IP:~/
