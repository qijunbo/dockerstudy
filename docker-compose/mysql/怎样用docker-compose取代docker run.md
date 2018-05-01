启动单个容器
==

用docker run 指令启动一个容器， 默认的情况下， 这个容器被放在bridge这个network里面。

下面是启动一个数据库的例子. ( 为什么我们要多此一举呢， 那是因为有时候启动数据库的时候， 需要初始化一个很长的脚本， 必须把数据库的启动和应用的启动分两步完成。)

```
version: '3.4'
networks:
  bridge:
    driver: bridge  #指明了使用的network就是默认的netowrk -- bridge
services:
  db:
    image: mysql
    container_name: good_name  #自定义容器名字
    volumes:   #指明了数据存储的路径
      - /docker/qijunbo/data:/var/lib/mysql
      - /docker/everyone/initsql/:/docker-entrypoint-initdb.d
      - /docker/everyone/conf/docker.cnf:/etc/my.cnf
    networks:
      - bridge
    restart: always
    ports:
      - "3309:3306" #指明了端口映射的情况
    environment:
      MYSQL_ROOT_PASSWORD: sunway123#
      MYSQL_DATABASE: dbs_dev
      MYSQL_USER: root
      MYSQL_PASSWORD: sunway123#

```

执行完之后， 执行 ``` docker ps -a ``` 可以看到如下输出.  端口映射，名字， 都在自己的掌控之中。

```
CONTAINER ID   IMAGE    COMMAND                  CREATED         STATUS        PORTS                   NAMES
cb66408504a2   mysql    "docker-entrypoint..."   3 seconds ago   Up 3 seconds  0.0.0.0:3309->3306/tcp  good_name

```

而且更屌的是， 如果修改了配置， 直接把下面的指令再执行一遍， 就可以生效。

```
docker-compose up -d
```


