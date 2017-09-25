#!/bin/sh
name=$1

if [ -z "${name}" ]; then 
   echo "Usage: %0 name"
   exit -1 ;
fi

mkdir -p  /root/mysql/${name}/data
mkdir -p  /root/mysql/${name}/initsql
mkdir -p  /root/mysql/${name}/conf
cp -f init.sql /root/mysql/${name}/initsql/

docker stop mysql
docker container prune -f 
docker run --name mysql -e MYSQL_ROOT_PASSWORD=sunway123# -d -p 3306:3306 \
    -v /root/mysql/${name}/data:/var/lib/mysql  \
    -v /root/mysql/${name}/initsql:/docker-entrypoint-initdb.d   qijunbo/mysql \
    --character-set-server=utf8 --collation-server=utf8_general_ci 
docker ps -a   

