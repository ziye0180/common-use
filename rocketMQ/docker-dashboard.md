docker run -d \
  --name rocketmq-dashboard \
  -p 8180:8080 \
  -e "JAVA_OPTS=-Drocketmq.namesrv.addr=host.docker.internal:9876" \
  apacherocketmq/rocketmq-dashboard:latest