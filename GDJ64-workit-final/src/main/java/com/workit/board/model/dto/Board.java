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
public class Board {
	private int boardNo;
	private String boardTitle;
	private MemberVO member;
	private String boardContent;
	private Date boardDate;
	private int viewCount;
	private int commentCount;
}
