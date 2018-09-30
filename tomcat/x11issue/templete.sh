#!/bin/sh
user=$1

if [ -z "${user}" ]; then 
   echo Usage: $0  user
   exit -1 ;
fi
docker stop lims${user}
docker rm lims${user}
docker run --name lims${user} -d \
    --link mysql:db \
    -e CONTEXTPATH=lims${user} \
    -e RESOURCE_NAME1=framework \
    -e RESOURCE_NAME2=jdbc/framework \
    -e APP_DB_HOST=db \
    -e APP_DB_PORT=3306\
    -e APP_DB_USER=root \
    -e APP_DB_PASSWORD=sunway123# \
    -e APP_DATABASE=dbs_dev \
    -p 8100:8080  sunway/lims:v2

#docker ps -a 
echo "curl -X GET http://172.31.209.221:8100/lims/resource/sunway/index.jsp?url=/lims/"
echo 


