package com.workit.member.model.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Member{
	private String memberId;
	private String memberName;
	private String profileImg;
	private String password;
	private String memberNo;
	private String phone;
	private String address;
	private String email;
	private Date hireDate;
	private Date entDate;
	private int salary;
	private int leave;
	private String subAddress;
	private Department dept;
	private Job job;

}
