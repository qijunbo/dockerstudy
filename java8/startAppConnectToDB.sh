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

mkdir -p /opt/springdata/${name}/
cp -f customer.jar /opt/springdata/${name}/
cp -f application* /opt/springdata/${name}/

docker stop ${name} 
docker container prune -f
docker run --name ${name} -d \
    --link ${db}:mysql \
    -v /opt/springdata/${name}:/root/webapp -P \
	 qijunbo/java:8
docker port ${name}



