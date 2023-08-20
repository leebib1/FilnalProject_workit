package com.workit.chat.model.dto;

import java.util.Date;

import com.workit.member.model.dto.Member;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Chat {
	private String chatId;
	private String chatroomId;
	private Member member;
	private String chatContent;
	private Date chatDate;
}
