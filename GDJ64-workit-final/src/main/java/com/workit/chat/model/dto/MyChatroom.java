package com.workit.chat.model.dto;


import java.util.ArrayList;
import java.util.List;

import com.workit.chatroom.model.dto.ChatNotification;
import com.workit.chatroom.model.dto.ChatroomFile;
import com.workit.member.model.dto.Member;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class MyChatroom {
	private int myChatroomNo;
	private Chatroom chatroom;
	private Member member;
	
	private List<ChatNotification> chatNotification = new ArrayList<ChatNotification>();
}
