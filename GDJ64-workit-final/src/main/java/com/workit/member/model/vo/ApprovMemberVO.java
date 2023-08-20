package com.workit.member.model.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
@Getter
@AllArgsConstructor
@NoArgsConstructor
public class ApprovMemberVO {
	private int memberUpdateNo;
	private String memberId;
	private String memberName;
	private String approvalMember;
	private String approvalFl;
	private String updateComment;
	private Date requestDate;
}
