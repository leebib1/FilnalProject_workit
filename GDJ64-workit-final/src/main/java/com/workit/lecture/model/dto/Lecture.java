package com.workit.lecture.model.dto;

import java.sql.Date;

import com.workit.member.model.vo.MemberVO;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Builder
@Data
public class Lecture {
	private int lectureNo;
    private String lectureName;
    private String lectureObjective;
    private String lectureContent;
    private String subject;
    private String lectureTarget;
    private int fee;
    private Date startDate;
    private Date endDate;
    private MemberVO member;
    private Date registrationDate;
    private String registrationStatus;
}
