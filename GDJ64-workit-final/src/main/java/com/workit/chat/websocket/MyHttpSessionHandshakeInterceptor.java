package com.workit.chat.websocket;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.http.server.ServerHttpRequest;
import org.springframework.http.server.ServerHttpResponse;
import org.springframework.http.server.ServletServerHttpRequest;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.WebSocketHandler;
import org.springframework.web.socket.server.support.HttpSessionHandshakeInterceptor;

import com.workit.member.model.vo.MemberVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component
public class MyHttpSessionHandshakeInterceptor extends HttpSessionHandshakeInterceptor {

    @Override
    public boolean beforeHandshake(ServerHttpRequest request, ServerHttpResponse response, WebSocketHandler wsHandler, Map<String, Object> attributes) throws Exception {
        if (request instanceof ServletServerHttpRequest) {
            ServletServerHttpRequest servletRequest = (ServletServerHttpRequest) request;
            HttpSession session = servletRequest.getServletRequest().getSession();
            log.info("Httpsession : " + session );
            MemberVO loginMember = (MemberVO)session.getAttribute("loginMember");
            log.info("loginMember : " + loginMember.getMemberId());
            // HttpSession에서 원하는 정보를 가져와 attributes에 추가
            attributes.put("loginMember",loginMember.getMemberId());
        }
        return true;
    }
}
