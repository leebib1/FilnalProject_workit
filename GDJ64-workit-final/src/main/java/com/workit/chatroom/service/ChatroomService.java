package com.workit.chatroom.service;



import java.io.IOException;
import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

import com.workit.chat.model.dto.ChatMsg;
import com.workit.chat.model.dto.Chatroom;
import com.workit.chat.model.dto.MyChatroom;
import com.workit.chatroom.model.dto.AttachedFile;
import com.workit.chatroom.model.dto.ChatroomFile;
import com.workit.member.model.dto.Member;
import com.workit.member.model.vo.MemberVO;

public interface ChatroomService {
	
	int insertChat(ChatMsg chat);
	
	AttachedFile saveFile(MultipartFile file, String chatroomId, String chatId, String fileDirectory) throws IOException;
	
	List<ChatroomFile> selectFileByChatroomId(String chatroomId);
	
	List<Member> selectChatMemberById(String chatroomId);
	
	int insertChatNotify(Map<String, Object> param);
	
	int chatNotificationCount(String loginMember);
	
	int deleteNotify(int myChatroomNo);
	
	MemberVO selectMemberByChoice(String memberId);
	
	List<Chatroom> selectChatroomByroomId(String chatroomId);
	
	List<MyChatroom> selectChatroomById(String chatroomId);
	
	List<MyChatroom> selectCurrentChatMembers(String chatroomId);
}
