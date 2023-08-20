package com.workit.chat.websocket;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.socket.config.annotation.EnableWebSocket;
import org.springframework.web.socket.config.annotation.WebSocketConfigurer;
import org.springframework.web.socket.config.annotation.WebSocketHandlerRegistry;

@Configuration
@EnableWebSocket
public class ChatConfiguration implements WebMvcConfigurer, WebSocketConfigurer {
	
	private MyWebSocketHandler myWebSocketHandler;
	private MyHttpSessionHandshakeInterceptor interceptor;
	
	public ChatConfiguration(MyWebSocketHandler myWebSocketHandler,  MyHttpSessionHandshakeInterceptor interceptor) {
		this.myWebSocketHandler = myWebSocketHandler;
		this.interceptor = interceptor;
	}

	@Override
	public void registerWebSocketHandlers(WebSocketHandlerRegistry registry) {
		registry.addHandler(myWebSocketHandler, "/chating/*").addInterceptors(interceptor);
	}
	
	
	
}
