Registry
==

Start the registry
--

```
docker run -d -p 5000:5000 --restart=always --name registry registry:2
```


Copy an image from Docker Hub to your registry
--

```
docker pull ubuntu:16.04
docker tag ubuntu:16.04 localhost:5000/my-ubuntu
docker push localhost:5000/my-ubuntu

```

Remove the locally-cached ubuntu:16.04 and localhost:5000/my-ubuntu images, so that you can test pulling the image from your registry. This does not remove the localhost:5000/my-ubuntu image from your registry.

```
$ docker image remove ubuntu:16.04
$ docker image remove localhost:5000/my-ubuntu

```

Pull the localhost:5000/my-ubuntu image from your local registry.

```
docker pull localhost:5000/my-ubuntu
```

Storage customization
--

```
docker run -d \
  -p 5000:5000 \
  --restart=always \
  --name registry \
  -v /mnt/registry:/var/lib/registry \
  registry:2

```

Restricting access
--

- Create a password file with one entry for the user ``` qijunbo``` , with password ``` tonytony ```:

```
mkdir auth
docker run \
  --entrypoint htpasswd \
  registry:2 -Bbn qijunbo tonytony > auth/htpasswd

```

- Start the registry with basic authentication.

```
docker stop registry
docker run -d \
  -p 5000:5000 \
  --restart=always \
  --name registry \
  -v `pwd`/auth:/auth \
  -e "REGISTRY_AUTH=htpasswd" \
  -e "REGISTRY_AUTH_HTPASSWD_REALM=Registry Realm" \
  -e REGISTRY_AUTH_HTPASSWD_PATH=/auth/htpasswd \
  registry:2

  ```

- Try to pull an image from the registry, or push an image to the registry. These commands will fail.

```
root@ubuntu:~/docker/registry# docker images
REPOSITORY                 TAG                 IMAGE ID            CREATED             SIZE
mylims                     latest              5f4a05b7f9c0        40 hours ago        323MB
sunway/lims                1                   5f4a05b7f9c0        40 hours ago        323MB
localhost:5000/lims        1                   5f4a05b7f9c0        40 hours ago        323MB
localhost:5000/my-ubuntu   latest              dd6f76d9cc90        7 days ago          122MB

root@ubuntu:~/docker/registry# docker pull localhost:5000/lims:1
Error response from daemon: Get http://localhost:5000/v2/lims/manifests/1: no basic auth credentials
root@ubuntu:~/docker/registry#

```

- Log in to the registry.

```
root@ubuntu:~/docker/registry# docker login localhost:5000
Username: qijunbo
Password:
Login Succeeded

root@ubuntu:~/docker/registry# docker push localhost:5000/lims
The push refers to a repository [localhost:5000/lims]
135c43ef9ecb: Pushed
ecaedbd194da: Pushed
64655e5fda01: Pushed
3f73eb4d861f: Pushed
7c522249bcb2: Pushed
ba1b854af66a: Pushed
3f7a86f1643e: Pushed
f55bf32d0637: Pushed
8394eb34d9c2: Pushed
3c24c63114ae: Pushed
2dd32f40dedd: Pushed
6327a1518771: Pushed
995042ba10ad: Pushed
fe40be59465f: Pushed
cf4ecb492384: Pushed
1: digest: sha256:bceb7de324c877359d902333d6cb548cc991df7fd7ff952e1139d87030595371 size: 3464

```


- With CRT and  you won domain name:

```
$ docker run -d \
  -p 5000:5000 \
  --restart=always \
  --name registry \
  -v `pwd`/auth:/auth \
  -e "REGISTRY_AUTH=htpasswd" \
  -e "REGISTRY_AUTH_HTPASSWD_REALM=Registry Realm" \
  -e REGISTRY_AUTH_HTPASSWD_PATH=/auth/htpasswd \
  -v `pwd`/certs:/certs \
  -e REGISTRY_HTTP_TLS_CERTIFICATE=/certs/domain.crt \
  -e REGISTRY_HTTP_TLS_KEY=/certs/domain.key \
  registry:2

```


Deploy your registry using a Compose file
--

- create file docker-compose.yml

```

registry:
  restart: always
  image: registry:2
  ports:
    - 5000:5000
  environment:
    REGISTRY_HTTP_TLS_CERTIFICATE: /certs/domain.crt
    REGISTRY_HTTP_TLS_KEY: /certs/domain.key
    REGISTRY_AUTH: htpasswd
    REGISTRY_AUTH_HTPASSWD_PATH: /auth/htpasswd
    REGISTRY_AUTH_HTPASSWD_REALM: Registry Realm
  volumes:
    - /path/data:/var/lib/registry
    - /path/certs:/certs
    - /path/auth:/auth

```
- tart your registry by issuing the following command in the directory containing the docker-compose.yml file:

```
docker-compose up -d
```






Reference
==

https://docs.docker.com/registry/deploying/#customize-the-storage-back-end

https://docs.docker.com/samples/library/registry/#run-a-local-registry-quick-version

create CRT 
http://blog.csdn.net/tiandyoin/article/details/37880457

http://www.linuxidc.com/Linux/2015-10/124332.htm

https://www.cnblogs.com/cloud-it/p/7070198.html

http://blog.csdn.net/mideagroup/article/details/52052618