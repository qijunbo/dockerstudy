FROM nginx:1.13.7
LABEL maintainer="junboqi@foxmail.com"
ENV USERNAME=world
COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod 777 /usr/local/bin/*.sh
ENTRYPOINT docker-entrypoint.sh

