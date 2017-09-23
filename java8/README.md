#Java8

# README #

This README would normally document whatever steps are necessary to get your application up and running.

### What is this repository for? ###
* Quick summary

这个容器继承于CentOS, 并安装了java运行时环境, 是用来开发spring-boot可执行jar项目的环境.

This container inherits from **CentOS**, and have latest java runtime environment installed. It's the best choice for developing spring-boot executable jar project. 

* Version

1.0

### How do I get set up? ###
* Configuration

```
FROM centos
RUN yum install -y java
VOLUME /root/webapp
WORKDIR /root/webapp
EXPOSE 80 8080 443 8443
CMD  java -jar *.jar

``
* Summary of set up

```
docker run --name you-app-name  -d  -v  /path/of/your/app:/root/webapp   -P  qijunbo/java:8
```

* Dependencies
* Database configuration

if you app need a datasource in another docker container, use ** --link ** to get connected.
```
docker run --name you-app-name --link mysql-container:mysql -d  qijunbo/java:8

```

* Deployment instructions

* How to run tests


### Contribution guidelines ###

* Other guidelines
	send pull request from [https://github.com/qijunbo/dockerstudy](https://github.com/qijunbo/dockerstudy)
	

### Who do I talk to? ###

* Repo owner or admin

	junboqi@foxmail.com 
	
* Other community or team contact

