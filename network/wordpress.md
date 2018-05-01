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

如果你想使用一个已有的数据库, 并且重用里面的数据,  再让过去上传的图片资源文件生效, 那么使用下面的:
```
docker run -d \
           --name wordpress \
		   -v /opt/cms/wp-content/uploads:/var/www/html/wp-content/uploads \
           --link mysql:mysql \
		   --env WORDPRESS_DB_NAME=old_db \
		   --env WORDPRESS_TABLE_PREFIX=sc_p_ \
           --env WORDPRESS_DB_HOST=mysql \
           --env WORDPRESS_DB_PASSWORD=sunway123# \
		   -p 8000:80 \
          wordpress:latest

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

官方镜像地址:  https://hub.docker.com/_/wordpress/

shell知识拓展:   http://blog.csdn.net/edwzhang/article/details/53332900

WordPress 镜像使用攻略:  https://docs.docker.com/samples/library/wordpress/