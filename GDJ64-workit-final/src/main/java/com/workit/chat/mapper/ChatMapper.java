package com.workit.chat.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.workit.chat.model.dto.Chat;
import com.workit.chat.model.dto.ChatMsg;
import com.workit.chat.model.dto.Chatroom;
import com.workit.chat.model.dto.MyChatroom;
import com.workit.chatroom.model.dto.AttachedFile;
import com.workit.chatroom.model.dto.ChatNotification;
import com.workit.chatroom.model.dto.ChatroomFile;
import com.workit.member.model.dto.Member;
import com.workit.member.model.vo.MemberVO;


@Mapper
public interface ChatMapper {
	
	List<Chatroom> selectMyChatroomId(String memberId);
	
	Chat selectAllMyChatroom(String chatroomId);
	
	List<Chatroom> selectChatroomByroomId(String chatroomId);
	
	List<Chat> searchChatByKeyword(Map<String, Object> param);
	
	List<MyChatroom> searchChatroomByKeyword(Map<String, Object> param);
	
	List<ChatroomFile> searchfileByKeyword(Map<String, Object> param);
	
	List<MyChatroom> selectChatroomIdById(String id);
	
	void insertChatroom(Map<String, Object> param);
	
	int insertMyChatroom(Map<String, Object> param);
	
	int deleteMyChatroom(Map<String, Object> param);
	
	List<MyChatroom> selectChatByChatroomId(String chatroomId);
	
	int insertChat(ChatMsg chat);
	
	List<MyChatroom> selectChatMember(String chatroomId);
	
	List<MyChatroom> selectCurrentChatMembers(String chatroomId);
	
	int updateChatroomMember(Map<String, Object> param);
	
	int saveFile(Map<String, Object> param);
	
	int insertFile(Map<String, Object> param);
	
	AttachedFile selectFileById(String fileId);
	
	List<ChatroomFile> selectFileByChatroomId(String chatroomId);
	
	List<Member> selectChatMemberById(String chatroomId);
	
	int insertChatNotify(ChatNotification chatread);
	
	int chatNotificationCount(String loginMember);
	
	int chatNotificationCountById(Map<String, Object> param);
	
	List<MyChatroom> selectMyChatroomAll(String loginMember);
	
	int deleteNotify(int myChatroomNo);
	
	List<MyChatroom> selectChatroomById(String chatroomId);
}
