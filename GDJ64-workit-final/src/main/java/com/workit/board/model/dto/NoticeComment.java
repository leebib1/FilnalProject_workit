package com.workit.board.model.dto;

import java.sql.Date;

import com.workit.member.model.vo.MemberVO;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class NoticeComment {
	private int commentNo;
	private MemberVO member;
	private String commentContent;
	private Date commentDate;
	private int refCommentNo;
	private Notice notice;
	private String status;
}
