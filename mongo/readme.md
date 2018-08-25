mongo
==

启动单个mongoDB容器
--

```
docker run --name mongo -d -P  mongo
docker run --name mongo -d -p 27017:27017  mongo 
```

执行 ``` docker ps -a ``` 可以看到mongo默认的端口是 27017

```
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS                      NAMES
d1dee0c67a50        mongo               "docker-entrypoint..."   5 seconds ago       Up 4 seconds        0.0.0.0:32768->27017/tcp   mongo
```

启动带用户名和密码的容器
--
```
docker run --name mongo -e MONGO_INITDB_ROOT_USERNAME=root -e MONGO_INITDB_ROOT_PASSWORD=sunway -d -p 27017:27017  mongo 
```

在客户端登录
--
```
docker exec -it mongo mongo 
> use admin
switched to db admin
> db.auth("root", "sunway")
1
```
参考链接: https://www.jianshu.com/p/79caa1cc49a5

via docker stack deploy or docker-compose
--
```
# Use root/example as user/password credentials
version: '3.1'

services:

  mongo:
    image: mongo
    restart: always
    environment:
      MONGO_INITDB_ROOT_USERNAME: root
      MONGO_INITDB_ROOT_PASSWORD: example

  mongo-express:
    image: mongo-express
    restart: always
    ports:
      - 8081:8081
    environment:
      ME_CONFIG_MONGODB_ADMINUSERNAME: root
      ME_CONFIG_MONGODB_ADMINPASSWORD: example
```

向镜像里面传参数的例子
--
```
version: '3.1'
services:
  mongo:
    image: mongo
    command: --smallfiles
```
