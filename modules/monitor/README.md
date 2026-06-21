# 模块一：系统性能监控仪

## 功能概述

实时监控Linux系统性能指标，包括CPU、内存、进程等，并通过视觉化界面展示。

## 核心功能

### 1. CPU监控 (cpu_monitor.sh)

**功能：**
- 获取整体CPU使用率
- 显示各核心单独使用率
- 计算1分钟、5分钟、15分钟平均负载
- 生成ASCII负载趋势图

**输入参数：**
```bash
./cpu_monitor.sh [interval] [count]
# interval: 采样间隔（秒），默认5秒
# count: 采样次数，默认10次
```

**输出示例：**
```
╔════════════════════════════════════╗
║       CPU 性能监控报告              ║
╠════════════════════════════════════╣
║ CPU总使用率: 35.2%                 ║
║ CPU核心数: 4                       ║
║                                    ║
║ 核心使用率:                         ║
║ Core 0: ████░░░░░░  40%            ║
║ Core 1: ███░░░░░░░  30%            ║
║ Core 2: █████░░░░░  50%            ║
║ Core 3: ██░░░░░░░░  20%            ║
║                                    ║
║ 平均负载:                           ║
║ 1分钟:  1.23                       ║
║ 5分钟:  1.45                       ║
║ 15分钟: 1.10                       ║
║                                    ║
║ 负载趋势图 (最近10个采样):         ║
║ ██░░░░██░░ █░░░░░░░░ █░░░░░░░░  ║
╚════════════════════════════════════╝
```

### 2. 内存分析 (memory_monitor.sh)

**功能：**
- 显示物理内存使用情况
- 显示Swap空间使用情况
- 计算使用百分比
- 根据阈值触发颜色告警

**输入参数：**
```bash
./memory_monitor.sh [warning_threshold] [critical_threshold]
# 默认: 75% warning, 85% critical
```

**输出示例：**
```
╔════════════════════════════════════╗
║       内存 性能监控报告             ║
╠════════════════════════════════════╣
║ 物理内存:                           ║
║ ████████░░░░░░░░░░░░  40%          ║
║ 已用: 4096 MB / 总量: 10240 MB    ║
║ 状态: [✓ 正常]                    ║
║                                    ║
║ Swap空间:                          ║
║ ████░░░░░░░░░░░░░░░░  20%         ║
║ 已用: 512 MB / 总量: 2560 MB      ║
║ 状态: [✓ 正常]                    ║
║                                    ║
║ 内存详情:                          ║
║ MemTotal:    10240 MB              ║
║ MemFree:     6144 MB               ║
║ MemAvailable: 6656 MB              ║
║ Buffers:     256 MB                ║
║ Cached:      1024 MB               ║
╚════════════════════════════════════╝
```

### 3. 进程排行 (process_top.sh)

**功能：**
- 列出资源消耗Top 5的进程
- 显示进程PID、名称、CPU占比、内存占比
- 支持按CPU或内存排序

**输入参数：**
```bash
./process_top.sh [sort_by] [limit]
# sort_by: cpu|memory，默认cpu
# limit: 显示数量，默认5
```

**输出示例：**
```
╔════════════════════════════════════════════════════╗
║        进程资源排行 (按CPU使用率)                  ║
╠════════════════════════════════════════════════════╣
║ PID    | 命令           | CPU%  | 内存(MB) | 内存% ║
╠════════════════════════════════════════════════════╣
║ 1234   | firefox        | 12.5  | 1024     | 10.0  ║
║ 5678   | python3        | 8.2   | 512      | 5.0   ║
║ 9012   | chrome         | 5.1   | 2048     | 20.0  ║
║ 3456   | java           | 3.8   | 4096     | 40.0  ║
║ 7890   | node           | 2.3   | 256      | 2.5   ║
╚════════════════════════════════════════════════════╝
```

## 技术实现

### 数据源

| 指标 | 数据源 | 命令 |
|------|-------|------|
| CPU使用率 | /proc/stat | awk处理 |
| 平均负载 | /proc/loadavg | cat、awk |
| 内存信息 | /proc/meminfo | grep、awk |
| 进程信息 | /proc/[pid]/* | ps、top |

### 关键函数

```bash
# CPU监控
get_cpu_stats()          # 获取CPU统计
calc_cpu_usage()         # 计算使用率
get_load_average()       # 获取平均负载
draw_load_chart()        # 绘制负载图

# 内存分析
get_memory_info()        # 获取内存信息
check_swap_usage()       # 检查Swap使用
format_memory_output()   # 格式化输出

# 进程排行
get_process_stats()      # 获取进程统计
get_top_processes()      # 获取Top进程
sort_processes()         # 排序进程
```

## 使用示例

### 简单监控
```bash
# 执行CPU监控
./cpu_monitor.sh

# 执行内存监控
./memory_monitor.sh

# 显示进程排行
./process_top.sh cpu 10
```

### 持续监控
```bash
# 每5秒采样一次，共30次（150秒）
./cpu_monitor.sh 5 30

# 自定义阈值
./memory_monitor.sh 70 90
```

### 定时任务
```bash
# 每10分钟收集一次数据
*/10 * * * * /path/to/cpu_monitor.sh >> /var/log/cpu_monitor.log

# 每小时生成报告
0 * * * * /path/to/memory_monitor.sh >> /var/log/memory_monitor.log
```

## 配置参数

在 `config/defaults.conf` 中配置：

```bash
# CPU监控间隔（秒）
CPU_MONITOR_INTERVAL=5

# CPU告警阈值
CPU_WARNING_THRESHOLD=70
CPU_CRITICAL_THRESHOLD=90

# 内存告警阈值
MEMORY_WARNING_THRESHOLD=75
MEMORY_CRITICAL_THRESHOLD=85

# 进程监控
TOP_PROCESS_LIMIT=5
MONITOR_INTERVAL=10
```

## 错误处理

- 检查/proc文件系统可用性
- 验证计算的有效性
- 处理浮点数精度问题
- 捕获awk/sed执行错误

## 性能考虑

- 避免过于频繁的采样
- 使用缓冲区存储历史数据
- 优化正则表达式性能
- 使用awk内置函数减少外部调用

---

**模块版本：** 1.0  
**最后更新：** 2026年6月21日