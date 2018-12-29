#!/bin/sh
#set -e

jarfile=`ls *jar`
if [ -x "/init.d/start.sh" ]; then
    echo `ls -lh /init.d`
    /init.d/start.sh

elif  [ -f "$jarfile" ]; then
    echo $jarfile
    java  $JAVA_OPTS -jar  ${jarfile}
fi

echo '已经执行完所有指令, 进入空转程序.'
while sleep 60; do

  echo `ps -aux`

done

 
