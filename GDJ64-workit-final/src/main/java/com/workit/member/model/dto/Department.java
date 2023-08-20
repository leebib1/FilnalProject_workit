package com.workit.member.model.dto;


import java.io.Serializable;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Department implements Serializable{
	private static final long serialVersionUID = 5394728630150921069L;
	private String deptCode;
	private String deptName;
}
