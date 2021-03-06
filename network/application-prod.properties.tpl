# server port
server.port=80
server.session.timeout=1800

#spring.datasource.url = jdbc:mysql://localhost:3306/test_spring_boot?useUnicode=true&characterEncoding=utf8  

spring.datasource.username=root
spring.datasource.password=sunway123#
spring.datasource.driver-class-name=com.mysql.jdbc.Driver

# Keep the connection alive if idle for a long time (needed in production)
spring.datasource.testWhileIdle = true
spring.datasource.validationQuery = SELECT 1

# Show or not log for each sql query
spring.jpa.show-sql = true

# schema will be automatically updated accordingly to java entities found in
# the project
spring.jpa.hibernate.ddl-auto = update

# Naming strategy
spring.jpa.hibernate.naming-strategy = org.hibernate.cfg.ImprovedNamingStrategy

# Allows Hibernate to generate SQL optimized for a particular DBMS
spring.jpa.properties.hibernate.dialect = org.hibernate.dialect.MySQL5Dialect


 
