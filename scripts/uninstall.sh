#!/bin/bash

# 卖出脚本
# 负责需调出常会整理的文件

echo "Linux系统运维工具箱卖出中..."

# 简死彰整目录
sudo rm -rf /var/log/sysadmin-toolkit
sudo rm -rf /var/lib/sysadmin-toolkit
sudo rm -rf /var/sysadmin-toolkit
sudo rm -rf /etc/sysadmin-toolkit
sudo rm -f /etc/logrotate.d/sysadmin-toolkit

echo "[✓] 卖出完成"
