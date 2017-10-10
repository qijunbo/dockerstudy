
how to network your containers
--

- Create a network

```
docker network create -d bridge lims_network
docker network ls
```

- Add containers to a network

```
docker network connect lims_network web
 #or
docker run -d --net=lims_network --name db training/postgres

docker inspect --format='{{json .NetworkSettings.Networks}}'  db
```

- Disconnect containers from a network

```
docker network disconnect lims_network my_container
docker network inspect lims_network
```

- Test

Open a shell into the db application again and try the ping command. This time just use the container name ** web ** rather than the IP address.

```
docker exec -it db bash
ping  web

#or

docker exec -it db ping  web
```

How to use this demo.
--

- File List

<table>
	<tr><th>File Name</th><th> Desc </th></tr>
	<tr><td>application-prod.properties.tpl</td><td>模板文件, startmysql.sh脚本会把这个文件copy到目标位置,然后把生成的"数据源url"追加到文件末尾, 最终就形成了spring-boot的配置文件. 虽然yml比properties 文件有很多优势,  但是对格式敏感(缩进). properties对缩进不敏感, 用``` echo xx >> file ``` 追加到尾部即可. 比较省事. </td></tr>
	<tr><td>init.sql</td><td初始化数据库的脚本. mysql容器启动的时候会执行这个文件.</td></tr>
	<tr><td>startmysql.sh</td><td>创建工作目录, 并且启动数据库. 由于初始化数据库要一些时间, 所以没有把启动app的脚本合并到这个文件中. 执行这个脚本之后, 应该执行``` ./verfify.sh  db${name} ``` 来检查一下数据库是不是已经创建好了. </td></tr>
	<tr><td>application-dev.properties</td><td>spring-boot 的配置文件</td></tr>
	<tr><td>application.properties</td><td>spring-boot的配置文件</td></tr>
	<tr><td>docker.cnf</td><td>自定义的mysql配置文件.</td></tr>
	<tr><td>getdburl.sh</td><td>获取数据源的url</td></tr>
	<tr><td>startapp.sh</td><td>启动app容器, 一定要等数据库初始化完毕再启动, 否则启动失败.</td></tr>
	<tr><td>verify.sh</td><td>用来手工验证数据库是否初始化完毕.</td></tr>
</table>

- Create Webapp jar package

download the jar-properties branch of this project.

https://github.com/qijunbo/gs-accessing-data-jpa/tree/jar-properties

and execute 
```
gradlew  clean build 
```
and you will get the ``` customer.jar ``` file in the build folder.  copy thi file to this working folder. You will use this file later.

- Create Webapp Docker images

https://github.com/qijunbo/dockerstudy/tree/master/java8

execute the ``` rebuild.sh ``` script to create qijunbo/java:8  image,  you can run a spring-boot executable jar in this container.

-  Start the MySQL container

Run ``` ./startmysql.sh  yourName``` to start a mysql container.   After running this script,  you will get the following result:

  1. The working folder is created at: ``` /opt/myproject/yourName ```
  2. A mysql container named ``` db + yourName ``` is running. 
  3. The datasource file is generated, you can find it at: ``` /opt/myproject/yourName/application-prod.properties ```
   
** 注意 **

在 startmysql.sh 里面有一句 rm -rf  如果工作目录存在, 则删除它.  这么做是应为mysql容器默认只初始化数据库一次, 下次启动的时候, 就不初始化了.  开发环境下, 这句比较有用, 因为你需要看看每次修改的效果.  但是生产环境下, 这句是不必要的,  因为你执行第二遍的时候很可能把生产数据干掉了. 后悔莫及.


另外启动mysql容器的时候, 没有用-p/-P 参数, 说明只能在network内部访问,  外面是无法访问的.  在生产环境下安全性比较好.  开发的时候可以自己加上这个参数.  


- Start the Webapp container

Run ``` ./startapp.sh yourName ``` until the mysql db is initialized.  you can use ``` ./verify.sh  db${yourName} ``` to check the status of db manually.

After running this container,  you can get a url of the app,  copy the url and test it in browser.

