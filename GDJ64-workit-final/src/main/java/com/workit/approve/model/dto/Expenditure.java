package com.workit.approve.model.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Expenditure {
	private int expenditureNO;
	private String account;
	private String useHistory;
	private String price;
	private int approveNo;
}
