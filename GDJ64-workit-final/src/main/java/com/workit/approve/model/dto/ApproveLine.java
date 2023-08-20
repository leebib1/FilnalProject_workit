package com.workit.approve.model.dto;

import java.sql.Date;

import com.workit.member.model.dto.Member;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
@Builder
public class ApproveLine {
	private int approveLineNo;
	private int approveOrder;
	private int approveNo;
	private String approveStatus;
	private Date approveDate;
	private Member memberId;
	private int currentOrder;
}