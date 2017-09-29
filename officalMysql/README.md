
Script List
--
<table>
<tr><th>Name</th><th>Description</th></tr>
<tr><td>startmysql.sh</td><td>&nbsp;启动一个官方的mysql容器, 并且初始化脚本.</td></tr>
<tr><td>startwithconf.sh</td><td>&nbsp;启动一个官方的mysql容器, 初始化脚本, 并且使用自定义配置文件.</td></tr>
<tr><td>startwithout-P.sh</td><td>&nbsp;启动一个官方的mysql容器, 初始化脚本, 不使用端口映射, 无法从外部分访问.</td></tr>
</table>
Two ways of starting mysqld with your own conf file.
--

### Way 1 mount file ###

 from [https://github.com/mysql/mysql-docker](https://github.com/mysql/mysql-docker#using-a-custom-mysql-config-file)

- Using a Custom MySQL Config File

First, create your own configure file, saying -- docker.cnf -- , copy this content, to make mysql table names case insensitive.(the third line)

```
[mysqld]
skip-host-cache
skip-name-resolve
lower_case_table_names = 1

```
The mount the **file name** to  ** my.cnf** within the container, ** It'seems crazy, but it really work ** with [mysql-docker](https://github.com/qijunbo/mysql-docker) [mysql  Ver 14.14 Distrib 5.7.19] 

```
docker run --name goodname -v /my/custom/docker.cnf:/etc/my.cnf -e MYSQL_ROOT_PASSWORD=my-secret-pw -d mysql/mysql-server:tag
```
### Way 2 mout directory ###

From [https://github.com/docker-library/docs/tree/master/mysql](https://github.com/docker-library/docs/tree/master/mysql#using-a-custom-mysql-configuration-file)

You config file must end with ** .cnf ** 

If /my/custom/config-file.cnf is the path and name of your custom configuration file, you can start your mysql container like this ** note that only the directory path of the custom config file is used in this command ** :

```
docker run --name goodname -v /my/custom:/etc/mysql/conf.d -e MYSQL_ROOT_PASSWORD=my-secret-pw -d mysql:tag
```

