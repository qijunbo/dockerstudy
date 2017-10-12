Docker  REST API 使用指南
--

- Keywords:  container, daemon, runtime, rest api, http, https


- Reference: 

 https://docs.docker.com/engine/reference/commandline/dockerd/#daemon-socket-option

 http://0pointer.de/blog/projects/socket-activation.html

 https://docs.docker.com/datacenter/ucp/2.2/reference/api/
 https://stackoverflow.com/questions/46108273/how-can-i-use-rest-api-to-interact-with-docker-engine
 
老外就是啰嗦, 尼玛本来简单几句就能说清楚的事情, 说了几页纸还把劳资说的晕头转向.

- The Universal Control Plane API (UCP API)

docker 常用的指令例如 ``` docker container stop xxx ,  docker image  rm xxx  ``` 等等, 除了可以在命令行环境下操作, 多数的还可以用 HTTP REST API 来完成.
注意, 是多数, 不是全部.  官方列出来的功能都在这里了.

https://docs.docker.com/datacenter/ucp/2.2/reference/api/


- BIND DOCKER TO ANOTHER HOST/PORT OR A UNIX SOCKET

比较奇葩的是, docker 默认是不开启REST API的服务的, 为毛呢?  因为他们根本没有提供安全性验证, 也就是说, 一旦打开了, 不用验证, 谁都可以调用. (你妹的).

你可以用下面的指令打开 REST API 服务.  如果你喜欢看加长版的,(真他妈的啰嗦, 而且还让人看不懂), [点这里](https://docs.docker.com/engine/reference/commandline/dockerd/#daemon-socket-option) 

这两条指令足够解决问题了.

```
systemctl stop docker
/usr/bin/dockerd  -H tcp://127.0.0.1:2376 -H unix:///var/run/docker.sock -H  192.168.64.131:2376 &
```

解释:  

1.  -H  参数出现了3次,  说明可以同时以3种形式提供服务.  如果你机器有多个网卡,多个ip, 可以这样指定, 在特定的ip地址上监听, 保证安全性.
2.  执行这个玩意, 要先把服务停下, 然后再用(&符号)后台运行的方式启动. (我也是醉了, 其实还有更好的方法, 把它做成一个服务. 我以后慢慢研究.) 
3.  tcp://127.0.0.1:2376  前面的 ``` tcp:// ``` 可以省略. 


用0.0.0.0表示在所有的ip地址上监听. 不过这样太不安全, 别这么搞.
```
systemctl stop docker
/usr/bin/dockerd  -H tcp://127.0.0.1:2376 -H unix:///var/run/docker.sock -H 0.0.0.0:2376 &
```

- Verify

然后你就可以验证了:   http://192.168.64.131:2376/containers/json   (这个也比较奇葩, 只会显示活着的容器, "死的"和"退出的", 就看不见了.)