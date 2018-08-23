Redis Quick Start Guide
==

More
--
- [Redis Installation](install.md)


How to use this image
--

- start a redis instance

```
docker run --name redis -d redis
docker run --name redis -d -P redis
docker run --name redis -d -p 6379:6379 redis
```
 
- Verify

```
docker exec -it red bash
redis-cli
set name tony
get 
```

- Security

参考:  http://www.runoob.com/redis/redis-security.html

我们可以通过以下命令查看是否设置了密码验证：

```
127.0.0.1:6379> CONFIG get requirepass
1) "requirepass"
2) "
```

默认情况下 requirepass 参数是空的，这就意味着你无需通过密码验证就可以连接到 redis 服务。

你可以通过以下命令来修改该参数：

```
127.0.0.1:6379> CONFIG set requirepass "runoob"
OK
127.0.0.1:6379> CONFIG get requirepass
1) "requirepass"
2) "runoob"
```

你还可以通过修改配置文件, 来设定redis启动密码
```
docker run -v /myredis/conf/redis.conf:/usr/local/etc/redis/redis.conf --name myredis redis redis-server /usr/local/etc/redis/redis.conf
```


设置密码后，客户端连接 redis 服务就需要密码验证，否则无法执行命令。

语法如下: 

AUTH 命令基本语法格式如下：

```
127.0.0.1:6379> AUTH password
```

实例

```
127.0.0.1:6379> AUTH "runoob"
OK
127.0.0.1:6379> SET mykey "Test value"
OK
127.0.0.1:6379> GET mykey
"Test value"
```


Use Redis in java project
--

Change the ip address and port in [application.properties](gs-messaging-redis-master/src/main/resources/application.properties) Build this project.

You'll see the following output.
```
... ...
2017-10-16 16:15:01.540  INFO 6452 --- [           main] com.examples.redis.Application           : Sending message...
2017-10-16 16:15:01.559  INFO 6452 --- [    container-2] com.examples.redis.Receiver              : Received <Hello from Redis!>
2017-10-16 16:15:01.573  INFO 6452 --- [    container-3] com.examples.redis.Receiver              : Received <send a message again!>
2017-10-16 16:15:01.573  INFO 6452 --- [       Thread-4] s.c.a.AnnotationConfigApplicationContext : Closing org.springframework.context.annotation.AnnotationConfigApplicationContext@2df32bf7: startup date [Mon Oct 16 16:15:00 CST 2017]; root of context hierarchy
2017-10-16 16:15:01.575  INFO 6452 --- [       Thread-4] o.s.c.support.DefaultLifecycleProcessor  : Stopping beans in phase 2147483647
2017-10-16 16:15:01.578  INFO 6452 --- [       Thread-4] o.s.j.e.a.AnnotationMBeanExporter        : Unregistering JMX-exposed beans on shutdown

```

Customize
--

```
FROM redis
COPY redis.conf /usr/local/etc/redis/redis.conf
CMD [ "redis-server", "/usr/local/etc/redis/redis.conf" ]
```


Reference
--

https://docs.docker.com/samples/library/redis/#start-a-redis-instance

https://github.com/docker-library/redis

http://www.yiibai.com/redis/redis_quick_guide.html

