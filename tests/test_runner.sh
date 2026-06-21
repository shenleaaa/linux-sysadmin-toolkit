#!/bin/bash

# 测试轨重器
# 负责运行各模块测试

set -e

echo "╔══════════════════════════════╗"
echo "║   Linux系统运维工具箱 - 测试套件      ║"
echo "╘══════════════════════════════╛"

# 设定颜色
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

PASSED=0
FAILED=0

# 测试函数
run_test() {
    local test_name="$1"
    local test_cmd="$2"
    
    echo -e "${YELLOW}[*]${NC} 测试: $test_name"
    
    if eval "$test_cmd" > /dev/null 2>&1; then
        echo -e "${GREEN}[✓]${NC} 测试通过: $test_name"
        ((PASSED++))
    else
        echo -e "${RED}[✗]${NC} 测试失败: $test_name"
        ((FAILED++))
    fi
}

# 模块一测试
echo -e "\n${YELLOW}=== 模块一: 系统性能监控 ===${NC}"
run_test "CPU监控脚本存在" "[ -f modules/monitor/cpu_monitor.sh ]"
run_test "CPU监控可执行" "[ -x modules/monitor/cpu_monitor.sh ]"
run_test "内存监控脚本存在" "[ -f modules/monitor/memory_monitor.sh ]"
run_test "进程排行脚本存在" "[ -f modules/monitor/process_top.sh ]"

# 模块二测试
echo -e "\n${YELLOW}=== 模块二: 用户活动追踪 ===${NC}"
run_test "会话监控脚本存在" "[ -f modules/user_tracker/session_monitor.sh ]"
run_test "登录审计脚本存在" "[ -f modules/user_tracker/login_audit.sh ]"
run_test "权限检查脚本存在" "[ -f modules/user_tracker/privilege_check.sh ]"

# 模块三测试
echo -e "\n${YELLOW}=== 模块三: 文件系统扫描 ===${NC}"
run_test "空间预警脚本存在" "[ -f modules/filesystem_scanner/space_alert.sh ]"
run_test "清理脚本存在" "[ -f modules/filesystem_scanner/cleanup.sh ]"
run_test "安全扫描脚本存在" "[ -f modules/filesystem_scanner/security_scan.sh ]"

# 模块四测试
echo -e "\n${YELLOW}=== 模块四: 日志分析引擎 ===${NC}"
run_test "实时追踪脚本存在" "[ -f modules/log_analyzer/realtime_filter.sh ]"
run_test "日志分类脚本存在" "[ -f modules/log_analyzer/log_classify.sh ]"
run_test "日志归档脚本存在" "[ -f modules/log_analyzer/log_archive.sh ]"

# 模块五测试
echo -e "\n${YELLOW}=== 模块五: 主控与调度中心 ===${NC}"
run_test "主控脚本存在" "[ -f main_controller/main.sh ]"
run_test "主控脚本可执行" "[ -x main_controller/main.sh ]"
run_test "上载脚本存在" "[ -f main_controller/menu.sh ]"

# 公共库测试
echo -e "\n${YELLOW}=== 公共库 ===${NC}"
run_test "common.sh库存在" "[ -f lib/common.sh ]"
run_test "colors.sh库存在" "[ -f lib/colors.sh ]"
run_test "配置文件存在" "[ -f config/defaults.conf ]"

# 总结
echo -e "\n${YELLOW}==== 测试总结 ====${NC}"
echo -e "${GREEN}通过: $PASSED${NC}"
echo -e "${RED}失败: $FAILED${NC}"

if [ $FAILED -eq 0 ]; then
    echo -e "${GREEN}[✓] 所有测试都通过了！${NC}"
    exit 0
else
    echo -e "${RED}[✗] 查看上面的测试失败情况${NC}"
    exit 1
fi
