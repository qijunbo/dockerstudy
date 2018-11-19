
创建用户
==

### 创建用户和授权

```sql

set global read_only=0;
set global optimizer_switch='derived_merge=off'; 
create user 'jeesite'@'%' identified by 'becareful';
create database jeesite DEFAULT CHARSET utf8 COLLATE utf8_general_ci;  
grant all privileges on jeesite.* to 'jeesite'@'%' identified by 'becareful';
flush privileges;

```

### 命令行修改数据库密码：
 

1.打开mysql.exe和mysqld.exe所在的文件夹,复制路径地址

2.打开cmd命令提示符，进入上一步mysql.exe所在的文件夹。

3.输入命令  mysqld --skip-grant-tables  回车，此时就跳过了mysql的用户验证。注意输入此命令之后命令行就无法操作了，此时可以再打开一个新的命令行。注意：在输入此命令之前先在任务管理 器中结束mysqld.exe进程，确保mysql服务器端已结束运行。

4.然后直接输入mysql，不需要带任何登录参数直接回车就可以登陆上数据库。

5.输入show databases;   可以看到所有数据库说明成功登陆。

6.其中mysql库就是保存用户名的地方。输入 use mysql;   选择mysql数据库。

7.show tables查看所有表，会发现有个user表，这里存放的就是用户名，密码，权限等等账户信息。

8.输入select user,host,password from user;   来查看账户信息。

9.更改root密码，输入update user set password=password('becareful') where user='root' and host='%';
set password for 'jeesite'@'%' = PASSWORD('becareful');
 
10.再次查看账户信息，select user,host,password from user;   可以看到密码已被修改。

11.退出命令行，重启mysql数据库，用新密码尝试登录。

12.测试不带密码登录mysql,发现还是能够登陆上，但显示数据库时只能看到两个数据库了，说明重启之后跳过密码验证已经被取消了。