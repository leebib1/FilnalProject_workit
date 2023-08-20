package com.workit.chat.websocket;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;

import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.workit.chat.model.dto.ChatMsg;
import com.workit.chat.model.dto.MyChatroom;
import com.workit.chat.service.ChatService;
import com.workit.chatroom.service.ChatroomService;

import lombok.extern.slf4j.Slf4j;

@Component
@Slf4j
public class MyWebSocketHandler extends TextWebSocketHandler {

    private List<WebSocketSession> connectedSessions = new ArrayList<>();
    private Map<String, Object> sessionMemberMap = new HashMap<>(); // 세션과 멤버 정보 매핑
    
    private Map<String,WebSocketSession> clients = new HashMap<String, WebSocketSession>();
    
    
    private ChatService chatService;
	private ChatroomService chatroomService;
	private ObjectMapper mapper;
	
	public MyWebSocketHandler(ChatService chatService, ChatroomService chatroomService, ObjectMapper mapper) {
		this.chatService = chatService;
		this.chatroomService = chatroomService;
		this.mapper = mapper;
	}

	private String chatroomId;
    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
        
        String url = session.getUri().toString();
		chatroomId = url.split("/chating/")[1];
		log.info("chatroomId : " + chatroomId);
		
        String loginMember = (String) session.getAttributes().get("loginMember");
        log.info("WebSocket session opened for memberId: " + loginMember);
		
		connectedSessions.add(session); // 접속한 세션을 리스트에 추가
		clients.put(loginMember, session);
		
    }
    
    
    
    protected List<MyChatroom> getChatMember(String chatroomId) {
    	List<MyChatroom> list =  chatService.selectChatMember(chatroomId);
    	log.info("채팅 참여 멤버 : " + list);
    	return list;
	}
    

    @Override
    protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
        String chatId="";
        ChatMsg chat =mapper.readValue(message.getPayload(),ChatMsg.class);
		if(chat!=null && !chat.getChatroomId().equals("file")) {
			int insertResult = chatroomService.insertChat(chat);
			
			if(insertResult>0) {
				session.getAttributes().put("chat", chat);
				sendChat(chat, chat.getChatId());
			}
		}else if(chat.getChatroomId().equals("file")) {
			sendChat(chat, chatId);
		}
    }
    
    
    
    private void sendChat(ChatMsg chat, String chatId) throws Exception {
    	
        List<MyChatroom> chatMembers = getChatMember(chatroomId); // 데이터베이스에서 멤버 리스트 가져오기
        
    	Set<Map.Entry<String,WebSocketSession>> clients=this.clients.entrySet();

		
    	try {
			for(Map.Entry<String,WebSocketSession> client:clients) {
				String userId=client.getKey();
				log.info("{}", userId);
				for(MyChatroom s : chatMembers) {
					if(userId.equals(s.getMember().getMemberId())) {
						client.getValue().sendMessage(new TextMessage(mapper.writeValueAsString(chat)));
					}else {
						sessionMemberMap.put("member", s);
						sessionMemberMap.put("chatId", chatId);
						insertChatNotify(sessionMemberMap, client);
					}
						
				}
			}
		}catch(IOException e){
			e.printStackTrace();
		}
    }
    
    public void insertChatNotify(Map<String, Object> memberMap, Entry<String, WebSocketSession> client) throws Exception {
    	if(chatroomService.insertChatNotify(memberMap)>0) {
    		log.info("삽입 성공");
    	}else log.info("삽입 실패");
    	
    }
    
    
    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
        connectedSessions.remove(session); // 접속 종료한 세션을 리스트에서 제거
        clients.remove(session);
    }
    

    
    
}
 