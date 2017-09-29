# Java8 #

### What is this repository for? ###
* Quick summary

这个容器继承于CentOS, 并安装了java运行时环境, 是用来开发spring-boot可执行jar项目的环境.

This container inherits from **CentOS**, and have latest java runtime environment installed. It's the best choice for developing spring-boot executable jar project. 

* Version 1.0

### How do I get set up? ###

* Configuration

虽然下面暴露80等4个端口, 但是具体多少个会生效取决于你在 application.yml里面的配置. 本例使用的80端口,其他无效.

```
FROM centos
RUN yum install -y java
VOLUME /root/webapp
WORKDIR /root/webapp
EXPOSE 80 8080 443 8443
CMD  java -jar *.jar

```
* Summary of set up

执行 **rebuild.sh** 生成镜像. 然后run.
```
./rebuild.sh   
docker run --name you-app-name  -d  -v  /path/of/your/app:/root/webapp   -P  qijunbo/java:8
```

Deployment instructions
--
- 制作jar包

从[git@github.com:qijunbo/gs-accessing-data-jpa.git](https://github.com/qijunbo/gs-accessing-data-jpa/tree/jar-yml) 获取jar-yml分支.

- 运行官方Mysql容器

官方的mysql比较可靠, 从[这里](https://github.com/qijunbo/dockerstudy/tree/master/officalMysql)下载.

至于为什么可靠, 可以参考 [Readme](https://github.com/qijunbo/mysql-docker/tree/mysql-server/8.0)

- Database configuration

获取数据源url

```
./getdburl.sh mysql 
```
然后修改 application-prod.yml 里面的 url 

当然, 你也可以使用下面的方法,进行更残酷的测试.

if you app need a datasource in another docker container, use ** --link ** to get connected.

** 你发现没有, 下面这句指令居然没有用(-p 或者 -P)做端口映射 **  也就是说这个容器从外面连不上,只能从里面连.

**经过验证** 下面这句不加(-P/-p)端口映射是没有意义的, 因为你无法访问你的app, **但是**, 启动的mysql容器是可以不加(-P/-p)端口映射, 用下面的方法**可以连接成功** .
```
docker run --name you-app-name --link mysql-container:mysql -d  qijunbo/java:8

```
- 运行起来

```
./startAppConnectToDB.sh  qijunbo  mysql
```

- How to run tests

```
docker port qijunbo
curl -X GET http://ip:port
```


### Contribution guidelines ###

* Other guidelines
	send pull request from [https://github.com/qijunbo/dockerstudy](https://github.com/qijunbo/dockerstudy)
	

### Who do I talk to? ###

* Repo owner or admin

	junboqi@foxmail.com 
	
* Other community or team contact

