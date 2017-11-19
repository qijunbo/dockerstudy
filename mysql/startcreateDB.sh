#!/bin/sh
name=$1

if [ -z "${name}" ]; then 
   echo "Usage: $0 name"
   exit -1 ;
fi

mkdir -p  /opt/mysql/${name}/data
mkdir -p  /opt/mysql/${name}/initsql
mkdir -p  /opt/mysql/everyone/conf

cp -f init.sql /opt/mysql/${name}/initsql/
cp -f docker.cnf /opt/mysql/everyone/conf/

docker stop ${name}
docker container prune -f 
docker run --name ${name} \
    -v /opt/mysql/${name}/data:/var/lib/mysql  \
    -v /opt/mysql/${name}/initsql:/docker-entrypoint-initdb.d \
    -v /opt/mysql/everyone/conf/docker.cnf:/etc/my.cnf \
    -e MYSQL_ROOT_PASSWORD=sunway123#  \
	-e MYSQL_DATABASE=wordpress \
    -d -p 3306:3306 mysql \
    --character-set-server=utf8 --collation-server=utf8_general_ci 

docker ps -a   

 
