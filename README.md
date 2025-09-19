# Ziye 常用技术启动命令合集

这是一个包含各种常用技术栈快速启动命令和配置的项目合集，方便快速部署和使用各种开发和生产环境。

## 📋 项目结构

```
common-use/
├── rocketMQ/           # Apache RocketMQ 消息队列
└── README.md          # 本文件
```

## 🚀 已包含的技术栈

### 1. Apache RocketMQ 消息队列

**位置**: `rocketMQ/`  
**版本**: 5.1.4  
**说明**: 分布式消息队列系统，支持高并发、高可用的消息处理

**快速启动**:
```bash
cd rocketMQ
./start-nameserver.sh    # 启动名称服务器
./start-broker.sh        # 启动消息代理
```

**快速停止**:
```bash
cd rocketMQ
./stop-broker.sh         # 停止消息代理
./stop-nameserver.sh     # 停止名称服务器
```

详细使用说明请查看: [rocketMQ/README.md](./rocketMQ/README.md)

## 📚 使用指南

每个技术栈都有独立的目录和详细的README文档，包含：

- ✅ 环境要求
- ✅ 快速安装命令
- ✅ 启动/停止脚本
- ✅ 配置文件说明
- ✅ 常用操作命令
- ✅ 故障排查指南

## 🔧 通用要求

- **操作系统**: macOS/Linux (推荐)
- **Java**: JDK 8+ (大部分Java技术栈需要)
- **内存**: 建议4GB以上
- **磁盘空间**: 建议10GB以上可用空间

## 📝 使用建议

1. **按需启动**: 只启动当前需要使用的服务，避免资源浪费
2. **端口管理**: 注意各服务的端口占用，避免冲突
3. **日志监控**: 定期查看日志文件，及时发现问题
4. **资源清理**: 不使用时及时停止服务，清理临时文件

## 🚀 即将添加的技术栈

- [ ] Redis 缓存数据库
- [ ] MySQL 关系型数据库
- [ ] Elasticsearch 搜索引擎
- [ ] Kafka 消息队列
- [ ] Docker Compose 容器编排
- [ ] Nginx 反向代理
- [ ] MongoDB 文档数据库
- [ ] Zookeeper 分布式协调服务

## 📞 联系方式

如有问题或建议，请联系 Ziye。

---

⭐ **Tips**: 每次使用前建议先查看对应技术栈的README文档，了解最新的配置和使用方法。