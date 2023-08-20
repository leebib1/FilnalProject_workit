package com.workit.work.model.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Builder
@Data
public class WorkChange {
	int workChangeNo;//SEQ_WORK_CHANGE_NO
	Work work;
	String changeStatus;
	String reason;
}
