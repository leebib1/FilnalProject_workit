package com.workit.chat.service;

import java.util.List;
import java.util.Map;

import com.workit.chat.model.dto.Chatroom;
import com.workit.chat.model.dto.MyChatroom;
import com.workit.member.model.dto.Member;

public interface ChatService {
	
	Map<String, Object> selectMyChatroomList(String memberId);
	
	Map<String, Object> selectChatroomByroomId(String chatroomId);
	
	Map<String, Object> searchByKeyword(Map<String, Object> keyword);
	
	String insertChatroom(String loginMember, Chatroom chatroom);
	
	List<Member> selectMemberAll();
	
	int deleteMyChatroom(Map<String, Object> param);
	
	List<MyChatroom> selectChatByChatroomId(String chatroomId);
	
	List<MyChatroom> selectChatMember(String chatroomId);
	
	List<MyChatroom> selectCurrentChatMembers(String chatroomId);
	
	int updateChatroomMember(Map<String, Object> param);
 }
