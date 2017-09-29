#!/bin/sh
name=$1

if [ -z "${name}" ]; then
   echo "Usage: $0 name"
   exit -1 ;
fi

docker exec -it ${name} mysqladmin -uroot -psunway123# variables  | grep  "case"

docker exec -it ${name} cat /etc/my.cnf 
echo 
docker exec -it ${name} mysql -uroot -psunway123# -e "show databases;"

docker exec -it ${name} mysql -uroot -psunway123# -e "SELECT host FROM mysql.user WHERE User = 'root';"


