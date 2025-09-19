#!/bin/bash

# RocketMQ NameServer 启动脚本
# 作者: AI Assistant
# 日期: $(date +%Y-%m-%d)

# 获取当前脚本目录
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROCKETMQ_HOME="${SCRIPT_DIR}/rocketmq-all-5.1.4-bin-release"

# 检查RocketMQ目录是否存在
if [ ! -d "$ROCKETMQ_HOME" ]; then
    echo "错误: RocketMQ目录不存在: $ROCKETMQ_HOME"
    exit 1
fi

# 检查是否已经运行
if pgrep -f "org.apache.rocketmq.namesrv.NamesrvStartup" > /dev/null; then
    echo "警告: NameServer 已在运行中"
    echo "如需重启，请先执行 ./stop-nameserver.sh"
    exit 1
fi

# 设置环境变量
export ROCKETMQ_HOME
export JAVA_OPT="-server -Xms512m -Xmx512m -Xmn256m -XX:MetaspaceSize=128m -XX:MaxMetaspaceSize=320m"

# 创建日志目录
mkdir -p "${SCRIPT_DIR}/logs"

echo "正在启动 RocketMQ NameServer..."
echo "RocketMQ Home: ${ROCKETMQ_HOME}"
echo "日志目录: ${SCRIPT_DIR}/logs"

# 启动NameServer
cd "${ROCKETMQ_HOME}"
nohup sh bin/mqnamesrv > "${SCRIPT_DIR}/logs/nameserver.log" 2>&1 &

# 获取进程ID
NAMESERVER_PID=$!
echo $NAMESERVER_PID > "${SCRIPT_DIR}/logs/nameserver.pid"

echo "NameServer 启动完成!"
echo "进程ID: $NAMESERVER_PID"
echo "日志文件: ${SCRIPT_DIR}/logs/nameserver.log"
echo "检查启动状态: tail -f ${SCRIPT_DIR}/logs/nameserver.log"
echo ""
echo "请等待几秒钟，然后检查启动日志确认启动成功"
