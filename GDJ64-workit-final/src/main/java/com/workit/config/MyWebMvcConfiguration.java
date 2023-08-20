package com.workit.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ViewControllerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.socket.config.annotation.EnableWebSocket;

import com.fasterxml.jackson.databind.ObjectMapper;

@Configuration
@EnableWebSocket
public class MyWebMvcConfiguration implements WebMvcConfigurer{

	//view설정
	@Override
	public void addViewControllers(ViewControllerRegistry registry) {
		registry.addViewController("/").setViewName("index");
	}
	
	@Bean
	public ObjectMapper objectMapper() {
		return new ObjectMapper();
	}
}
