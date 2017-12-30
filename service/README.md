Service
==

### 关于服务

在分布式应用程序中，应用程序的不同部分被称为“服务”。例如，如果您想象一个视频共享站点，它可能包括一个用于将应用程序数据存储在数据库中的服务，后面的视频转码服务用户上传东西，为前端服务等等。

服务实际上只是“生产中的容器”。服务只运行一个映像，但它编码图像运行的方式 - 应该使用哪个端口，容器应该运行多少个副本，以便服务具有所需的容量，以及等等。缩放服务会更改运行该软件的容器实例的数量，从而为流程中的服务分配更多的计算资源。

幸运的是，使用Docker平台定义，运行和扩展服务非常简单 - 只需编写一个[docker-compose.yml](docker-compose.yml)文件即可。

该[docker-compose.yml](docker-compose.yml)文件告诉Docker执行以下操作：

- 按这里的步骤生成Docker 镜像。[swagger-demo](https://github.com/qijunbo/swagger-demo/tree/master/docker)
- 运行该图像的5个实例作为一个服务调用web，限制每个使用，最多10％的CPU（跨所有核心）和50MB的RAM。
- 如果一个失败，立即重新启动容器。
- 将主机上的端口32794映射到web端口80。
- 指导web容器通过一个负载平衡的网络共享80端口webnet。（在内部，容器本身将web在临时端口上发布到 端口80）。
- webnet使用默认设置（这是一个负载平衡覆盖网络）定义网络。

### 运行新的负载平衡应用程序

在我们可以使用这个```docker stack deploy```命令之前，我们先运行：
```
docker swarm init
```

> 注意：我们将在[第4部分](https://docs.docker.com/get-started/part4/)讨论该命令的含义。如果你不执行这个 ``` docker swarm init ``` 你会得到一个错误，“这个节点不是一个群管理器”。

```
$>  docker stack deploy -c docker-compose.yml swagger_demo
Creating network swagger_demo_webnet
Creating service swagger_demo_web
```

获取服务的名字

```
[root@izm5eaj3xjio5ppzd4ubxtz service]# docker service ls
ID                  NAME                MODE                REPLICAS            IMAGE                         PORTS
xu759ewn6onk        swagger_demo_web    replicated          2/5                 qijunbo/swagger_demo:latest   *:32794->80/tcp
```

然后， 看一下跑的效果

```
docker service ps swagger_demo_web

[root@izm5eaj3xjio5ppzd4ubxtz service]# docker stack ps swagger_demo
ID                  NAME                     IMAGE                         NODE                      DESIRED STATE       CURRENT STATE                                                                                           ERROR                         PORTS
pgtst8jquy0g        swagger_demo_web.1       qijunbo/swagger_demo:latest   izm5eaj3xjio5ppzd4ubxtz    

```

### 缩放应用程序

您可以通过更改[docker-compose.yml](docker-compose.yml)中的replicas值，保存更改并重新运行docker stack deploy命令来缩放应用程序：

```
docker stack deploy -c docker-compose.yml gswagger_demo
```

Docker会做一个就地更新，不需要先撕下堆栈或杀死任何容器。

现在，重新运行``` docker container ls -q  ``` 以查看重新配置的已部署实例。如果你扩大了副本，更多的任务，因此，更多的容器，开始。

### 验证

在浏览器里面访问 http://localhost:32794 访问本demo， 先删除两条数据，接下来反复按F5刷新， 你会看到页面上的数据不大一样， 因为本demo每个实例用得都是独立的数据库， 而且没有做数据同步， 这样你就可以很清晰的看到来自不同实例的数据不一样。

执行下面这条指令， 你会发现PORTS那一列， 宿主机并没有端口和内部的端口80一一绑定，至于原理， 要仔细读读这篇文章 [Configure service discovery](https://docs.docker.com/engine/swarm/networking/#configure-service-discovery) 


```
[root@izm5eaj3xjio5ppzd4ubxtz ~]# docker ps -a
CONTAINER ID        IMAGE                         COMMAND                  CREATED             STATUS              PORTS                              NAMES
3cef2add635a        qijunbo/swagger_demo:latest   "/bin/sh -c docker..."   8 minutes ago       Up 8 minutes        80/tcp                             demo_web.2.hym6vb77kwcddpallssmw448d
efe197a322a0        qijunbo/swagger_demo:latest   "/bin/sh -c docker..."   17 minutes ago      Up 17 minutes       80/tcp                             demo_web.1.a6gynega48ul8s5czwum06s55
```


### 取下应用程序和群

拿下应用程序docker stack rm：

```
docker stack rm gswagger_demo
```

离开这个 swarm

```
docker swarm leave --force
```

### 擦屁股

```
docker ps -a
# 查看一下， 有把握之后执行下面的清理动作。
docker network prune -f
docker contaienr prune -f
```

踩过的坑
==

- 遇到坑的版本如下

```
$> uname -a
Linux izm5eaj3xjio5ppzd4ubxtz 3.10.0-514.26.2.el7.x86_64 #1 SMP Tue Jul 4 15:04:05 UTC 2017 x86_64 x86_64 x86_64 GNU/Linux
$> cat /etc/redhat-release
CentOS Linux release 7.3.1611 (Core)
$> docker swarm init
Error response from daemon: --live-restore daemon configuration is incompatible with swarm mode
```
答案在 [这里](https://forums.docker.com/t/error-response-from-daemon-live-restore-daemon-configuration-is-incompatible-with-swarm-mode/28428) 

```
[root@izm5eaj3xjio5ppzd4ubxtz service]# cat /etc/docker/daemon.json
{
 "registry-mirrors": ["http://hub-mirror.c.163.com"],
 "live-restore": true  # 这行不要， 是个坑
}
```
我[手动修改](https://github.com/qijunbo/dockerstudy/blob/master/install.md)了"registry-mirrors"的国内加速服务器， 但是顺便加了一行我看不懂的代码 ``` "live-restore": true ``` ,   ** 删掉这行即可 **

```
{
  "registry-mirrors": ["https://jcgiimz8.mirror.aliyuncs.com"]
}
```
重启docker 服务

```
systemctl restart docker


$> docker swarm init
Swarm initialized: current node (j7fa7oyxomx6alsuoxmqftyzq) is now a manager.

To add a worker to this swarm, run the following command:

    docker swarm join --token SWMTKN-1-5qmpvjgl7bw2sjcwry8tq39gal7qr84apsecezl7js0430h6mr-3bsycg6gk9q3wmg1uzaopnp6r 172.31.209.221:2377

To add a manager to this swarm, run 'docker swarm join-token manager' and follow the instructions.

```
从上面的输出可以看出， 一旦你初始化成功， 它会返回当前 swarm manager的 tocken，这样你把其他机器（术语叫 worker）加到这个 manager 里面的时候， 就用上这个 tocken了。

- 资源分配

[docker-compose.yml](docker-compose.yml) 文件里面也有个小坑， 就是指定cpu和memory, 如果你给的太小，系统肯定起不来。 如果内存足够， 但是cpu给的太少， 那么就会慢到毁三观。
用 ``` docker attach <container id> ``` 命令进去看看， log都是一行一行慢慢蹦出来。 

所以建议是， 干脆不要做限制。 
