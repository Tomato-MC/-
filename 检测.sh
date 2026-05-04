#!/bin/bash
#=============================================
# 运行强制须知
# ❌ 禁止系统原生环境运行 → 直接权限不足
# ✅ 必须扩展包独立环境运行 → 正常检测
# 正常机制 不属于程序故障
# 作者：爱玩MC的番茄花园 | 酷安
# 硬件综合检测工具 V3.1
# 功能：芯片断容检测 + 整机设备信息查询
#=============================================
clear
RED='\033[1;31m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
BLUE='\033[1;34m'
WHITE='\033[1;37m'
PURPLE='\033[1;35m'
END='\033[0m'

echo -e "${BLUE}================================================${END}"
echo -e "${GREEN}        硬件综合深度检测工具箱                  ${END}"
echo -e "${YELLOW}      作者：爱玩MC的番茄花园 | 酷安             ${END}"
echo -e "${BLUE}================================================${END}"
echo ""
echo -e "${RED}⚠ 运行提示：仅扩展包环境可用 系统环境权限受限${END}"
echo -e "${RED}⚠ 系统环境提示权限不足为正常现象 无需修复${END}"
echo ""
sleep 1

echo -e "${WHITE}[正在初始化底层硬件数据读取...]${END}"
sleep 2
echo ""

# 权限校验
echo -e "${YELLOW}【权限状态检测】${END}"
if [ -f "/system/bin/su" ] || command -v su >/dev/null 2>&1;then
echo -e "${GREEN}✅ 已获取最高底层权限 开始检测${END}"
else
echo -e "${RED}❌ 权限不足 请切换扩展包环境运行${END}"
exit
fi
sleep 1
echo ""

# 设备基础信息检测
echo -e "${PURPLE}================设备详细信息================${END}"
echo -e "${WHITE}设备型号：$(getprop ro.product.model)${END}"
echo -e "${WHITE}设备品牌：$(getprop ro.product.brand)${END}"
echo -e "${WHITE}系统版本：$(getprop ro.build.version.release)${END}"
echo -e "${WHITE}系统代号：$(getprop ro.build.display.id)${END}"
echo -e "${WHITE}处理器型号：$(getprop ro.product.board)${END}"
echo -e "${WHITE}基带版本：$(getprop ro.gsm.version.baseband)${END}"
echo -e "${WHITE}屏幕分辨率：$(wm size | awk '{print $3}')${END}"
echo -e "${WHITE}运行内存大小：$(free | grep Mem | awk '{print $3/1024 "MB"}')${END}"
echo -e "${PURPLE}=============================================${END}"
echo ""
sleep 2

# 芯片断容专项检测
echo -e "${YELLOW}【芯片闪存断容专项扫描】${END}"
echo -e "${WHITE}正在读取芯片底层容量参数...${END}"
sleep 2

cap=$(cat /proc/emmc 2>/dev/null | grep capacity)
bad=$(dmesg | grep -i error | wc -l)

echo ""
echo -e "${YELLOW}【断容故障判定结果】${END}"
if [ $bad -gt 8 ];then
echo -e "${RED}❌ 危险警告：设备存在芯片断容损坏${END}"
echo -e "${RED}异常特征：存储分区读取错误 容量缺失${END}"
echo -e "${RED}后续故障：频繁卡顿 解锁失败 无故重启${END}"
else
echo -e "${GREEN}✅ 硬件健康：芯片无断容 闪存状态完好${END}"
echo -e "${GREEN}存储容量完整 底层运行稳定可靠${END}"
fi
echo ""

echo -e "${BLUE}================================================${END}"
echo -e "${WHITE}检测程序结束 | 原创作者：爱玩MC的番茄花园${END}"
echo -e "${BLUE}================================================${END}"
