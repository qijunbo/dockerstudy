ENV in Dockerfile
==

- [Dockerfile](Dockerfile)

在这个 Dockerfile 里面，我们定义了一个 USERNAME 环境变量， 默认值是 world。
这个镜像集成于nginx， 目的是想跑一个小的web服务器。

- [docker-entrypoint.sh](docker-entrypoint.sh)

这个是我们自定义的启动入口文件， 镜像启动时， 会执行这里面的语句。
我们在里面使用了之前定义的环境变量， 它被执行后，会在nginx默认的web目录里面生成一个index.html

页面的内容是 Hello，${USERNAME}.

- 执行[build.sh](build.sh)生成镜像。

- 测试 

打开[run.sh](run.sh)文件， 里面又两种执行方式。

不带 USERNAME 参数， 

```
docker run --name nginx -d -p 8888:80 envtest
```

在浏览器里面打开 http://docker-hosst:8888, 可以看见：

> Hello，world

用自定义的值取代默认的 USERNAME 值， 执行下面的语句

```
docker run --name nginx -e USERNAME=QIJUNBO -d -p 8888:80 envtest
```
执行后， 浏览器里面访问 http://docker-hosst:8888, 可以看见：

> Hello，QIJUNBO

$JAVA_OPTS
==

- 首先在 Dockerfile 里面设置这个环境变量

格式可以参考[官方文档](https://docs.docker.com/engine/reference/builder/#env)
```
ENV JAVA_OPTS="-server -Xms256m -Xmx512m -XX:MaxPermSize=256m -Duser.timezone=Asia/Shanghai -Dmdm.cloud=/mdm8 -Dmdm.cv=false -Dmdm.home=/home/mdm8"

```

- 让这个变量生效， 可以在命令行里面嵌入, 可以在 Dockerfile 里面， 也是看在docker-entrypoint.sh 里面， 但要注意语法正确

```
CMD  java $JAVA_OPTS  -jar  youapp.jar


java  $JAVA_OPTS  -jar  youapp.jar

```

- 启动容器时的语法

```
docker run --name mysql -e MYSQL_ROOT_PASSWORD=sunway123# -d -p 3306:3306   mysql

```

- docker-compose.yml 里面的语法

```yml
version: '3.4'
networks:
  webnet:
    driver: bridge
services:
    swhome:
        image: registry.cn-hangzhou.aliyuncs.com/inmost/develop:1.1-cl
        restart: always
        environment:
            JAVA_OPTS: -server -Xms128m -Xmx512m -XX:MaxPermSize=256m -Duser.timezone=Asia/Shanghai -Dmdm.cloud=/mdm8 -Dmdm.cv=false -Dmdm.home=/home/mdm8
            APP_DB_HOST: 172.31.221.150
            APP_DB_PORT: 3336
            APP_DATABASE: mdmdev
            APP_DB_USER: mdmdev
            APP_DB_PASSWORD: mdmdev

```
