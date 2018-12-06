version=$1
if [ -z "${version}" ]; then
   echo "[error:] version is not specified."
   echo "[usage:] $0 <version>"    	
   exit 1
fi

docker login --username=junboqi@foxmail.com registry.cn-hangzhou.aliyuncs.com
docker tag qijunbo/jdk:${version} registry.cn-hangzhou.aliyuncs.com/qijunbo/jdk:${version}
nohup docker push registry.cn-hangzhou.aliyuncs.com/qijunbo/jdk:${version} &

