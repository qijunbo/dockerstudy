FROM centos:7.5.1804
ADD jdk-8u151-linux-x64.rpm .
RUN rpm -ivh jdk-8u151-linux-x64.rpm
RUN rm -f jdk-8u151-linux-x64.rpm
ENV JAVA_OPTS=""
VOLUME /app
WORKDIR /app
EXPOSE 80 8080 443
COPY  docker-entrypoint.sh /bin/
ENTRYPOINT docker-entrypoint.sh
