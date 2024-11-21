#!/bin/bash

USERNAME=$(whoami)  # 取得用戶名稱
SOURCE_IP=${SOURCE_IP:-$(hostname -I | awk '{print $1}')}  # 來自哪台機器，如果沒有提供，則使用當前機器的 IP 地址
TARGET_IP=${TARGET_IP:-172.21.148.163}  # 同步到哪台機器
DELETE_NOT_EXIST=${DELETE_NOT_EXIST:-false}  # 默認不刪除目標目錄中來源目錄沒有的檔案
EXCLUDE_FOLDERS=(**/.venv **/__pycache__ **/.cache)  # 在這裡添加你要排除的資料夾

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

# 構建來源目錄
SOURCE_DIR=""
if [ "$SOURCE_IP" = "$(hostname -I | awk '{print $1}')" ]; then
    SOURCE_DIR="~/"
else
    SOURCE_DIR="$USERNAME@$SOURCE_IP:~/"
fi

echo "Syncing files to $USERNAME's home directory on $TARGET_IP"
echo "Excluding folders: ${EXCLUDE_FOLDERS[@]}"
echo "Delete not exist: $DELETE_NOT_EXIST"
echo "Source directory: $SOURCE_DIR"

eval rsync -avz --progress $EXCLUDE_OPTIONS $DELETE_OPTION $SOURCE_DIR $USERNAME@$TARGET_IP:~/
