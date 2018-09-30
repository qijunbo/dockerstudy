#Create image based on tomcat8 to support X11 issue
FROM  tomcat:8.5.34-jre8
MAINTAINER qijunbo <junboqi@foxmail.com> 
LABEL name="X11"  
COPY  docker-entrypoint.sh /usr/local/bin/
COPY  catalina.sh /usr/local/tomcat/bin
ENV CONTXTPATH=lims RESOURCE_NAME=framework APP_DB_HOST=db APP_DB_PORT=3306 APP_DB_USER=root APP_DB_PASSWORD=sunway123# APP_DATABASE=dbs_dev  SWLIMS_INDUSTRY=elab
VOLUME /usr/local/tomcat/logs /usr/local/tomcat/conf/  /app
WORKDIR /app
ENTRYPOINT docker-entrypoint.sh
