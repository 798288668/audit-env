#!/bin/sh

username=$1
password=$2

# start service
echo "start services......"
export CONFIG_ENV=base,prod
docker login -u ${username} -p ${password} registry.cn-hangzhou.aliyuncs.com
docker-compose --compatibility pull
docker-compose --compatibility up -d
docker image prune -f
echo "start services success!"