
Reference
==

https://docs.docker.com/engine/reference/commandline/stats/#formatting


Example
==

```
docker ps --format ' {"id":"{{.ID}}", "names": "{{.Names}}"}'


docker  stats --no-stream  --format  '{"容器名称": "{{.Name}}", 
"容器ID": "{{.ID}}", 
"CPU%": "{{.CPUPerc}}", 
"内存使用": "{{.MemUsage}}", 
"内存使用%": "{{.MemPerc}}", 
"网络IO": "{{.NetIO}}", 
"磁盘读写IO": "{{.BlockIO}}", 
"进程ID数": "{{.PIDs}}"},' 
```

docker ps -a --filter "name=" --format "{\"id\": \"{{.ID}}\", \"image\": \"{{.Image}}\", \"command\": \"{{.Command}}\", \"createdat\": \"{{.CreatedAt}}\", \"runningfor\": \"{{.RunningFor}}\", \"ports\": \"{{.Ports}}\", \"status\": \"{{.Status}}\", \"size\": \"{{.Size}}\", \"names\": \"{{.Names}}\", \"labels\": \"{{.Labels}}\", \"mounts\": \"{{.Mounts}}\", \"networks\": \"{{.Networks}}\"},"


docker ps -a --filter "name= mysqls" --format "{{.ID}}, {{.Image}}, {{.Command}}, {{.CreatedAt}}, {{.RunningFor}}, {{.Ports}}, {{.Status}}, {{.Size}}, {{.Names}}, {{.Labels}},  {{.Mounts}}, {{.Networks}}" 


docker ps -a --format "{{.Label "com.docker.swarm.cpu"}}"


private String id;
private String image;
private String command;
private String createdat;
private String runningfor;
private String ports;
private String status;
private String size;
private String names;
private String labels;
private String mounts;
private String networks;


docker stats --no-stream --format "{'container': '{{.Container}}', 'name': '{{.Name}}', 'id': '{{.ID}}', 'cpuperc': '{{.CPUPerc}}', 'memusage': '{{.MemUsage}}', 'netio': '{{.NetIO}}', 'blockio': '{{.BlockIO}}', 'memperc': '{{.MemPerc}}', 'pids': '{{.PIDs}}' },"  

private String container;
private String name;
private String id;
private String cpuperc;
private String memusage;
private String netio;
private String blockio;
private String memperc;
private String pids;