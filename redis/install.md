Installation 
== 

- For Windows
```
wget http://download.redis.io/releases/redis-4.0.2.tar.gz
tar xzf redis-4.0.2.tar.gz
cd redis-4.0.2
make install MALLOC=libc
```


Config for Remote Access 
==
```
vim redis.conf
#comment out this line to listen on any network interfaces
```
from 

```
bind 127.0.0.1

```
to

``` 
#bind 127.0.0.1
```

uncomment this line to add password
from



```
#requirepass foobared
```
to
```
requirepass  mypassword
```

if you don't want password, and  open redis to internet access, change this line from yes to no, but it's very dangerous.

```
protected-model no
```

Start The Server  
==
don't forget to add the configure file "redis.conf" as a parameter . 
```
redis-server  /path/to/redis.conf &
```
You can see something like this.

```
cd ./src

[root@localhost src]# redis-server redis.conf  &
[1] 4453
[root@localhost src]# 4453:C 16 Oct 19:16:59.823 # oO0OoO0OoO0Oo Redis is starting oO0OoO0OoO0Oo
4453:C 16 Oct 19:16:59.823 # Redis version=4.0.2, bits=64, commit=00000000, modified=0, pid=4453, just started
4453:C 16 Oct 19:16:59.823 # Warning: no config file specified, using the default config. In order to specify a config file use ./redis-server /path/to/redis.conf
4453:M 16 Oct 19:16:59.824 * Increased maximum number of open files to 10032 (it was originally set to 1024).
                _._
           _.-``__ ''-._
      _.-``    `.  `_.  ''-._           Redis 4.0.2 (00000000/0) 64 bit
  .-`` .-```.  ```\/    _.,_ ''-._
 (    '      ,       .-`  | `,    )     Running in standalone mode
 |`-._`-...-` __...-.``-._|'` _.-'|     Port: 6379
 |    `-._   `._    /     _.-'    |     PID: 4453
  `-._    `-._  `-./  _.-'    _.-'
 |`-._`-._    `-.__.-'    _.-'_.-'|
 |    `-._`-._        _.-'_.-'    |           http://redis.io
  `-._    `-._`-.__.-'_.-'    _.-'
 |`-._`-._    `-.__.-'    _.-'_.-'|
 |    `-._`-._        _.-'_.-'    |
  `-._    `-._`-.__.-'_.-'    _.-'
      `-._    `-.__.-'    _.-'
          `-._        _.-'
              `-.__.-'

4453:M 16 Oct 19:16:59.825 # WARNING: The TCP backlog setting of 511 cannot be enforced because /proc/sys/net/core/somaxconn is set to the lower value of 128.
4453:M 16 Oct 19:16:59.825 # Server initialized
4453:M 16 Oct 19:16:59.825 # WARNING overcommit_memory is set to 0! Background save may fail under low memory condition. To fix this issue add 'vm.overcommit_memory = 1' to /etc/sysctl.conf and then reboot or run the command 'sysctl vm.overcommit_memory=1' for this to take effect.
4453:M 16 Oct 19:16:59.825 # WARNING you have Transparent Huge Pages (THP) support enabled in your kernel. This will create latency and memory usage issues with Redis. To fix this issue run the command 'echo never > /sys/kernel/mm/transparent_hugepage/enabled' as root, and add it to your /etc/rc.local in order to retain the setting after a reboot. Redis must be restarted after THP is disabled.
4453:M 16 Oct 19:16:59.825 * Ready to accept connections

```


Check firewall if you cannot connect from remote client.
```
service iptables stop
```

Verify
==
run ``` redis-cli ``` client.

```
./src/redis-cli

[root@localhost src]# ./redis-cli
127.0.0.1:6379> ping "hello"
"hello"
127.0.0.1:6379>

```

redis 备份与恢复
--

1.启动redis

进入redis目录

redis-cli

2.数据备份

redis 127.0.0.1:6379> SAVE 
该命令将在 redis 备份目录中创建dump.rdb文件。

3.恢复数据

1、获取备份目录

redis 127.0.0.1:6379> CONFIG GET dir
1) "dir"
2) "/usr/local/redis/bin"　　　

以上命令 CONFIG GET dir 输出的 redis 备份目录为 /usr/local/redis/bin。

2、停止redis服务

3、拷贝备份文件到 /usr/local/redis/bin目录下

4、重新启动redis服务

Reference: [备份与恢复](https://www.cnblogs.com/qinghub/p/5909921.html)


怎样让把RedIS配置成服务，Linux开机时自启动？
==

redis作为windows服务启动方式
redis-server --service-install redis.windows.conf
启动服务：redis-server --service-start
停止服务：redis-server --service-stop	