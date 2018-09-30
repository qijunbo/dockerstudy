#!/bin/sh

version=$1
if [ -z "${version}" ]; then 
   echo Usage: ${0} version
   exit -1 ;
fi


chmod +x *.sh
docker image build -t qijunbo/tomcat:${version}  .
docker images  
