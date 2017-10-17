Tomcat Doker Image Quick Guide
==

Start
--
```
#!/bin/sh
name=$1
db=$2
if [ -z "${name}" ]; then
   echo "Usage $0 name db"
   exit -1 ;
fi

if [ -z "${db}" ]; then
   echo "Usage $0 name db"
   exit -1 ;
fi

mkdri -p /opt/webapp/logs
cp  ./*.war  /opt/webapp/
docker container prune -f
docker run --name ${name} -d \
    --link ${db}:mysql \
	-v /opt/webapp:/usr/local/tomcat/webapps \
    -v /opt/webapp/logs:/usr/local/tomcat/logs  -P \
	 tomcat
docker ps -a 
```

Reference
--

https://github.com/qijunbo/tomcat/tree/master/8.5/jre8-alpine

https://docs.docker.com/docker-hub/official_repos/

https://docs.docker.com/engine/userguide/eng-image/dockerfile_best-practices/#use-a-dockerignore-file




