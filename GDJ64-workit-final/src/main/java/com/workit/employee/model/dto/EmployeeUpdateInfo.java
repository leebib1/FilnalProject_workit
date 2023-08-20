package com.workit.employee.model.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class EmployeeUpdateInfo {
	private int memberUpdateNo;
	private String memberId;
	private String phone;
	private String address;
	private String email;
	private String approvalMember;
	private String approvalFl;
	private String updateComment;
	private Date requestDate;
	private String subAddress;
}
