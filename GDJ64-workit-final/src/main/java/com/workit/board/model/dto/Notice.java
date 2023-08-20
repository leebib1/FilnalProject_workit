package com.workit.board.model.dto;

import java.sql.Date;

import com.workit.member.model.vo.MemberVO;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Builder
@Data
public class Notice {
	private int noticeNo;
	private String noticeTitle;
	private MemberVO member;
	private String noticeContent;
	private Date noticeDate;
	private int viewCount;
	private int commentCount;
}
