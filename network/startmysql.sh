#!/bin/sh
name=$1

if [ -z "${name}" ]; then 
   echo "Usage: $0 name"
   exit -1 ;
fi

rm -rf /opt/myproject/${name}
mkdir -p /opt/myproject/${name}/data
mkdir -p /opt/myproject/${name}/initsql
cp -f init.sql /opt/myproject/${name}/initsql
cp -f docker.cnf /opt/myproject/${name}/

docker network create -d bridge network${name}

docker stop db${name}
docker container prune -f 
docker run --name db${name} -e MYSQL_ROOT_PASSWORD=sunway123# -d \
    -v /opt/myproject/${name}/data:/var/lib/mysql  \
    -v /opt/myproject/${name}/initsql:/docker-entrypoint-initdb.d \
    -v /opt/myproject/${name}/docker.cnf:/etc/my.cnf \
    --net=network${name}\
      mysql \
    --character-set-server=utf8 --collation-server=utf8_general_ci 
docker ps -a   

ip=`docker inspect --format='{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' db${name}`
echo "spring.datasource.url=jdbc:mysql://${ip}:3306/customer?useSSL=false"


cp -f customer.jar /opt/myproject/${name}/ 
cp -f application* /opt/myproject/${name}/
cp -f application-prod.properties.tpl /opt/myproject/${name}/application-prod.properties
echo "spring.datasource.url=jdbc:mysql://${ip}:3306/customer?useSSL=false" >> /opt/myproject/${name}/application-prod.properties
