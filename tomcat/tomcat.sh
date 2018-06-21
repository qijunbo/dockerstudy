#!/bin/sh

docker run --name tomcat7 -d \
    --link ${db}:mysql \
    -v $(pwd)/webapp:/usr/local/tomcat/webapps \
    -v $(pwd)/logs:/usr/local/tomcat/logs  -p 8080:8080 \
     tomcat:7-alpine
docker ps -a