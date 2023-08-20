package com.workit.chatroom.model.dto;


import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class ChatNotification {
	private int chatReadNo;
	//private String chatId;
	private String memberId;
	private int myChatroomNo;
}
