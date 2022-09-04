#!/bin/sh

if [ ! -d "/data/elasticsearch/data" ]; then
  mkdir -pv /data/elasticsearch/data
  chmod 777 /data/elasticsearch/data
fi

# start service
echo "start services......"
docker-compose --compatibility pull
docker-compose --compatibility up -d
docker image prune -f
echo "start services success!"