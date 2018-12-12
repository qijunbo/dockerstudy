spring-boot with docker
==

### extra_hosts (--add-host)
Add hostname mappings. Use the same values as the docker client ``` --add-host ``` parameter.
```yml
extra_hosts:
 - "somehost:162.242.195.82"
 - "otherhost:50.31.209.229"
``` 
An entry with the ip address and hostname is created in ``` /etc/hosts ``` inside containers for this service, e.g:
```
162.242.195.82  somehost
50.31.209.229   otherhost
```

我们经常使用一些docker管理平台，如DaoCloud、rancher之类的，里面都可以配置环境变量，目的当然也就是供程序获取。使用环境变量的话，可以避免在application.yml里直接明文编写数据库密码、appkey之类的。

```
foo:
  bar: ${JAVA_HOME:default_value}
```

### environment

Add environment variables. You can use either an array or a dictionary. Any boolean values; true, false, yes no, need to be enclosed in quotes to ensure they are not converted to True or False by the YML parser.

Environment variables with only a key are resolved to their values on the machine Compose is running on, which can be helpful for secret or host-specific values.

```yml
environment:
  RACK_ENV: development
  SHOW: 'true'
  SESSION_SECRET:

environment:
  - RACK_ENV=development
  - SHOW=true
  - SESSION_SECRET
```