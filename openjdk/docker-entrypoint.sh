#!/bin/sh
#set -e
echo `ls *jar`
jarfile=`ls *jar`
java  -jar  ${jarfile}

 
