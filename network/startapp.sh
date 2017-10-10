#!/bin/sh
name=$1

if [ -z "${name}" ]; then 
   echo "Usage: $0 name"
   exit -1 ;
fi

docker stop app${name}
docker container prune -f
docker run --name app${name} -d \
    -v /opt/mysql/${name}:/usr/local/tomcat -P \
    --net=network${name}\
        qijunbo/java:8
docker port app${name}

ip=`/sbin/ip addr show ens33|grep "inet "|grep -v 127.0.0.1|awk '{print $2}'`
port=`docker inspect --format='{{(index (index .NetworkSettings.Ports "80/tcp") 0).HostPort}}' app${name}`
echo "http://${ip%/*}:${port}"
