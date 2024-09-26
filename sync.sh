#!/bin/bash

USERNAME=$(whoami)  # 取得用戶名稱
SOURCE_IP=${SOURCE_IP:-$(hostname -I | awk '{print $1}')}  # 來自哪台機器，如果沒有提供，則使用當前機器的 IP 地址
TARGET_IP=${TARGET_IP:-172.21.148.163}  # 同步到哪台機器
DELETE_NOT_EXIST=${DELETE_NOT_EXIST:-false}  # 默認不刪除目標目錄中來源目錄沒有的檔案
EXCLUDE_FOLDERS=()  # 在這裡添加你要排除的資料夾

echo "Syncing files to $USERNAME's home directory on $TARGET_IP"

# 構建 --exclude 選項
EXCLUDE_OPTIONS=()
for folder in "${EXCLUDE_FOLDERS[@]}"; do
    EXCLUDE_OPTIONS+=("--exclude=$folder")
done

# 構建 --delete 選項
DELETE_OPTION=""
if [ "$DELETE_NOT_EXIST" = true ]; then
    DELETE_OPTION="--delete"
fi

echo "Excluding folders: ${EXCLUDE_FOLDERS[@]}"
echo "Delete not exist: $DELETE_NOT_EXIST"

# 構建來源目錄
SOURCE_DIR=""
if [ "$SOURCE_IP" = "$(hostname -I | awk '{print $1}')" ]; then
    SOURCE_DIR="~"
else
    SOURCE_DIR="$USERNAME@$SOURCE_IP:~"
fi

# 使用 rsync 同步檔案，包含隱藏文件和文件夾
rsync -avz "${EXCLUDE_OPTIONS[@]}" $DELETE_OPTION --include='.*' --include='*/' --exclude='*' $SOURCE_DIR/ $USERNAME@$TARGET_IP:~/
