# Linux系统运维工具箱

一个模块化的Linux系统管理工具集，包含性能监控、用户追踪、文件系统扫描、日志分析和智能调度等功能。

## 📋 项目概览

本项目采用**模块化架构**，共包含五个核心功能模块，各模块独立开发、统一集成。

| 模块 | 功能 | 状态 |
|------|------|------|
| **模块一** | 系统性能监控仪 | 🚧 开发中 |
| **模块二** | 用户活动追踪器 | 🚧 开发中 |
| **模块三** | 文件系统扫描仪 | 🚧 开发中 |
| **模块四** | 日志分析引擎 | 🚧 开发中 |
| **模块五** | 主控与调度中心 | 🚧 开发中 |

## 🏗️ 项目结构

```
linux-sysadmin-toolkit/
├── README.md                      # 项目说明文档
├── LICENSE                        # 开源协议
├── ARCHITECTURE.md                # 架构设计文档
│
├── modules/                       # 核心功能模块
│   ├── monitor/                   # 模块一：系统性能监控
│   │   ├── README.md
│   │   ├── cpu_monitor.sh         # CPU监控脚本
│   │   ├── memory_monitor.sh      # 内存分析脚本
│   │   └── process_top.sh         # 进程排行脚本
│   │
│   ├── user_tracker/              # 模块二：用户活动追踪
│   │   ├── README.md
│   │   ├── session_monitor.sh     # 实时会话监控
│   │   ├── login_audit.sh         # 登录审计脚本
│   │   └── privilege_check.sh     # 权限检查脚本
│   │
│   ├── filesystem_scanner/        # 模块三：文件系统扫描
│   │   ├── README.md
│   │   ├── space_alert.sh         # 空间预警脚本
│   │   ├── cleanup.sh             # 大文件清理脚本
│   │   └── security_scan.sh       # 安全扫描脚本
│   │
│   ├── log_analyzer/              # 模块四：日志分析引擎
│   │   ├── README.md
│   │   ├── realtime_filter.sh     # 实时日志追踪
│   │   ├── log_classify.sh        # 日志智能归类
│   │   └── log_archive.sh         # 日志归档压缩
│   │
│   └── main_controller/           # 模块五：主控与调度中心
│       ├── README.md
│       ├── main.sh                # 主程序入口
│       ├── menu.sh                # 交互菜单系统
│       ├── scheduler.sh           # 任务调度引擎
│       └── report_gen.sh          # 报告生成模块
│
├── lib/                           # 通用函数库
│   ├── common.sh                  # 通用工具函数
│   ├── colors.sh                  # 颜色/格式化输出
│   ├── logger.sh                  # 日志记录模块
│   └── validator.sh               # 参数验证模块
│
├── config/                        # 配置文件目录
│   ├── defaults.conf              # 默认配置参数
│   ├── thresholds.conf            # 告警阈值配置
│   └── crontab.example            # Crontab定时任务示例
│
├── tests/                         # 测试文件目录
│   ├── test_runner.sh             # 测试运行器
│   ├── unit_tests/                # 单元测试
│   └── integration_tests/         # 集成测试
│
├── docs/                          # 文档目录
│   ├── INSTALLATION.md            # 安装指南
│   ├── USAGE.md                   # 使用说明
│   ├── API.md                     # 函数库API文档
│   └── DEVELOPMENT.md             # 开发指南
│
└── scripts/                       # 辅助脚本
    ├── install.sh                 # 安装脚本
    ├── uninstall.sh               # 卸载脚本
    └── setup_daemon.sh            # 守护进程设置脚本
```

## 🚀 快速开始

### 前置要求
- Linux系统（Ubuntu 18.04+ 或 CentOS 7+）
- Bash 4.0+
- 常用工具：`awk`, `sed`, `grep`, `find`, `du`, `top`, `ps`

### 安装

```bash
# 克隆仓库
git clone https://github.com/shenleaaa/linux-sysadmin-toolkit.git
cd linux-sysadmin-toolkit

# 运行安装脚本
chmod +x scripts/install.sh
sudo ./scripts/install.sh

# 验证安装
./main_controller/main.sh
```

### 基本使用

```bash
# 启动主程序（交互菜单）
./main_controller/main.sh

# 单独运行各模块
./modules/monitor/cpu_monitor.sh
./modules/user_tracker/session_monitor.sh
./modules/filesystem_scanner/space_alert.sh
./modules/log_analyzer/realtime_filter.sh
```

## 📚 模块详情

### 模块一：系统性能监控仪
**功能：**
- 实时CPU使用率监控（整体+各核心）
- 内存与Swap空间分析
- 进程资源排行（Top 5）
- ASCII负载趋势图

**技术栈：** `/proc`文件系统、`awk`数值计算、动态图表

### 模块二：用户活动追踪器
**功能：**
- 实时登录会话监控
- 登录历史审计与失败统计
- 暴力破解检测
- 高权限操作审计

**技术栈：** 日志解析、正则表达式、权限检查

### 模块三：文件系统扫描仪
**功能：**
- 磁盘空间预警
- 大文件识别与清理
- 关键目录安全扫描
- 异常权限检测

**技术栈：** `find`高级用法、权限位操作、交互式确认

### 模块四：日志分析引擎
**功能：**
- 实时日志流过滤与高亮
- 按错误级别统计分类
- 日志轮转与归档
- 日志压缩

**技术栈：** `tail -f`、信号捕获、日志轮转机制

### 模块五：主控与调度中心
**功能：**
- 图形化菜单界面（dialog/whiptail）
- 手动/定时/守护进程执行模式
- 日报/周报生成
- 系统健康评分

**技术栈：** Shell函数库、`crontab`、HTML报告生成

## 🔧 开发指南

### 模块开发规范

1. **命名约定**
   - 脚本文件：`snake_case.sh`
   - 函数名：`module_function_name()`
   - 全局变量：`MODULE_VAR_NAME`

2. **必要函数**
   ```bash
   # 每个模块必须实现
   function module_init() { ... }        # 初始化
   function module_main() { ... }        # 主逻辑
   function module_cleanup() { ... }     # 清理资源
   function module_help() { ... }        # 帮助信息
   ```

3. **日志规范**
   ```bash
   # 使用统一的日志函数
   log_info "Message"
   log_warn "Warning message"
   log_error "Error message"
   ```

4. **错误处理**
   ```bash
   # 检查命令执行结果
   if ! command_to_run; then
       log_error "Failed to run command"
       return 1
   fi
   ```

## 📖 文档

详细文档请查看 `docs/` 目录：
- [安装指南](docs/INSTALLATION.md)
- [使用说明](docs/USAGE.md)
- [API文档](docs/API.md)
- [开发指南](docs/DEVELOPMENT.md)

## 🤝 贡献指南

欢迎提交Pull Request！请遵循以下步骤：

1. Fork 本仓库
2. 创建特性分支 (`git checkout -b feature/AmazingFeature`)
3. 提交更改 (`git commit -m 'Add some AmazingFeature'`)
4. 推送分支 (`git push origin feature/AmazingFeature`)
5. 提交Pull Request

## 📝 许可证

本项目采用 [MIT License](LICENSE) 开源协议。

## ✉️ 联系方式

如有问题或建议，请通过以下方式联系：
- 提交 [GitHub Issues](https://github.com/shenleaaa/linux-sysadmin-toolkit/issues)
- 发起 [Discussions](https://github.com/shenleaaa/linux-sysadmin-toolkit/discussions)

## 🎯 项目状态

- [x] 项目框架搭建
- [ ] 模块一开发完成
- [ ] 模块二开发完成
- [ ] 模块三开发完成
- [ ] 模块四开发完成
- [ ] 模块五开发完成
- [ ] 集成测试
- [ ] 文档完善
- [ ] v1.0 发布

---

**最后更新：** 2026年6月21日