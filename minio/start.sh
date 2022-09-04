#!/bin/sh

if [ ! -d "/data/minio" ]; then
  # 创建数据目录
  mkdir -pv /data/minio/data
fi

# start service
echo "start services......"
docker-compose --compatibility pull
docker-compose --compatibility up -d
docker image prune -f
echo "start services success!"