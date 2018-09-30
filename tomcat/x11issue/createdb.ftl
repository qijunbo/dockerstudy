#!/bin/sh

mkdir -p  /docker/${name}/data
mkdir -p  /docker/${name}/logs

docker run --name mysql${name} \
	--restart=always \
	-m ${mem} \
    -v /docker/${name}/data:/var/lib/mysql  \
    -v /docker/everyone/initsql:/docker-entrypoint-initdb.d \
    -v /docker/everyone/conf/docker.cnf:/etc/my.cnf \
    -e MYSQL_ROOT_PASSWORD=sunway123#  \
    -d -p ${port}:3306 mysql \    
    --character-set-server=utf8 --collation-server=utf8_general_ci 
