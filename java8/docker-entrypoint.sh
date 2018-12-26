#!/bin/sh
#set -e


if [ -x "/init.d/start.sh" ]; then
    echo `ls -lh /init.d`
    /init.d/start.sh

elif  [ -x "$jarfile" ]; then
    jarfile=`ls *jar`
    echo $jarfile
    java  $JAVA_OPTS -jar  ${jarfile}
fi

echo '已经执行完所有指令, 进入空转程序.'
while sleep 60; do

  echo `ps -aux`

done

 
