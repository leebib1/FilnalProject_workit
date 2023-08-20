package com.workit.meet.model.service;

import java.util.Date;
import java.util.List;
import java.util.Map;

import com.workit.meet.model.dto.Meet;

public interface MeetService {

	//전체일정 출력
	List<Meet> getMeetingsByRoomId(int roomId);
	//중복확인
	List<Meet> getMeetingsByRoomIdAndDate(Map<String, Object> paramMap);
	//회의실 예약추가
	int insertMeet(Map<String, Object> paramMap);
	//사원별 예약내역
	List<Meet> selectMeetByMember(Map<String, Object> params);
	int selectMeetByIdCount(Map<String, Object> params);
	//예약내역 삭제
	int deleteMeetById(int meetId);

}
