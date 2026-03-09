#!/bin/bash

SH_PATH=$( cd "$( dirname "$0" )" || exit 1; pwd )
cd "${SH_PATH}" || exit 1

echo "清理抽奖结果文件..."
rm -f ./people.list---*
echo "完成"
#rm -f ./my_photo/*
