#!/bin/sh
set -e 

docker stop lims${user}
docker rm lims${user}
docker run --name lims${user} -d \
    -e CONTEXTPATH=${contextPath} \
    -e RESOURCE_NAME1=framework \
    -e RESOURCE_NAME2=jdbc/framework \
    -e APP_DB_HOST=${dbip} \
    -e APP_DB_PORT=${dbport}\
    -e APP_DB_USER=${dbuser} \
    -e APP_DB_PASSWORD=${dbpass} \
    -e APP_DATABASE=dbs_dev \
    -p ${port}:8080  sunway/lims:v2

#docker ps -a 
echo "curl -X GET http://172.31.209.221:8100/lims/resource/sunway/index.jsp?url=/lims/"
echo 


