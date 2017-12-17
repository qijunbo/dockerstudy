docker rm nginx
#docker run --name nginx -d -p 8888:80 envtest
docker run --name nginx -e USERNAME=QIJUNBO -d -p 8888:80 envtest
