# Linux系统运维工具箱 - 架构设计文档

## 1. 系统架构概述

### 1.1 总体设计

本项目采用**分层模块化架构**，分为四个层次：

```
┌─────────────────────────────────────────────┐
│      用户交互层 (Module 5)                   │
│   交互菜单 + 任务调度 + 报告生成              │
├─────────────────────────────────────────────┤
│      功能模块层 (Modules 1-4)               │
│  性能监控 | 用户追踪 | 文件扫描 | 日志分析   │
├─────────────────────────────────────────────┤
│      公共库层 (lib/)                        │
│  通用函数 | 日志记录 | 颜色格式 | 参数验证   │
├─────────────────────────────────────────────┤
│      系统接口层                              │
│  /proc | /sys | 日志文件 | 系统命令          │
└─────────────────────────────────────────────┘
```

### 1.2 模块间通信

```
Main Controller (Module 5)
    ↓
    ├─→ Monitor Module (Module 1)
    ├─→ User Tracker Module (Module 2)
    ├─→ Filesystem Scanner Module (Module 3)
    └─→ Log Analyzer Module (Module 4)
    ↓
Common Library (lib/)
    ↓
System Interfaces
```

## 2. 核心模块设计

### 2.1 模块一：系统性能监控仪

**数据流：**
```
/proc/cpuinfo
    ↓
  cpu_monitor.sh
    ↓
CPU使用率 + 核心信息
    ↓
ASCII图表生成
    ↓
输出展示

/proc/loadavg → awk处理 → 负载计算 → 趋势图
/proc/meminfo → 内存计算 → 百分比 → 颜色告警
top/ps → 进程解�� → Top 5排序 → 资源占比
```

**关键函数：**
- `parse_cpu_info()` - 解析CPU信息
- `calc_load_average()` - 计算平均负载
- `get_memory_stats()` - 获取内存统计
- `get_top_processes()` - 获取Top进程
- `draw_ascii_chart()` - 绘制ASCII图表

### 2.2 模块二：用户活动追踪器

**数据流：**
```
实时会话
  ↓
/var/run/utmp → who命令 → 当前登录用户

登录审计
  ↓
/var/log/wtmp → last命令 → 登录历史
/var/log/auth.log → grep失败 → 失败次数

权限检查
  ↓
/etc/sudoers → 权限配置
/var/log/auth.log → sudo操作 → 审计日志
```

**关键函数：**
- `monitor_active_sessions()` - 监控活跃会话
- `audit_login_history()` - 审计登录历史
- `detect_brute_force()` - 检测暴力破解
- `check_sudo_operations()` - 检查sudo操作

### 2.3 模块三：文件系统扫描仪

**数据流：**
```
空间预警
  ↓
df -h → 磁盘使用率
du -sh → 目录大小
对比阈值 → 标记告警

大文件清理
  ↓
find -size → 大文件搜索
find -mtime → 时间过滤
交互确认 → 删除操作

安全扫描
  ↓
find -perm → 权限检查
异常SUID/SGID → 标记可疑
全局可写 → 安全风险
```

**关键函数：**
- `check_disk_space()` - 检查磁盘空间
- `find_large_files()` - 查找大文件
- `cleanup_old_files()` - 清理旧文件
- `scan_world_writable()` - 扫描全局可写
- `check_suid_sgid()` - 检查异常权限位

### 2.4 模块四：日志分析引擎

**数据流：**
```
实时追踪
  ↓
tail -f /var/log/* → grep过滤 → sed高亮 → 显示

智能归类
  ↓
awk提取字段 → 按级别分类 → 统计计数 → 生成报告

日志归档
  ↓
find -mtime → 查找旧日志
tar -czf → 压缩归档
rm → 删除原文件
```

**关键函数：**
- `tail_filter()` - 实时日志过滤
- `classify_logs()` - 日志分类统计
- `highlight_errors()` - 错误高亮显示
- `archive_logs()` - 日志归档压缩
- `rotate_logs()` - 日志轮转

### 2.5 模块五：主控与调度中心

**功能流程：**
```
启动主程序
    ↓
加载配置 → 初始化环境
    ↓
┌─→ 交互菜单 (dialog/whiptail)
│      ↓
│   用户选择
│      ↓
│   手动执行模块
│
├─→ 定时任务 (crontab)
│      ↓
│   周期性执行
│      ↓
│   生成日报/周报
│
└─→ 守护进程 (Daemon)
       ↓
    后台持续监控
       ↓
    超过阈值告警
```

**关键函数：**
- `show_menu()` - 显示菜单
- `execute_module()` - 执行指定模块
- `schedule_task()` - 任务调度
- `generate_report()` - 生成报告
- `start_daemon()` - 启动守护进程

## 3. 公共库设计

### 3.1 lib/common.sh - 通用工具函数

```bash
# 系统信息获取
get_kernel_version()
get_system_uptime()
get_load_average()

# 文件操作
check_file_exists()
check_directory_exists()
safe_rm()

# 权限检查
check_root_privilege()
check_command_exists()

# 数值计算
round_number()
percentage()
format_bytes()

# 数组操作
array_contains()
array_join()
```

### 3.2 lib/colors.sh - 颜色与格式化

```bash
# 颜色定义
RED, GREEN, YELLOW, BLUE, CYAN, MAGENTA

# 文本格式
BOLD, UNDERLINE, REVERSE

# 组合函数
print_success()
print_error()
print_warning()
print_info()

# 进度条
show_progress_bar()
```

### 3.3 lib/logger.sh - 日志记录

```bash
# 日志级别
LOG_LEVEL_DEBUG=0
LOG_LEVEL_INFO=1
LOG_LEVEL_WARN=2
LOG_LEVEL_ERROR=3

# 日志函数
log_debug()
log_info()
log_warn()
log_error()

# 日志管理
rotate_logfile()
archive_logs()
```

### 3.4 lib/validator.sh - 参数验证

```bash
# 验证函数
validate_number()
validate_path()
validate_email()
validate_ip()

# 命令验证
require_command()
require_file()
require_directory()
```

## 4. 配置管理

### 4.1 config/defaults.conf

```bash
# 日志目录
LOG_DIR="/var/log/sysadmin-toolkit"
LOG_LEVEL="INFO"

# 告警阈值
CPU_THRESHOLD=80
MEMORY_THRESHOLD=85
DISK_THRESHOLD=90

# 日志文件
AUTH_LOG="/var/log/auth.log"
SYS_LOG="/var/log/syslog"

# 更新频率
MONITOR_INTERVAL=5
AUDIT_INTERVAL=60
```

### 4.2 config/thresholds.conf

```bash
# CPU阈值
CPU_WARNING=70
CPU_CRITICAL=90

# 内存阈值
MEMORY_WARNING=75
MEMORY_CRITICAL=85

# 磁盘阈值
DISK_WARNING=80
DISK_CRITICAL=90
```

## 5. 脚本执行流程

### 5.1 单个模块执行流程

```
Script Start
    ↓
Source Libraries (lib/common.sh, lib/colors.sh, etc.)
    ↓
Load Configuration (config/defaults.conf)
    ↓
Validate Parameters
    ↓
Check Prerequisites
    ↓
Initialize Module
    ↓
Main Logic
    ↓
Error Handling
    ↓
Output Results
    ↓
Cleanup Resources
    ↓
Script Exit
```

### 5.2 完整工具包执行流程

```
Start Main Controller
    ↓
Load All Modules
    ↓
Display Menu
    ↓
User Input
    ↓
┌─ Execute Selected Module
│      ↓
│   Run Module Script
│      ↓
│   Collect Results
│      ↓
│   Display Output
│      ↓
└─ Return to Menu
    ↓
Schedule Next Report
    ↓
Exit
```

## 6. 数据流和接口规范

### 6.1 模块间接口

**标准输出格式 (JSON)：**
```json
{
  "status": "success"|"error",
  "timestamp": "2026-06-21T10:30:45",
  "module": "monitor",
  "data": {
    "cpu_usage": 45.2,
    "memory_usage": 62.5,
    "processes_count": 128
  },
  "message": "Operation completed successfully"
}
```

### 6.2 错误代码规范

```bash
# 成功
RETURN_SUCCESS=0

# 通用错误
RETURN_ERROR=1
RETURN_INVALID_ARGS=2
RETURN_PERMISSION_DENIED=3
RETURN_NOT_FOUND=4
RETURN_ALREADY_EXISTS=5

# 特定错误
RETURN_NO_DATA=10
RETURN_TIMEOUT=11
RETURN_RESOURCE_BUSY=12
```

## 7. 安全考虑

### 7.1 权限管理

- 某些模块需要root权限（如网络统计）
- 使用`sudo`时需要用户确认
- 日志文件应设置适当权限（600或640）

### 7.2 输入验证

- 所有用户输入需要验证
- 防止命令注入
- 检查文件路径的合法性

### 7.3 日志安全

- 不记录敏感信息（密码、Token等）
- 日志文件定期轮转
- 归档日志加密存储

## 8. 性能考虑

### 8.1 资源消耗

- 监控间隔应平衡实时性和系统负载
- 使用缓冲减少磁盘I/O
- 大文件操作使用流式处理

### 8.2 缓存策略

- 缓存系统信息减少重复调用
- 实现TTL机制过期失效
- 支持手动清除缓存

## 9. 扩展性设计

### 9.1 新模块集成

1. 在`modules/`下创建新目录
2. 实现标准接口函数
3. 在`main_controller/main.sh`中注册
4. 添加菜单项

### 9.2 插件机制

- 支持自定义检查脚本
- 支持自定义告警动作
- 支持自定义报告格式

---

**文档版本：** 1.0  
**最后更新：** 2026年6月21日