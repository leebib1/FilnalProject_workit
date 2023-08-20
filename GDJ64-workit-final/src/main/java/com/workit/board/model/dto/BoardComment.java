package com.workit.board.model.dto;

import java.sql.Date;


import com.workit.member.model.vo.MemberVO;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
@Builder
public class BoardComment {
	private int commentNo;
	private MemberVO member;
	private String commentContent;
	private Date commentDate;
	private int refCommentNo;
	private Board board;
	private String status;
}
