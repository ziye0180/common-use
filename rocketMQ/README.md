# RocketMQ 部署与使用指南

## 版本信息
- RocketMQ版本: 5.1.4
- 发布类型: Binary Release

## 下载命令

```bash
# 下载 RocketMQ 5.1.4 二进制发行版 (清华源)
wget https://mirrors.tuna.tsinghua.edu.cn/apache/rocketmq/5.1.4/rocketmq-all-5.1.4-bin-release.zip

# 或者使用 curl 下载 (清华源)
curl -O https://mirrors.tuna.tsinghua.edu.cn/apache/rocketmq/5.1.4/rocketmq-all-5.1.4-bin-release.zip

# 解压文件
unzip rocketmq-all-5.1.4-bin-release.zip
```

## 环境要求

- Java 8 或更高版本
- 至少 2GB 内存
- 64位操作系统

## 快速启动

### 1. 启动 NameServer

```bash
# 使用提供的脚本启动
./start-nameserver.sh

# 或者手动启动
nohup sh rocketmq-all-5.1.4-bin-release/bin/mqnamesrv &
```

### 2. 启动 Broker

```bash
# 使用提供的脚本启动
./start-broker.sh

# 或者手动启动
nohup sh rocketmq-all-5.1.4-bin-release/bin/mqbroker -n localhost:9876 &
```

### 3. 停止服务

```bash
# 停止 Broker
./stop-broker.sh

# 停止 NameServer
./stop-nameserver.sh
```

## 管理脚本说明

- `start-nameserver.sh` - 启动名称服务器
- `start-broker.sh` - 启动消息代理
- `stop-nameserver.sh` - 停止名称服务器
- `stop-broker.sh` - 停止消息代理

## 配置文件

主要配置文件位于 `rocketmq-all-5.1.4-bin-release/conf/` 目录下：

- `broker.conf` - Broker配置文件
- `plain_acl.yml` - ACL权限配置
- `rmq-proxy.json` - 代理配置

## 默认端口

- NameServer: 9876
- Broker: 10911 (监听端口), 10909 (快速失败端口)
- 控制台: 8080 (如果部署了控制台)

## 常用命令

### 创建Topic

```bash
sh rocketmq-all-5.1.4-bin-release/bin/mqadmin updateTopic -n localhost:9876 -t TopicTest -c DefaultCluster
```

### 查看Topic列表

```bash
sh rocketmq-all-5.1.4-bin-release/bin/mqadmin topicList -n localhost:9876
```

### 发送消息

```bash
sh rocketmq-all-5.1.4-bin-release/bin/tools.sh org.apache.rocketmq.example.quickstart.Producer
```

### 消费消息

```bash
sh rocketmq-all-5.1.4-bin-release/bin/tools.sh org.apache.rocketmq.example.quickstart.Consumer
```

## 日志位置

- 运行日志：`logs/` 目录
- NameServer日志：`logs/nameserver.log`
- Broker日志：`logs/broker.log`
- 进程ID文件：`logs/*.pid`

## 性能测试

### 生产者性能测试

```bash
sh rocketmq-all-5.1.4-bin-release/benchmark/producer.sh
```

### 消费者性能测试

```bash
sh rocketmq-all-5.1.4-bin-release/benchmark/consumer.sh
```

## 故障排查

### 查看服务状态

```bash
# 检查NameServer是否运行
jps | grep NamesrvStartup

# 检查Broker是否运行
jps | grep BrokerStartup
```

### 查看日志

```bash
# 查看NameServer日志
tail -f logs/nameserver.log

# 查看Broker日志
tail -f logs/broker.log
```

### 常见问题

1. **内存不足**: 确保系统有足够的内存，可以通过修改启动脚本中的JVM参数来调整
2. **端口被占用**: 检查9876和10911端口是否被其他程序占用
3. **权限问题**: 确保脚本有执行权限 `chmod +x *.sh`

## Docker 部署

参考 `docker-dashboard.md` 文件了解Docker部署方式。

## 更多信息

- 官方文档: https://rocketmq.apache.org/docs/
- GitHub: https://github.com/apache/rocketmq
- 版本发布页: https://rocketmq.apache.org/release-notes/