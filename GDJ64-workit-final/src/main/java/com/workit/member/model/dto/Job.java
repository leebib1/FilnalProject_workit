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
public class Job implements Serializable {
	private static final long serialVersionUID = -1543326381804319442L;
	private String jobCode;
	private String jobName;
	private String jobAuth;
}
