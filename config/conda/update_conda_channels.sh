#!/bin/bash

# 定义目标 URL 和 condarc 文件路径
BASE_URL="https://mirrors.tuna.tsinghua.edu.cn/anaconda"
CONDARC_FILE="$HOME/.config/conda/condarc"

# 获取 pkgs 目录下的文件夹列表，并过滤掉 http 开头的和 ..
pkgs_folders=$(curl -s $BASE_URL/pkgs/ | grep -oP '(?<=href=")[^"]+(?=/")' | grep -v 'Parent Directory' | grep -v '^http' | grep -v '^\.\.$')

# 获取 cloud 目录下的文件夹列表，并过滤掉 http 开头的和 ..
cloud_folders=$(curl -s $BASE_URL/cloud/ | grep -oP '(?<=href=")[^"]+(?=/")' | grep -v 'Parent Directory' | grep -v '^http' | grep -v '^\.\.$')

# 备份原始 condarc 文件
cp "$CONDARC_FILE" "${CONDARC_FILE}.bak"

# 生成 default_channels 部分
default_channels="default_channels:"
for folder in $pkgs_folders; do
    default_channels+="\n  - $BASE_URL/pkgs/$folder"
done

# 生成 custom_channels 部分
custom_channels="custom_channels:"
for folder in $cloud_folders; do
    custom_channels+="\n  $folder: $BASE_URL/cloud"
done

# 将 default_channels 和 custom_channels 部分写入 condarc 文件
awk -v default_channels="$default_channels" -v custom_channels="$custom_channels" '
    BEGIN { in_default_channels = 0; in_custom_channels = 0 }
    /^default_channels:/ { in_default_channels = 1; print default_channels; next }
    /^custom_channels:/ { in_custom_channels = 1; print custom_channels; next }
    in_default_channels && /^[^ ]/ { in_default_channels = 0 }
    in_custom_channels && /^[^ ]/ { in_custom_channels = 0 }
    !in_default_channels && !in_custom_channels { print }
' "$CONDARC_FILE" > "${CONDARC_FILE}.tmp"

# 替换原始 condarc 文件
mv "${CONDARC_FILE}.tmp" "$CONDARC_FILE"

echo "Updated $CONDARC_FILE with default_channels and custom_channels from $BASE_URL"