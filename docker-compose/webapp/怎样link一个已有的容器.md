从一个已有的数据库启动应用程序
==

要想连上一个已经存在的数据库容器， 首先要保证和已有的容器在同一个网络里面， 否则无从连起。

参考下面的yml文件。

```
version: '3.4'

networks:
  bridge:
    driver: bridge
    external:     # 这个关键字表示链接外部已经存在的网络。 
      name: compose_bridge   # 这个是已经存在的网络的名称，  使用docker-compose启动是，名称无法指定， 但是有规律可循 projectaname_drivername
services:
  web:
    image: sunway/lims:v2
    container_name: lims_good_name  #自己指定容器名称。
    deploy:
      replicas: 1
      restart_policy:
        condition: on-failure
    ports:
      - "32894:8080"   #自己指定端口映射。
    external_links:  
      - "good_name:db"   #冒号前面是已经存在的容器名称， 冒号后面是别名， 可以在本容器内使用。
    networks:
      - bridge
    restart: always
    environment:
      CONTEXTPATH: limsv2
      RESOURCE_NAME1: framework
      RESOURCE_NAME2: jdbc/framework
      APP_DB_HOST: db             #使用别名来访问数据库。 既然都已经使用别名了， 说明已经存在的数据库是不必要对外暴露端口的。
      APP_DB_PORT: 3306
      APP_DB_USER: root
      APP_DB_PASSWORD: sunway123#
      APP_DATABASE: dbs_dev


```

执行``` docker-compose up -d ```  启动容器，  然后进入容器来测试一下。

```
docker exec -it lims_good_name  ping db
```

发现，是可以ping 到 已有的容器的。

```
bash-4.3# ping db
PING db (172.18.0.2): 56 data bytes
64 bytes from 172.18.0.2: seq=0 ttl=64 time=0.099 ms
64 bytes from 172.18.0.2: seq=1 ttl=64 time=0.091 ms
64 bytes from 172.18.0.2: seq=2 ttl=64 time=0.090 ms
64 bytes from 172.18.0.2: seq=3 ttl=64 time=0.091 ms
64 bytes from 172.18.0.2: seq=4 ttl=64 time=0.089 ms
^C
```

由以上试验可以类推。 下面的方案也是可行的。

1. 启动一个nginx 共享服务，  这个时候， 网络就被创建了。

2. 启动一个数据库容器， 并且使用上一部创建的网络。

3. 启动一个web应用， 也使用上面的网络， 同时link 上面的数据库。

4. 生成一个nginx配置文件， 然后reload nginx服务。

