#!/bin/sh
#set -e
echo `ls *jar`
jarfile=`ls *jar`
java  $JAVA_OPTS -jar  ${jarfile}

 
