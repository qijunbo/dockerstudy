#!/bin/sh
set -e
container=$1

if [ -z "${container}" ]; then
   echo "Usage: $0 containerName"
   exit -1 ;
fi


## dbconfig   对于每个不同的项目, 下面的配置项都是不一样的, 要仔细修改.
## datapath 字段是 mysql docker 容器启动的时候, 设置的数据保存路径
datapath=/opt/limsst/mysql
password=sunway123#
database=lims-st
## dbconfig 结束

 
backuppath=${datapath}/data/backup
datetime=`date "+%Y-%m-%d_%H:%M:%S"`
mkdir -p ${backuppath}
backupfile=backup-${datetime}.sql
logfile=${backuppath}/${datetime}.log

/bin/docker exec -it ${container} mysqldump -u root -p${password} ${database}  --result-file=/var/lib/mysql/backup/${backupfile}
echo  full backup of db ${database} at ${datetime} > ${logfile}
ls -l >${logfile}
/bin/mailx -s "DB ${database} 自动备份记录" qijb@sunwayworld.com < ${logfile}


 


