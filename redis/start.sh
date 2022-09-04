#!/bin/sh

if [ ! -d "/data/redis" ]; then
  mkdir -pv /data/redis
fi

# redis config
if [ -f "redis.conf" ]; then
  cp -r -f redis.conf /data/redis/
fi

# start service
echo "start services......"
docker-compose --compatibility pull
docker-compose --compatibility up -d
docker image prune -f
echo "start services success!"