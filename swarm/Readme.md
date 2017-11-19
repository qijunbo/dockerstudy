Swarm
==

Example:

[A swarm exampell of wordpress](trail.md)


Firewall considerations
--
Docker 要用如下的两个端口用于网络发现.
Docker daemons participating in a swarm need the ability to communicate with each other over the following ports:

Port 7946 TCP/UDP for container network discovery.
Port 4789 UDP for the container overlay network.

Work with swarm
--

```
docker network create  --driver overlay  my-network
docker network ls

root@ubuntu:~# docker network ls
NETWORK ID          NAME                DRIVER              SCOPE
fd71bf719c8f        bridge              bridge              local
2e4ab83334f1        docker_gwbridge     bridge              local
7f2b5e31204e        host                host                local
0onh18q6nn1m        ingress             overlay             swarm
hm929td4xt3w        my-network          overlay             swarm
fefb7df86071        none                null                local

root@ubuntu:~# docker network inspect my-network
[
    {
        "Name": "my-network",
        "Id": "hm929td4xt3w7xt6dpxreusj4",
        "Created": "0001-01-01T00:00:00Z",
        "Scope": "swarm",
        "Driver": "overlay",
        "EnableIPv6": false,
        "IPAM": {
            "Driver": "default",
            "Options": null,
            "Config": []
        },
        "Internal": false,
        "Attachable": false,
        "Ingress": false,
        "ConfigFrom": {
            "Network": ""
        },
        "ConfigOnly": false,
        "Containers": null,
        "Options": {
            "com.docker.network.driver.overlay.vxlanid_list": "4097"
        },
        "Labels": null
    }
]


```
In the above output, notice that the driver is overlay and that the scope is swarm, rather than local, host, or global scopes you might see in other types of Docker networks. This scope indicates that only hosts which are participating in the swarm can access this network.

在这种网络模式下面, 只有加入my_network的主机才能访问网络.

Customize an overlay network
--

- CONFIGURE THE SUBNET AND GATEWAY
用 --subnet 和 --gateway 这两个flag来定制子网的网段和gateway
You can configure these when creating a network using the --subnet and --gateway flags

```
docker network rm my-network
docker network create  --driver overlay  --subnet 10.0.9.0/24  --gateway 10.0.9.99  my-network

root@ubuntu:~# docker inspect my-network
[
    {
        "Name": "my-network",
        "Id": "ih5d79prj0cx6udvm9hbl7thb",
        "Created": "0001-01-01T00:00:00Z",
        "Scope": "swarm",
        "Driver": "overlay",
        "EnableIPv6": false,
        "IPAM": {
            "Driver": "default",
            "Options": null,
            "Config": [
                {
                    "Subnet": "10.0.9.0/24",
                    "Gateway": "10.0.9.99"
                }
            ]
        },
        "Internal": false,
        "Attachable": false,
        "Ingress": false,
        "ConfigFrom": {
            "Network": ""
        },
        "ConfigOnly": false,
        "Containers": null,
        "Options": {
            "com.docker.network.driver.overlay.vxlanid_list": "4097"
        },
        "Labels": null
    }
]

```

 - Overlay network size limitations  
 
 这种网络能够容纳256个机器,  掩码长度 /24
 
- CONFIGURE ENCRYPTION OF APPLICATION DATA

下面这个flag 可以给网络数据加密

```
--opt encrypted

```

Attach a service to an overlay network
--

To attach a service to an existing overlay network, pass the --network flag to docker service create, or the --network-add flag to docker service update.

```
docker service create  --replicas 3  --name my-web   --network my-network   nginx

root@ubuntu:~# docker service create  --replicas 3  --name my-web   --network my-network   nginx
tnxjh2xekarn9egki1x7msn54
Since --detach=false was not specified, tasks will be created in the background.
In a future release, --detach=false will become the default.

docker service create  --replicas 3  --name my-web   --network my-network  --detach=false  nginx

root@ubuntu:~# docker service ls
ID                  NAME                MODE                REPLICAS            IMAGE               PORTS
tnxjh2xekarn        my-web              replicated          3/3                 nginx:latest

root@ubuntu:~# docker service ps my-web
ID                  NAME                IMAGE               NODE                DESIRED STATE       CURRENT STATE           ERROR               PORTS
jb96d7q3swwu        my-web.1            nginx:latest        ubuntu              Running             Running 5 minutes ago
rkgi30odovpx        my-web.2            nginx:latest        ubuntu              Running             Running 5 minutes ago
pg115wvgo2py        my-web.3            nginx:latest        ubuntu              Running             Running 5 minutes ago



root@ubuntu:~# docker inspect my-network
[
    {
        "Name": "my-network",
        "Id": "ih5d79prj0cx6udvm9hbl7thb",
        "Created": "2017-11-18T02:42:18.39053159-08:00",
        "Scope": "swarm",
        "Driver": "overlay",
        "EnableIPv6": false,
        "IPAM": {
            "Driver": "default",
            "Options": null,
            "Config": [
                {
                    "Subnet": "10.0.9.0/24",
                    "Gateway": "10.0.9.99"
                }
            ]
        },
        "Internal": false,
        "Attachable": false,
        "Ingress": false,
        "ConfigFrom": {
            "Network": ""
        },
        "ConfigOnly": false,
        "Containers": {
            "1a7ed2abb69fb81f2c65f6016e7f8476762c392a65a2fd263efa8764147d7c76": {
                "Name": "my-web.3.pg115wvgo2py14ky6ecr6ufpm",
                "EndpointID": "55bbfb7c06ae7fb2c5c254bd0101f4901d2de7d2f81cce52fa8def09a19366af",
                "MacAddress": "02:42:0a:00:09:04",
                "IPv4Address": "10.0.9.4/24",
                "IPv6Address": ""
            },
            "2e6c67518b56a73bab059a7cf95b4732fabd8148584c5f24d52c9cb57d726104": {
                "Name": "my-web.2.rkgi30odovpx7wgzh27vlaxdr",
                "EndpointID": "047abb1e15adee487c802a615d9a55ac3b45dd36f7e0ff3dbbfb8715f8cba02a",
                "MacAddress": "02:42:0a:00:09:03",
                "IPv4Address": "10.0.9.3/24",
                "IPv6Address": ""
            },
            "db12bf78c5df81185cedebfc4f1eef6b45ae0bbd940d6b0dcee9c0697e298327": {
                "Name": "my-web.1.jb96d7q3swwuytounvp6es18o",
                "EndpointID": "c2900b3a44a54fc3654321e2fcdd0cb22cc6a6f549291ab1e32785252d3c21c6",
                "MacAddress": "02:42:0a:00:09:02",
                "IPv4Address": "10.0.9.2/24",
                "IPv6Address": ""
            }
        },
        "Options": {
            "com.docker.network.driver.overlay.vxlanid_list": "4097"
        },
        "Labels": {},
        "Peers": [
            {
                "Name": "ubuntu-f7c53d3466d9",
                "IP": "192.168.64.131"
            }
        ]
    }
]


```


Creating MYSQL service
--

```
docker service create \
           --replicas 1 \
           --name wordpressdb \
           --network my-network \
           --env MYSQL_ROOT_PASSWORD=mysql123 \
           --env MYSQL_DATABASE=wordpress \
          mysql:latest
		  
```

Reference:
==

https://docs.docker.com/engine/swarm/networking/#attach-a-service-to-an-overlay-network