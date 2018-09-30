version: '3.4'

services:
  db:
    image: mysql:5.7
    volumes:
      - ./database:/var/lib/mysql
      - /docker/everyone/initsql:/docker-entrypoint-initdb.d
      - /docker/everyone/conf/docker.cnf:/etc/my.cnf
    ports:
      - "${dbport}:3306"
    networks:
      - webnet   
    restart: always
    environment:
      MYSQL_ROOT_PASSWORD: sunway123#
      MYSQL_DATABASE: ${dbname!elab}
      MYSQL_USER: ${dbuser!elab}
      MYSQL_PASSWORD: ${dbpassword}
  redis:
    image: redis:alpine
    volumes:
      - /docker/everyone/redis/redis.conf:/usr/local/etc/redis/redis.conf
    networks:
      - webnet
    deploy:
      restart_policy:
        condition: on-failure
    entrypoint:
      - redis-server
      - /usr/local/etc/redis/redis.conf
    restart: always 
  web:
    depends_on:
      - db
    image: registry.cn-hangzhou.aliyuncs.com/qijunbo/lims:elab-2018.08.24
    volumes:
      - ./logs:/usr/local/tomcat/logs
      - ./appLog:/appLog
    ports:
      - "${appport}:8080"
    networks:
      - webnet
    restart: always
    environment:
      CONTEXTPATH: ${name}
      RESOURCE_NAME: framework
      APP_DB_HOST: db
      APP_DB_PORT: 3306
      APP_DB_USER: ${dbuser!elab}
      APP_DB_PASSWORD: ${dbpassword}
      APP_DATABASE: ${dbname!elab}
networks:
  webnet: