#!/bin/sh

username=$1
password=$2

echo 'start install ...'
sh dev/docker.sh
sh mysql/start.sh
sh redis/start.sh
sh app/start.sh ${username} ${password}
echo 'install success'