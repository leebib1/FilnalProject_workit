package com.workit.approve.model.dto;

import java.sql.Date;
import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Builder
@Data
public class Time {
	private int timeNo;
	private Timestamp startTime;
	private Timestamp endTime;
	private int approveNo;
}
