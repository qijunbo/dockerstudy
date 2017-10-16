package com.examples.redis;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.redis.connection.RedisConnectionFactory;
import org.springframework.data.redis.connection.jedis.JedisConnectionFactory;

import redis.clients.jedis.JedisPoolConfig;

@Configuration
public class PropertiesConfiguration {

	@Value("${redis.server.ip}")
	private String redisIP;

	@Value("${redis.server.port}")
	private Integer redisPort;

	@Value("${redis.server.password}")
	private String redisPassword;

	@Bean
	protected JedisPoolConfig createPoolConfig() {
		return new JedisPoolConfig();
	}

	@Bean
	public RedisConnectionFactory jedisConnectionFactory(JedisPoolConfig poolConfig) {
		JedisConnectionFactory factory = new JedisConnectionFactory(poolConfig);
		factory.setHostName(redisIP);
		factory.setPort(redisPort);
		//factory.setPassword(redisPassword);
		factory.afterPropertiesSet();
		return factory;

	}

}
