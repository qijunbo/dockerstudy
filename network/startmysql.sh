#!/bin/sh
name=$1

if [ -z "${name}" ]; then 
   echo "Usage: $0 name"
   exit -1 ;
fi

rm -rf /opt/mysql/${name}
mkdir -p /opt/mysql/${name}/data
mkdir -p /opt/mysql/${name}/initsql
cp -f init.sql /opt/mysql/${name}/initsql
cp -f docker.cnf /opt/mysql/${name}/

docker network create -d bridge network${name}

docker stop db${name}
docker container prune -f 
docker run --name db${name} -e MYSQL_ROOT_PASSWORD=sunway123# -d \
    -v /opt/mysql/${name}/data:/var/lib/mysql  \
    -v /opt/mysql/${name}/initsql:/docker-entrypoint-initdb.d \
    -v /opt/mysql/${name}/docker.cnf:/etc/my.cnf \
    --net=network${name}\
      mysql \
    --character-set-server=utf8 --collation-server=utf8_general_ci 
docker ps -a   

ip=`docker inspect --format='{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' db${name}`
echo "spring.datasource.url=jdbc:mysql://${ip}:3306/customer?useSSL=false"


cp -f customer.jar /opt/mysql/${name}/ 
cp -f application* /opt/mysql/${name}/
cp -f application-prod.properties.tpl /opt/mysql/${name}/application-prod.properties
echo "spring.datasource.url=jdbc:mysql://${ip}:3306/customer?useSSL=false" >> /opt/mysql/${name}/application-prod.properties
