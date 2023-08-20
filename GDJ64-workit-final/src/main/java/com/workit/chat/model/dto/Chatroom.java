package com.workit.chat.model.dto;

import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonIdentityInfo;
import com.fasterxml.jackson.annotation.ObjectIdGenerators;
import com.workit.chatroom.model.dto.ChatroomFile;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@JsonIdentityInfo(generator = ObjectIdGenerators.IntSequenceGenerator.class)
public class Chatroom {
	private String chatroomId;
	private String chatroomCode;
	private String chatroomTitle;
	private Date chatroomDate;
	private String memberId;
	private List<Chat> chat = new ArrayList<Chat>();
	private List<ChatroomFile> chatroomFile = new ArrayList<ChatroomFile>();
}
