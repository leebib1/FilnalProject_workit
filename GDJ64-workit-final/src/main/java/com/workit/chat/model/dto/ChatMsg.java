package com.workit.chat.model.dto;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class ChatMsg {
	private String chatId;
	private String chatroomId;
	private String memberId;
	private String chatContent;
	private Date chatDate;
}
