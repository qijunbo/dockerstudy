Ghost wiki
==

- Run
```
docker run -d --name some-ghost -p 2368:2368 -v /path/to/ghost/blog:/var/lib/ghost/content ghost:1-alpine
```

- Use

http://localhost:2368/ghost



Reference:
--

docker镜像 使用指南  https://docs.docker.com/samples/library/ghost/#stateful

Dockerfile 工程:   https://github.com/docker-library/ghost

源代码:  https://github.com/TryGhost/Ghost

