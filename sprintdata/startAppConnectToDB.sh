#!/bin/sh
name=$1
db=$2
if [ -z "${name}" ]; then
   echo "Usage $0 name db"
   exit -1 ;
fi

if [ -z "${db}" ]; then
   echo "Usage $0 name db"
   exit -1 ;
fi

docker container prune -f
docker run --name ${name} -d \
    --link ${db}:mysql \
    -v /root/dockerstudy/webapp:/root/webapp -P \
	 qijunbo/springdata
docker port ${name}



