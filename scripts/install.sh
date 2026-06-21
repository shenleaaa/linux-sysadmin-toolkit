#!/bin/bash

# 安装脚本
# 此脚本负责检查依赖、创建目录和配置系统

set -e

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${GREEN}==== Linux系统运维工具箱安装脚本 ====${NC}"

# 检查常用命令
echo -e "${YELLOW}[*] 检查依赖...${NC}"

commands=("grep" "awk" "sed" "grep" "find" "du" "df" "ps" "top" "who" "last")

for cmd in "${commands[@]}"; do
    if command -v "$cmd" &> /dev/null; then
        echo -e "${GREEN}[✓]${NC} $cmd - 找到"
    else
        echo -e "${RED}[✗]${NC} $cmd - 未找到、下载中..."
    fi
done

# 创建必要的目录
echo -e "${YELLOW}[*] 创建目录...${NC}"

sudo mkdir -p /var/log/sysadmin-toolkit
sudo mkdir -p /var/lib/sysadmin-toolkit/cache
sudo mkdir -p /var/sysadmin-toolkit/reports
sudo mkdir -p /etc/sysadmin-toolkit

echo -e "${GREEN}[✓]${NC} 目录创建完成"

# 复制配置文件
echo -e "${YELLOW}[*] 下载配置文件...${NC}"

if [ -f "config/defaults.conf" ]; then
    sudo cp config/defaults.conf /etc/sysadmin-toolkit/
    echo -e "${GREEN}[✓]${NC} 配置文件复制完成"
else
    echo -e "${YELLOW}[⚠]${NC} 不是在项目主目录中执行。下载配置文件失败。"
fi

# 设置文件权限
echo -e "${YELLOW}[*] 设置文件权限...${NC}"

chmod +x modules/*/*.sh 2>/dev/null || true
chmod +x main_controller/*.sh 2>/dev/null || true
chmod +x scripts/*.sh 2>/dev/null || true

sudo chown -R root:root /var/log/sysadmin-toolkit
sudo chown -R root:root /var/lib/sysadmin-toolkit
sudo chown -R root:root /var/sysadmin-toolkit
sudo chmod 755 /var/log/sysadmin-toolkit
sudo chmod 755 /var/lib/sysadmin-toolkit
sudo chmod 755 /var/sysadmin-toolkit

echo -e "${GREEN}[✓]${NC} 权限设置完成"

# 验证安装
echo -e "${YELLOW}[*] 验证安装...${NC}"

if [ -x "./main_controller/main.sh" ]; then
    echo -e "${GREEN}[✓]${NC} 安装成功！运行 ‘./main_controller/main.sh’ 何变为待次。"
else
    echo -e "${RED}[✗]${NC} 安装失败。下载基文件权限。"
fi

echo -e "${GREEN}==== 安装完成 ====${NC}"
