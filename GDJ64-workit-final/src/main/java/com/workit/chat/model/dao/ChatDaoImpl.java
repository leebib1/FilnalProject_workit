package com.workit.chat.model.dao;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.workit.chat.mapper.ChatMapper;
import com.workit.chat.model.dto.Chat;
import com.workit.chat.model.dto.Chatroom;
import com.workit.chat.model.dto.MyChatroom;
import com.workit.chatroom.model.dto.ChatroomFile;
import com.workit.employee.mapper.EmployeeMapper;
import com.workit.member.model.dto.Department;
import com.workit.member.model.dto.Member;

import lombok.extern.slf4j.Slf4j;
@Repository
@Slf4j
public class ChatDaoImpl implements ChatDao {
	
	@Autowired
	private EmployeeMapper EmpMapper;
	
	@Autowired
	private ChatMapper chatMapper;
	
	@Override
	public List<Chatroom> selectMyChatroomId(String memberId) {
		return chatMapper.selectMyChatroomId(memberId);
	}

	@Override
	public Chat selectAllMyChatroom(String chatroomId) {
		return chatMapper.selectAllMyChatroom(chatroomId);
	}

	@Override
	public List<Chatroom> selectChatroomByroomId(String chatroomId) {
		return chatMapper.selectChatroomByroomId(chatroomId);
	}
	
	
	@Override
	public void insertChatroom(Map<String, Object> param) {
		chatMapper.insertChatroom(param);
	}

	@Override
	public List<Chat> searchChatByKeyword(Map<String, Object> param) {
		log.info("{}", param.get(param));
		return chatMapper.searchChatByKeyword(param);
	}

	@Override
	public List<MyChatroom> searchChatroomByKeyword(Map<String, Object> param) {
		return chatMapper.searchChatroomByKeyword(param);
	}

	@Override
	public List<ChatroomFile> searchfileByKeyword(Map<String, Object> param) {
		return chatMapper.searchfileByKeyword(param);
	}

	@Override
	public int insertMyChatroom(Map<String, Object> param) {
		return chatMapper.insertMyChatroom(param);
	}

	@Override
	public List<Member> selectMemberAll() {
		return EmpMapper.selectMemberAllByJob();
	}
	
	@Override
	public List<Department> selectDeptAll() {
		return EmpMapper.selectDeptAll();
	}

	@Override
	public int deleteMyChatroom(Map<String, Object> param) {
		return chatMapper.deleteMyChatroom(param);
	}

	@Override
	public List<MyChatroom> selectChatByChatroomId(String chatroomId) {
		log.info("{}", chatMapper.selectChatByChatroomId(chatroomId));
		return chatMapper.selectChatByChatroomId(chatroomId);
	}

//	@Override
//	public List<MyChatroom> searchByKeyword(Map<String, Object> param) {
//		return chatMapper.searchByKeyword(param);
//	}

	@Override
	public List<MyChatroom> selectChatroomIdById(String id) {
		return chatMapper.selectChatroomIdById(id);
	}


	@Override
	public List<MyChatroom> selectCurrentChatMembers(String chatroomId) {
		return chatMapper.selectCurrentChatMembers(chatroomId);
	}

	@Override
	public int updateChatroomMember(Map<String, Object> param) {
		return chatMapper.updateChatroomMember(param);
	}

	@Override
	public List<MyChatroom> selectChatMember(String chatroomId) {
		return chatMapper.selectChatMember(chatroomId);
	}

	@Override
	public List<MyChatroom> selectMyChatroomAll(String loginMember) {
		return chatMapper.selectMyChatroomAll(loginMember);
	}
	
	
	
	
	
	
	
	
}
