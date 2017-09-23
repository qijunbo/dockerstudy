FROM qijunbo/mysql
RUN yum install -y java
ENV CATALINA_HOME /usr/local/tomcat
ENV PATH $CATALINA_HOME/bin:$PATH
RUN mkdir -p "$CATALINA_HOME"
WORKDIR $CATALINA_HOME
COPY tomcat $CATALINA_HOME/
COPY startall.sh /usr/bin/startall
VOLUME /usr/local/tomcat/webapps 
EXPOSE 8080
CMD ["startall"]




