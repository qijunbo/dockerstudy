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

ip=`docker inspect --format='{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' ${db}`
port=`docker inspect --format='{{(index (index .NetworkSettings.Ports "3306/tcp") 0).HostPort}}' ${db}`
echo "jdbc:mysql://${ip}:${port}/dbs_dev?useSSL=false"
echo "testing connectivity between ${name} and ${db}"
echo "docker exec -it ${name} ping ${ip}"
docker exec -it ${name} ping ${ip}





