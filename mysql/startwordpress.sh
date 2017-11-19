docker run -d \
           --name wordpress \
           --link mysql:mysql \
           --env WORDPRESS_DB_HOST=mysql \
           --env WORDPRESS_DB_PASSWORD=sunway123# \
		   -P \
          wordpress:latest
