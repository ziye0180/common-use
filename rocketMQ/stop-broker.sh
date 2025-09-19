#!/bin/bash

# RocketMQ Broker 停止脚本
# 作者: AI Assistant
# 日期: $(date +%Y-%m-%d)

# 获取当前脚本目录
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PID_FILE="${SCRIPT_DIR}/logs/broker.pid"

echo "正在停止 RocketMQ Broker..."

# 方法1: 通过PID文件停止
if [ -f "$PID_FILE" ]; then
    PID=$(cat "$PID_FILE")
    if ps -p $PID > /dev/null 2>&1; then
        echo "通过PID文件停止 Broker (PID: $PID)"
        kill $PID
        
        # 等待进程停止
        for i in {1..15}; do
            if ! ps -p $PID > /dev/null 2>&1; then
                echo "Broker 已成功停止"
                rm -f "$PID_FILE"
                exit 0
            fi
            echo "等待进程停止... ($i/15)"
            sleep 1
        done
        
        # 强制停止
        echo "进程未响应，强制停止..."
        kill -9 $PID
        rm -f "$PID_FILE"
    else
        echo "PID文件中的进程不存在，清理PID文件"
        rm -f "$PID_FILE"
    fi
fi

# 方法2: 通过进程名停止
PIDS=$(pgrep -f "org.apache.rocketmq.broker.BrokerStartup")
if [ -n "$PIDS" ]; then
    echo "通过进程名停止 Broker"
    for PID in $PIDS; do
        echo "停止进程: $PID"
        kill $PID
    done
    
    # 等待进程停止
    sleep 5
    
    # 检查是否还有进程在运行
    REMAINING_PIDS=$(pgrep -f "org.apache.rocketmq.broker.BrokerStartup")
    if [ -n "$REMAINING_PIDS" ]; then
        echo "强制停止剩余进程..."
        for PID in $REMAINING_PIDS; do
            kill -9 $PID
        done
    fi
    
    echo "Broker 已停止"
else
    echo "没有找到运行中的 Broker 进程"
fi

# 清理PID文件
rm -f "$PID_FILE"
echo "停止操作完成"
