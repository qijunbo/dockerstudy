#!/bin/sh
name=$1

if [ -z "${name}" ]; then 
   echo "Usage: $0 name"
   exit -1 ;
fi

mkdir data
mkdir init
cp  init.sql init/

docker stop ${name}
docker rm ${name}
docker run --name ${name} \
    -v "$PWD/data":/var/lib/mysql  \
    -v "$PWD/init":/docker-entrypoint-initdb.d \
    -v "$PWD/docker.cnf":/etc/my.cnf \
    -e MYSQL_ROOT_PASSWORD=sunway123#  \
    -d -P mysql \
    --character-set-server=utf8 --collation-server=utf8_general_ci 

docker ps -a   

 
