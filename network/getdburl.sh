#!/bin/sh
name=$1
if [ -z "${name}" ]; then
   echo "Usage $0 name"
   exit -1 ;
fi
ip=`docker inspect --format='{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' ${name}`
echo "jdbc:mysql://${ip}:3306/customer?useSSL=false"





