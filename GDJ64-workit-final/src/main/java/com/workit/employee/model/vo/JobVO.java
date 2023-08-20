package com.workit.employee.model.vo;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@AllArgsConstructor
@NoArgsConstructor
public class JobVO {
	private String jobCode;
	private String jobName;
	private int jobCount;
	private String jobAuth;
}
