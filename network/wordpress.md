Network Demo -- WordExpress
==

- 执行下面的语句轻松搭好WordExpress环境

```
docker network create -d bridge cms_network
docker network ls

docker run -d \
		   --name wordpressdb \
           --net=cms_network \
           --env MYSQL_ROOT_PASSWORD=mysql123 \
           --env MYSQL_DATABASE=wordpress \
		   mysql


docker run -d \
           --name wordpressapp \
           --net=cms_network \
           --env WORDPRESS_DB_HOST=wordpressdb \
           --env WORDPRESS_DB_PASSWORD=mysql123 \
		   -P \
          wordpress:latest
		  
docker ps -a

```

- 执行 geturl.show 轻松获取访问的入口url.

Two ways of get app url.

Way 1
```
ip=`/sbin/ip addr show ens33|grep "inet "|grep -v 127.0.0.1|awk '{print $2}'`
#ip=`/sbin/ip addr show eth0|grep "inet "|grep -v 127.0.0.1|awk '{print $2}'`
port=`docker port wordpressapp`
echo "http://${ip%/*}:${port#*:}"
echo "http://${ip%/*}:${port#*:}/wp-admin"
```
Way 2:

```
ip=`/sbin/ip addr show ens33|grep "inet "|grep -v 127.0.0.1|awk '{print $2}'`
#ip=`/sbin/ip addr show eth0|grep "inet "|grep -v 127.0.0.1|awk '{print $2}'`
port=`docker inspect --format='{{(index (index .NetworkSettings.Ports "80/tcp") 0).HostPort}}' wordpressapp`
echo "http://${ip%/*}:${port}"
echo "http://${ip%/*}:${port}/wp-admin"
	  
```
知识拓展
--

也许你需要看看[怎样让容器自动重启](../restart/readme.md)

Reference: 
== 


http://blog.csdn.net/edwzhang/article/details/53332900