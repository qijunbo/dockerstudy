#!/bin/sh
container=$1
if [ -z "${container}" ]; then 
   echo Usage: $0 containerName
   exit -1 ;
fi

systemctl stop nginx
docker stack rm lims
systemctl start nginx
docker ps -a 
