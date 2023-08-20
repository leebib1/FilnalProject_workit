package com.workit.approve.model.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class AnnualLeave {
	private int annualLeaveNo;
	private String memberId;
	private String annualLeaveType;
	private Date annualLeaveDate;
}
