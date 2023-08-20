package com.workit.chat.model.dao;

import java.util.List;
import java.util.Map;

import com.workit.chat.model.dto.Chat;
import com.workit.chat.model.dto.Chatroom;
import com.workit.chat.model.dto.MyChatroom;
import com.workit.chatroom.model.dto.ChatroomFile;
import com.workit.member.model.dto.Department;
import com.workit.member.model.dto.Member;
import com.workit.member.model.vo.MemberVO;

public interface ChatDao {
	
	List<Chatroom> selectMyChatroomId(String memberId);
	
	Chat selectAllMyChatroom(String chatroomId);
	
	List<Chatroom> selectChatroomByroomId(String chatroomId);
	
	List<Chat> searchChatByKeyword(Map<String, Object> param);
	
	List<MyChatroom> searchChatroomByKeyword(Map<String, Object> param);
	
	List<ChatroomFile> searchfileByKeyword(Map<String, Object> param);
	
	List<MyChatroom> selectChatroomIdById(String id);
	
	void insertChatroom(Map<String, Object> param);
	
	int insertMyChatroom(Map<String, Object> param);
	
	List<Department> selectDeptAll();
	
	List<Member> selectMemberAll();
	
	int deleteMyChatroom(Map<String, Object> param);
	
	List<MyChatroom> selectChatByChatroomId(String chatroomId);
	
	List<MyChatroom> selectChatMember(String chatroomId);
	
	List<MyChatroom> selectCurrentChatMembers(String chatroomId);
	
	int updateChatroomMember(Map<String, Object> param);
	
	List<MyChatroom> selectMyChatroomAll(String loginMember);

	
}
