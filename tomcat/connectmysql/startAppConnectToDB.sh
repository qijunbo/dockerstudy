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

mkdri -p /root/dockerstudy/tomcat/connectmysql/logs
docker container prune -f
docker run --name ${name} -d \
    --link ${db}:mysql \
    -v /root/dockerstudy/tomcat/connectmysql/logs:/usr/local/tomcat/logs  -P \
	 qijunbo/tomcatwebapp
docker ps -a 
echo 	 
docker port ${name}



