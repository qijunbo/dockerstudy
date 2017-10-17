Redis Quick Start Guide
==

More
--
- [Redis Installation](install.md)


How to use this image
--

- start a redis instance

```
docker run --name red -d redis
docker run --name red -d -P redis
docker run --name red -d -p 6379:6379 redis
```
官方默认的容器安全性上设计的不太完美, 不需要密码也可以访问. 如果能够在启动的时候,传入参数就好了, 可以参考mysql容器的设计方式, 从新定制.

- Verify

```
docker exec -it red bash
redis-cli
set name tony
get 
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



Reference
--

https://docs.docker.com/samples/library/redis/#start-a-redis-instance

https://github.com/docker-library/redis

http://www.yiibai.com/redis/redis_quick_guide.html

