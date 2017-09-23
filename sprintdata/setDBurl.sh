#!/bin/sh
name=$1
if [ -z "${name}" ]; then
   echo "Usage $0 name"
   exit -1 ;
fi

url=`./getdburl.sh ${name}`
echo ${url}
sed  s/{mysqldburl}/"${url}"/g ./application-prod.yml.ftl
echo sed s/{mysqldburl}/"${url}"/g ./application-prod.yml.ftl 


