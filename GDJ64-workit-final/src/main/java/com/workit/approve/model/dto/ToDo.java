package com.workit.approve.model.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
@Builder
public class ToDo {
	private int toDoNo;
	private String memberId;
	private String toDoContent;
}
