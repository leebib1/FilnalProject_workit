package com.workit.work.model.dto;

import java.sql.Date;
import java.sql.Timestamp;

import com.workit.member.model.dto.Member;
import com.workit.member.model.vo.MemberVO;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
@Builder
public class Work {
	private int workNo;//SEQ_WORK_NO
	private Date workDate;
	private Timestamp workStart;
	private Timestamp workEnd;
	private String workStatus;
	private Member member;
	//DB를 이용해서 계산식이 필요한 필드추가
	private String totalWorkTime;
    private String overtime;
}
