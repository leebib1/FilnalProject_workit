package com.workit.meet.model.dto;

import java.sql.Date;
import java.sql.Timestamp;

import com.workit.member.model.vo.MemberVO;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
@Builder
public class Meet {
    private int id;
    private MemberVO member;
    private MeetingRooms room;
    private String title;
    private String description;
    private Date eventDate;
    private Timestamp startTime;
    private Timestamp endTime;
}
