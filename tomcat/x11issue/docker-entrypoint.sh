#!/bin/sh

#set -e

jarfile=`ls *jar`
echo $?
# if we can not find any jar file in current working folder, then start tomcat.
if [ $? -gt 0 ]      
then  
	/usr/local/tomcat/bin/catalina.sh run
fi

# else start java -jar
echo ${jarfile}
java  -jar  ${jarfile}

