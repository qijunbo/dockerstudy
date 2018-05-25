Reference
==

https://stackoverflow.com/questions/30349811/register-to-eureka-from-docker-with-a-custom-ip#

https://meta.stackoverflow.com/questions/251597/question-with-no-answers-but-issue-solved-in-the-comments-or-extended-in-chat



当我们把微服务运行在Docker容器里面时,  默认情况下, 微服务会把自己所在容器的ip地址或则容器名注册到Eureka-Server里面,
实际上, eureka是没法通过容器名访问相应的微服务的, 也没法提供有效的路由.

