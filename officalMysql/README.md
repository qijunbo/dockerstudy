
Script List
--
<table>
<tr><th>Name</th><th>Description</th></tr>
<tr><td>startmysql.sh</td><td>&nbsp;启动一个官方的mysql容器, 并且初始化脚本.</td></tr>
<tr><td>startwithconf.sh</td><td>&nbsp;启动一个官方的mysql容器, 初始化脚本, 并且使用自定义配置文件.</td></tr>
<tr><td>startwithout-P.sh</td><td>&nbsp;启动一个官方的mysql容器, 初始化脚本, 不使用端口映射, 无法从外部分访问.</td></tr>
<tr><td>verify.sh</td><td>&nbsp;验证创建的容器是否执行了初始脚本, 用户my.cnf文件是否生效, 是否可以从外部联网.<br/> ** 唉, 尼玛, 我是不是太有才了  :-D **</td></tr>
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

# How to use offical MYSQL  docker image

### What is this repository for? ###

* Quick summary
* Version
* [Learn Markdown](https://bitbucket.org/tutorials/markdowndemo)

### How do I get set up? ###

* Summary of set up
* Configuration
* Dependencies
* Database configuration
### How to run tests

* Get in the Container
```
docker exec -it qijunbo mysql -uroot -psunway123#
or
docker exec -it qijunbo bash
```

* Check if the init.sql is executed to create the DB.

```
mysql -uroot -psunway123#
show databases;
```

* Check if you can connect from outside

```
SELECT host FROM mysql.user WHERE User = 'root';

```

If you only see results with localhost and 127.0.0.1, you cannot connect from an external source. If you see other IP addresses, but not the one you're connecting from - that's also an indication.

You will need to add the IP address of each system that you want to grant access to, and then grant privileges:

```
CREATE USER 'root'@'ip_address' IDENTIFIED BY 'some_pass';
GRANT ALL PRIVILEGES ON *.* TO 'root'@'ip_address';
```

If you see %, well then, there's another problem altogether as that is "any remote source". If however you do want any/all systems to connect via root, use the % wildcard to grant access:
```
CREATE USER 'root'@'%' IDENTIFIED BY 'some_pass';
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%';  
```

Finally, reload the permissions, and you should be able to have remote access:
```
FLUSH PRIVILEGES;
```
if you want to lean more, refer this link [host-is-not-allowed-to-connect-to-this-mysql-server](https://stackoverflow.com/questions/19101243/error-1130-hy000-host-is-not-allowed-to-connect-to-this-mysql-server) for more information.


* Check table name insensitive

```
mysqladmin -u root -psunway123# variables  | grep  "case"
```

and you must get this .

```
| lower_case_file_system                                   | OFF                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| lower_case_table_names                                   | 1     
```

* Network tools

you need to try ** ip **,  ** ping ** , or else,  it would be tough to debug.
```
docker exec -it qijunbo ping 172.17.0.1 
```

* Deployment instructions

### Contribution guidelines ###

* Writing tests
* Code review
* Other guidelines

### Who do I talk to? ###

* Repo owner or admin
* Other community or team contact

