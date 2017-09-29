#!/bin/sh
name=$1

if [ -z "${name}" ]; then
   echo "Usage: $0 name"
   exit -1 ;
fi

docker exec -it ${name} mysqladmin -uroot -psunway123# variables  | grep  "case"
echo 
echo "-------------------------------"
echo "Customized mysql configure: "
docker exec -it ${name} cat /etc/my.cnf 
echo "-------------------------------"
echo "check the existance of init.sql :" 
docker exec -it ${name} ls -l /docker-entrypoint-initdb.d
echo 
docker exec -it ${name} mysql -uroot -psunway123# -e "show databases;"

docker exec -it ${name} mysql -uroot -psunway123# -e "SELECT host FROM mysql.user WHERE User = 'root';"


