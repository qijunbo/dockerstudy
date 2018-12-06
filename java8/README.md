# Java8 #

### What is this repository for? ###
* Quick summary

本实例用CentOS7做基础, 安装了Oracle, 用来为spring-boot可执行jar工程提供运行时环境.

This container inherits from **CentOS**, and have oracle java 8 runtime environment installed. It's the best choice for developing spring-boot executable jar project. 

### start using docker-compose

``` 
docker-compose up -d 
```

docker-compose.yml

```yml
version: '3.4'
networks:
    webnet:
        driver: bridge
services:
    webapp:
        image: registry.cn-qingdao.aliyuncs.com/qijunbo/jdk:8
        ports:
            - 8080:80
        restart: always
        environment:
            JAVA_OPTS: -server -Xms256m -Xmx1024m -XX:MaxPermSize=256m -Duser.timezone=Asia/Shanghai
        volumes:
            - ./app.jar:/app/webapp.jar
```


* Configuration

虽然下面暴露80等3个端口, 但是具体多少个会生效取决于你在 application.yml里面的配置. 本例使用的80端口,其他无效.

```
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
```
 
* you can customize the ``` JAVA_OPTS ``` value in docker-compose.yml
 

### 使用现成的docker image:

> registry.cn-qingdao.aliyuncs.com/qijunbo/jdk:8

``` 
docker run --name you-app-name  \
    -v /fullpath/yourapp.jar:/app/app.jar \
	-v /fullpath/application.yml:/app/application.yml \
	-d -P registry.cn-qingdao.aliyuncs.com/qijunbo/jdk:8
```


### How do I get set up? ###

- 下载自己喜欢的java版本安装包 jdk-8u151-linux-x64.rpm, 放在当前目录下.
- 修改Dockerfile
- 执行rebuild.sh 重新打包.




Deployment instructions
--
- 制作供演示用的jar包

从[git@github.com:qijunbo/gs-accessing-data-jpa.git](https://github.com/qijunbo/gs-accessing-data-jpa/tree/jar-yml) 获取jar-yml分支.

- 运行官方Mysql容器

官方的mysql比较可靠, 从[这里](https://github.com/qijunbo/dockerstudy/tree/master/officalMysql)下载.

至于为什么可靠, 可以参考 [Readme](https://github.com/qijunbo/mysql-docker/tree/mysql-server/8.0)

- Database configuration
 
 连接到mysql数据库的容器,  
```
docker run --name you-app-name  \
    --link mysql-container:mysql  \
	-v /fullpath/yourapp.jar:/app/app.jar \
	-v /fullpath/application.yml:/app/application.yml  \
	-d -P  registry.cn-qingdao.aliyuncs.com/qijunbo/jdk:8
```

  
### Who do I talk to? ###

* Repo owner or admin

	junboqi@foxmail.com 
	
* Other community or team contact

