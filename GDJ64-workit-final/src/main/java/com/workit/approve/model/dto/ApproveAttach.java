package com.workit.approve.model.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
@Builder
public class ApproveAttach {
	private int attachmentNo;
	private String oriName;
	private int approveNo;
	private String saveName;
}
