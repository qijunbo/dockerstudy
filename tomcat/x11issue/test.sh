#!/bin/sh
version=$1

if [ -z "${version}" ]; then 
   echo Usage: $0  version
   exit -1 ;
fi
docker stop lims
docker rm lims
docker run --name lims -d \
    --link mysql:db \
    -p 8100:8080  sunway/lims:${version}

#docker ps -a 
echo "curl -X GET http://172.31.209.221:8100/lims/resource/sunway/index.jsp?url=/lims/"
echo 


