#!/bin/bash

# RocketMQ Broker 启动脚本
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

# 检查NameServer是否运行
if ! pgrep -f "org.apache.rocketmq.namesrv.NamesrvStartup" > /dev/null; then
    echo "警告: NameServer 未运行，请先启动 NameServer"
    echo "执行: ./start-nameserver.sh"
    exit 1
fi

# 检查Broker是否已经运行
if pgrep -f "org.apache.rocketmq.broker.BrokerStartup" > /dev/null; then
    echo "警告: Broker 已在运行中"
    echo "如需重启，请先执行 ./stop-broker.sh"
    exit 1
fi

# 设置环境变量
export ROCKETMQ_HOME
export JAVA_OPT="-server -Xms2g -Xmx2g -Xmn1g -XX:MetaspaceSize=128m -XX:MaxMetaspaceSize=320m --add-opens java.base/sun.nio.ch=ALL-UNNAMED --add-opens java.base/java.nio=ALL-UNNAMED --add-opens java.base/java.lang=ALL-UNNAMED --add-opens java.base/java.lang.reflect=ALL-UNNAMED --add-opens java.base/java.util=ALL-UNNAMED --add-opens java.base/java.util.concurrent=ALL-UNNAMED --add-opens java.base/java.net=ALL-UNNAMED --add-opens java.base/java.io=ALL-UNNAMED"

# 创建日志目录
mkdir -p "${SCRIPT_DIR}/logs"

# NameServer地址
NAMESERVER_ADDR="localhost:9876"

echo "正在启动 RocketMQ Broker..."
echo "RocketMQ Home: ${ROCKETMQ_HOME}"
echo "NameServer 地址: ${NAMESERVER_ADDR}"
echo "日志目录: ${SCRIPT_DIR}/logs"

# 启动Broker
cd "${ROCKETMQ_HOME}"
nohup sh bin/mqbroker -n ${NAMESERVER_ADDR} -c conf/broker.conf > "${SCRIPT_DIR}/logs/broker.log" 2>&1 &

# 获取进程ID
BROKER_PID=$!
echo $BROKER_PID > "${SCRIPT_DIR}/logs/broker.pid"

echo "Broker 启动完成!"
echo "进程ID: $BROKER_PID"
echo "日志文件: ${SCRIPT_DIR}/logs/broker.log"
echo "检查启动状态: tail -f ${SCRIPT_DIR}/logs/broker.log"
echo ""
echo "请等待几秒钟，然后检查启动日志确认启动成功"
echo "成功启动后，您将看到类似 'The broker[%s, %s] boot success...' 的消息"
