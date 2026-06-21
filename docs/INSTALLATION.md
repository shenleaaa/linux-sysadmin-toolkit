# 安装指南

## 前置要求

### 系统要求
- **操作系统**: Ubuntu 22.04 LTS / CentOS 8+ / Debian 11+
- **Bash版本**: 4.0+
- **内存**: 至少 2GB
- **磁盘空间**: 至少 500MB

### 常用工具
```bash
# 必须安装
grep, sed, awk, cut, sort, uniq, head, tail
cat, find, du, df, ps, top, who, last

# 可选安装
dialog, whiptail, pandoc, git
```

## 安装步骤

### 1. 克隆仓库

```bash
# 从可选的三1个克隆

# 使用GitHub
git clone https://github.com/shenleaaa/linux-sysadmin-toolkit.git

# 或使用Gitee
git clone https://gitee.com/username/linux-sysadmin-toolkit.git

cd linux-sysadmin-toolkit
```

### 2. 检查依赖

```bash
# 运行检查脚本
chmod +x scripts/install.sh
sudo ./scripts/install.sh --check

# 输出例子：
# [✓] grep - found
# [✓] awk - found  
# [✓] sed - found
# [⚠] dialog - not found (optional)
```

### 3. 安装依赖包

#### Ubuntu/Debian
```bash
sudo apt-get update
sudo apt-get install -y \
  coreutils \
  findutils \
  grep \
  sed \
  gawk \
  util-linux \
  procps \
  sysstat \
  dialog \
  whiptail
```

#### CentOS/RHEL
```bash
sudo yum install -y \
  coreutils \
  findutils \
  grep \
  sed \
  gawk \
  util-linux \
  procps-ng \
  sysstat \
  dialog
```

### 4. 安装工具箱

```bash
# 方法1：使用安装脚本
chmod +x scripts/install.sh
sudo ./scripts/install.sh

# 方法2：手动安装
chmod +x modules/*/*.sh
chmod +x main_controller/*.sh

# 测试安装
./main_controller/main.sh
```

### 5. 配置系统

```bash
# 复制配置文件
sudo cp config/defaults.conf /etc/sysadmin-toolkit/

# (可选)修改配置
sudo vi /etc/sysadmin-toolkit/defaults.conf

# 检查配置
./main_controller/main.sh --config
```

### 6. 设置揃谪日志

```bash
# 创建日志目录
sudo mkdir -p /var/log/sysadmin-toolkit
sudo chmod 755 /var/log/sysadmin-toolkit

# 设置日志轮转
sudo tee /etc/logrotate.d/sysadmin-toolkit > /dev/null <<EOF
/var/log/sysadmin-toolkit/*.log {
    daily
    rotate 30
    compress
    delaycompress
    missingok
    notifempty
    create 0644 root root
    sharedscripts
}
EOF
```

### 7. 验证安装

```bash
# 一转验证
./scripts/install.sh --verify

# 上位每个模块
chmod +x tests/test_runner.sh
./tests/test_runner.sh
```

## 不一样的系统需特别注意

### Ubuntu 22.04
```bash
# 阐值配置位置
/var/log/auth.log        # 认证日志
/var/log/syslog          # 系统日志
```

### CentOS 8/9
```bash
# 阐值配置位置
/var/log/secure          # 认证日志
/var/log/messages        # 系统日志
```

## 卸载

```bash
# 卸载工具箱
sudo ./scripts/uninstall.sh

# 清理日志和配置
rm -rf /var/log/sysadmin-toolkit
sudo rm -rf /etc/sysadmin-toolkit
```

## 故障排除

### 问题: 没有提取足够的权限
```bash
# 重新营需shell不作为不同的用户
 bash
```

### 问题: 命令找不到
```bash
# 检查你的路径
export PATH=$PATH:/bin:/usr/bin:/usr/local/bin
```

### 问题: 脚本不执行
shell脚本需要执行权限
```bash
chmod +x *.sh
```

---

**安装指南版本：** 1.0  
**最后更新：** 2026年6月21日