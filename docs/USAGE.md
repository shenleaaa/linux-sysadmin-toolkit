# 使用指南

## 定位和概述

Linux系统运维工具箱是一个全面的系统管理套件，提供常绋的性能监控、安全审计和宜关火。

## 快速开始

### 启动主程序

```bash
./main_controller/main.sh
```

欢迎欥春！会看到一个交互式菜单：

```
╔════════════════════════════════════════════════════════════════╗
║              Linux系统运维工具箱 v1.0                            ║
║                                                                ║
║          智能监控 • 审计追踪 • 分析诊断                          ║
╚════════════════════════════════════════════════════════════════╝

请选择功能 [1-9]: _
```

## 模块使用

### 模块一：系统性能监控

监控你的Linux系统性能指标。

#### 使用方法1：交互菜单
```bash
./main_controller/main.sh
# 选择 1 -> 系统性能监控
# 选择 子菜单项 (1-3)
```

#### 使用方法2：直接运行
```bash
# CPU监控
./modules/monitor/cpu_monitor.sh [interval] [count]

# 内存批译
./modules/monitor/memory_monitor.sh [warning_pct] [critical_pct]

# 进程排行
./modules/monitor/process_top.sh [sort_by] [limit]
```

#### 示例
```bash
# 监控CPU，每2秒采样一次，采样怅20次
./modules/monitor/cpu_monitor.sh 2 20

# 检查内存，警告阈值70%，严重阈值85%
./modules/monitor/memory_monitor.sh 70 85

# 显示消耗内存10个最多的进程
./modules/monitor/process_top.sh memory 10
```

### 模块二：用户活动追踪

监控用户登录活动、希论操作上sudo使用。

#### 使用方法
```bash
# 实时监控登录会话 (每5秒刷新一次)
./modules/user_tracker/session_monitor.sh

# 审计最近7天的登录记录
./modules/user_tracker/login_audit.sh 7

# 检查所有权限配置
./modules/user_tracker/privilege_check.sh all
```

### 模块三：文件系统扫描

扫描文件系统不安全因素。

#### 使用方法
```bash
# 检查所有挂载点的磁盘使用
./modules/filesystem_scanner/space_alert.sh

# 查找并清理100MB以上的30天未修改文件
./modules/filesystem_scanner/cleanup.sh / 100M 30

# 进行完整的安全扫描
./modules/filesystem_scanner/security_scan.sh all
```

### 模块四：日志分析

实时知性日志变化。

#### 使用方法
```bash
# 实时追踪系统日志中的ERROR
./modules/log_analyzer/realtime_filter.sh /var/log/syslog "" ERROR

# 分析上个月的日志
./modules/log_analyzer/log_classify.sh /var/log 30

# 执行日志归档和压缩
./modules/log_analyzer/log_archive.sh /var/log /var/log/archive 30
```

## 高级特性

### 定时任务调度

#### 添加crontab任务
```bash
# 打开编辑
crontab -e

# 添加每天晨1点执行是否有最近的日志
0 1 * * * /home/user/linux-sysadmin-toolkit/modules/log_analyzer/log_archive.sh /var/log /var/log/archive 30

# 每圲5个小时检查一次空间
0 */5 * * * /home/user/linux-sysadmin-toolkit/modules/filesystem_scanner/space_alert.sh
```

### 生成报告

```bash
# 从菜单中选择「报告生成」
./main_controller/main.sh
# 选择 6 -> 报告生成

# 或直接运行
./modules/main_controller/report_gen.sh daily html
```

## 常见任务1一解

### Q: 执行脚本提示整欺权
**A:** 不是所有操作都需要root。某些操作需要高权限：
```bash
sudo ./modules/user_tracker/login_audit.sh  # 需要使用sudo
./modules/monitor/cpu_monitor.sh  # 不需要
```

### Q: 在其他系统上运行感觉慢
**A:** 优化配置：
```bash
# 编辑配置文件
vi config/defaults.conf

# 加大采样间隔
CPU_MONITOR_INTERVAL=10  # 改为10秒
MONITOR_INTERVAL=20      # 改为20秒
```

### Q: 找不到某些日志文件
**A:** 查看你的发行版，不同发行爱好用不同的位置：
- Ubuntu: `/var/log/auth.log`, `/var/log/syslog`
- CentOS: `/var/log/secure`, `/var/log/messages`

## 最佳实践

### 定需运行常也的任务
```bash
# 例子：每天下午06:00执行一次全面扫描
crontab -e
# 会话会扡打开: 0 6 * * * /path/to/modules/main_controller/main.sh --all --report
```

### 定日备份事记
```bash
# 每周一准打备份不同的配置文件
0 0 * * 0 tar -czf /backup/toolkit-config-$(date +\%Y\%m\%d).tar.gz /etc/sysadmin-toolkit/
```

---

**使用指南版本：** 1.0  
**最后更新：** 2026年6月21日