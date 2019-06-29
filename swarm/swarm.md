Service Discovery under Swarm Mode.
==

### 目的

本实验的目的是说明服务发现如何在群集模式下工作。

###  应用程序

WordPress是基于PHP和MySQL的开源内容管理系统（CMS）。这是一个非常简单的容器应用程序，经常在聚会和会议中用于演示目的。

### 初始化swarm

先来创建一个Docker Swarm。打开第一个实例并启动Swarm模式群集。

```
docker swarm init --advertise-addr $(hostname -i)
```

> $(hostname -i)  这个指令在CentOS 7 上面已经不能正确的获取ip地址了.

可以用下面的指令获取ip

```
export ipaddr=`ip a show eth0 | grep inet  | awk '{ print $2}'`
echo ${ipaddr%/*}
```
 

该节点成为主节点。输出显示一个命令，将一个工作节点添加到这个群中，如下所示：

```
Swarm initialized: current node (xf323rkhg80qy2pywkjkxqusp) is now a manager.

To add a worker to this swarm, run the following command:

    docker swarm join \
    --token SWMTKN-1-089phhmfamjor1o1qj8s0l4wdhyvegphg6vtt9p3s8c35upltk-eecvhhtz1f2vpjhvc70v6v
vzb \
    10.0.50.3:2377

To add a manager to this swarm, run 'docker swarm join-token manager' and follow the instructi
ons.
```

以上令牌ID对于每个群集模式群集都是唯一的，因此可能会因您的设置而有所不同。从上面的输出中，复制连接命令（注意换行符）。

> 插曲, 如果你防火墙没有开放相关端口, 请先关闭.
```
systemctl stop firewalld.service
systemctl disable firewalld.service
```

>当然, 最好的方法是[配置防火墙规则](https://stackoverflow.com/questions/43370865/fail-join-node-to-docker-swarm)

```
firewall-cmd --add-port=2376/tcp --permanent
firewall-cmd --add-port=2377/tcp --permanent
firewall-cmd --add-port=7946/tcp --permanent
firewall-cmd --add-port=7946/udp --permanent
firewall-cmd --add-port=4789/udp --permanen
```


接下来，打开新的实例并粘贴下面的命令。这应该将新节点加入到群集模式群集中，并且这个新节点成为工作节点。就我而言，这个命令看起来像这样：


```
docker swarm join \
    --token SWMTKN-1-089phhmfamjor1o1qj8s0l4wdhyvegphg6vtt9p3s8c35upltk-eecvhhtz1f2vpjhvc70v6v
vzb \
    10.0.50.3:2377
```

输出：

```
$ docker swarm join --token SWMTKN-1-089phhmfamjor1o1qj8s0l4wdhyvegphg6vtt9p3s8c35upltk-eecvhh
tz1f2vpjhvc70v6vvzb 10.0.50.3:2377
This node joined a swarm as a worker.
```

###  显示swarm的成员
在第一个终端中输入以下命令：

```
docker node ls
```

输出显示了指示双节点集群的管理者和工作者节点：

```
ID                           HOSTNAME  STATUS  AVAILABILITY  MANAGER STATUS
xf323rkhg80qy2pywkjkxqusp *  node1     Ready   Active        Leader
za75md1p0hpc2qswefj8uyktk    node2     Ready   Active
```

如果您尝试在非领导节点中执行管理命令worker，则会出现错误。试试这里：

```
docker node ls
```

### 创建一个overlay 网络

```
docker network create -d overlay net1
```

以上命令生成一个ID：

> 4md6wyy0pdpdzku6dj2z7yxjf

使用以下命令列出新创建的覆盖网络：

```
docker network ls
```

输出结果应显示新增网络，名为“net1”，其中包含swarm作用域。

```
NETWORK ID          NAME                DRIVER              SCOPE
c30f13d9c242        bridge              bridge              local
990fa0ad6ab6        docker_gwbridge     bridge              local
c60123ff7abf        host                host                local
v7sp7ev6xfoo        ingress             overlay             swarm
4md6wyy0pdpd        net1                overlay             swarm
333c7d045239        none                null
```

###  创建MYSQL服务

```
docker service create \
           --replicas 1 \
           --name wordpressdb \
           --network net1 \
           --env MYSQL_ROOT_PASSWORD=mysql123 \
           --env MYSQL_DATABASE=wordpress \
          mysql:latest
```		  
		  
上述命令将创建一个名为“wordpressdb”的服务，该服务属于运行容器的单个副本的“net1”网络。它显示服务ID作为输出如下所示：

> ip9a8zl9rke256q92itgrm8ov

运行以下命令列出该服务：

```
docker service ls 
```

输出应该像下面这样（你的ID会显示不同的）。

```
ID                  NAME                MODE                REPLICAS            IMAGE
ip9a8zl9rke2        wordpressdb         replicated          1/1                 mysql:latest
```

让我们列出wordpressdb服务的任务。

```
docker service ps wordpressdb
```

您应该得到如下所示的服务列表中的1个任务的输出。

```
ID                  NAME                IMAGE               NODE                DESIRED STATE
      CURRENT STATE                ERROR               PORTS
puoe9lvfkcia        wordpressdb.1       mysql:latest        node1               Running
      Running about a minute ago
```

### 创建WordPress服务

```
docker service create \
           --replicas 4 \
           --name wordpressapp \
           --network net1 \
           --env WORDPRESS_DB_HOST=wordpressdb \
           --env WORDPRESS_DB_PASSWORD=mysql123 \
          wordpress:latest
```
上述命令创建一个名为“wordpressapp”的服务，该服务属于运行4个wordpressapp容器的“net1”网络。作为输出，该命令显示一个服务ID为：

> m4hca6rliz8wer2aojayv01r5

列出这些服务：

```
docker service ls
```

输出：

```
ID                  NAME                MODE                REPLICAS            IMAGE
ID                  NAME                MODE                REPLICAS            IMAGE
ip9a8zl9rke2        wordpressdb         replicated          1/1                 mysql:latest
m4hca6rliz8w        wordpressapp        replicated          4/4                 wordpress:late
st
```

您可以使用以下命令列出wordpressapp服务的任务：

```
docker service ps wordpressapp
```

输出：

```
ID                  NAME                IMAGE               NODE                DESIRED STATE
      CURRENT STATE                ERROR               PORTS
zg7wpvs1rbki        wordpressapp.1      wordpress:latest    node2               Running
      Running 58 seconds ago
8rybe5m4urik        wordpressapp.2      wordpress:latest    node1               Running
      Running about a minute ago
scia4v5i1znj        wordpressapp.3      wordpress:latest    node2               Running
      Running 58 seconds ago
4avyixggcb8n        wordpressapp.4      wordpress:latest    node1               Running
      Running about a minute ago
```

###  服务发现
让我们尝试从一个wordpressapp容器中发现wordpressdb服务。打开管理器节点实例并运行以下命令：

打开工作节点的实例并验证哪些容器正在运行：
```
docker ps
```
这应该在本地显示在工作节点上运行的任务数量（容器）：

```
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS
           PORTS               NAMES
52f16028e12c        wordpress:latest    "docker-entrypoint..."   2 minutes ago       Up 2 minu
tes        80/tcp              wordpressapp.1.zg7wpvs1rbkiy4zwo71yk031i
f3271e89d54e        wordpress:latest    "docker-entrypoint..."   2 minutes ago       Up 2 minu
tes        80/tcp              wordpressapp.3.scia4v5i1znj378gujluad2ku
```

如上所示，在worker节点上运行了两个wordpressapp任务（容器）实例。

现在，打开管理器节点并确认正在运行的任务：

```
docker ps
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS
           PORTS               NAMES
b68d99cad3da        wordpress:latest    "docker-entrypoint..."   5 minutes ago       Up 4 minu
tes        80/tcp              wordpressapp.2.8rybe5m4urikqsqje6hcpou9t
657cff3e37d5        wordpress:latest    "docker-entrypoint..."   5 minutes ago       Up 4 minu
tes        80/tcp              wordpressapp.4.4avyixggcb8neej1h395ognt2
e71c164c36b3        mysql:latest        "docker-entrypoint..."   10 minutes ago      Up 10 min
utes       3306/tcp            wordpressdb.1.puoe9lvfkciavkrzrkbrhrl6e
```
正如我们注意到的，在manager节点（如上所示）上运行的wordpressapp任务（容器）有2个实例，wordpressdb有1个实例。

让我们选择在manager节点上运行的一个wordpressdb任务，并尝试联系在远程工作节点上运行的wordpressapp，如下所示：

```
docker exec -it e71 ping wordpressapp
```

这应该工作成功，并能够ping的wordpressapp作为服务名称。

```
PING wordpressapp (10.0.0.4): 56 data bytes
64 bytes from 10.0.0.4: icmp_seq=0 ttl=64 time=0.052 ms
^C--- wordpressapp ping statistics ---
1 packets transmitted, 1 packets received, 0% packet loss
round-trip min/avg/max/stddev = 0.052/0.052/0.052/0.000 ms
```
让我们尝试通过其主机名从工作节点上运行的一个wordpressdb实例伸出远程wordpressapp容器：

```
docker exec -it e71 ping wordpressapp.3.scia4v5i1znj378gujluad2ku
```
输出：
```
PING wordpressapp.3.scia4v5i1znj378gujluad2ku (10.0.0.5): 56 data bytes
64 bytes from 10.0.0.5: icmp_seq=0 ttl=64 time=6.175 ms
64 bytes from 10.0.0.5: icmp_seq=1 ttl=64 time=0.131 ms
^C--- wordpressapp.3.scia4v5i1znj378gujluad2ku ping statistics ---
2 packets transmitted, 2 packets received, 0% packet loss
round-trip min/avg/max/stddev = 0.131/3.153/6.175/3.022 ms
```

瞧！我们可以使用服务名称从容器（运行wordpresdb任务）ping wordpressapp服务。同时，我们成功地使用从maanager节点中运行的wordpressdb容器之一的主机名向远程wordpressapp容器伸出。

Docker群集模式下有哪些功能可用：

- [ ]服务发现
- [ ]路由网格
- [ ]负载均衡
- [ ]编排
- [x]以上全部