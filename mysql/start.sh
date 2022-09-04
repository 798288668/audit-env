#!/bin/sh

if [ ! -d "/data/mysql/data" ]; then
  mkdir -pv /data/mysql/data
  mkdir -pv /data/mysql/sql
  mkdir -pv /data/mysql/conf.d
fi

if [ -f "custom.cnf" ]; then
  cp -r -f ./custom.cnf /data/mysql/conf.d/
fi

# sql
if [ -f "init.sql" ]; then
  cp -r -f ./init.sql /data/mysql/sql/
fi

# start service
echo "start services......"
docker-compose --compatibility pull
docker-compose --compatibility up -d
docker image prune -f
echo "start services success!"

curl http://127.0.0.1:3306 &> /dev/null
while [ $? -ne 0 ]
do
    echo 'Mysql is not ready...'
    sleep 5
    curl http://127.0.0.1:3306 &> /dev/null
done

echo 'Mysql is ready now.'

if [ -f "/data/mysql/sql/init.sql" ]; then
     echo 'Database initialize begin...'
     docker exec -it mysql mysql -uroot -p'Mysql@2019' mysql  -e "source /opt/init.sql" &> /dev/null
     if [ $? -eq 0 ];then
        mv /data/mysql/sql/init.sql /data/mysql/sql/init.sql.$(date +%Y%m%d%H%M%S)
        echo 'Database initialize success!'
     else
        echo 'Database initialize failed!'
     fi
fi

echo "mysql install success!"