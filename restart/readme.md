Auto restart
==


```
docker run -dit --restart unless-stopped redis

docker run -d  --restart=on-failure  -P mysql

docker run -d -p 5000:5000 --restart=always --name registry registry:2

```


<table>
<tr> <td> Flag</td><td>Description </td></tr>
<tr> <td> no</td><td>Do not automatically restart the container. (the default) </td></tr>
<tr> <td> on-failure</td><td>Restart the container if it exits due to an error, which manifests as a non-zero exit code. </td></tr>
<tr> <td> unless-stopped</td><td>Restart the container unless it is explicitly stopped or Docker itself is stopped or restarted. </td></tr>
<tr> <td> always</td><td>Always restart the container if it stops. </td></tr>
</table>

if you use ``` always ``` flag,  the container will always restart automatically when you try to stop it.  You must use  ``` update ``` command to change the  restart coonfiguration.

``` 
docker update --restart=no <CONTAINER ID>

docker update --restart=always <CONTAINER ID>

``` 


Reference
--

https://docs.docker.com/engine/admin/start-containers-automatically/

https://docs.docker.com/edge/engine/reference/commandline/update/#update-a-containers-kernel-memory-constraints

