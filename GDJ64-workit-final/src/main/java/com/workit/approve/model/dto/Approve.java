package com.workit.approve.model.dto;

import java.sql.Date;
import java.util.List;

import com.workit.member.model.dto.Member;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Approve {
	private int approveNo;
	private String approveTitle;
	private String approveContent;
	private Date currentDate;
	private String approveState;
	private String approveKind;
	private String rejectMessage;
	private Member memberId;
	private ApproveAttach approveAttach;
	private Time time;
	private List<ApproveLine> approveLine;
	private List<ReferLine> referLine;
	private List<Expenditure> expenditure;
}