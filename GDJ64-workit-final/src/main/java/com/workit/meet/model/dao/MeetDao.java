package com.workit.meet.model.dao;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;

import com.workit.meet.model.dto.Meet;

public interface MeetDao {

    List<Meet> selectMeetByRoomId(SqlSessionTemplate session, int roomId);

	List<Meet> getMeetingsByRoomIdAndDate(SqlSessionTemplate session, Map<String, Object> paramMap);

	int insertMeet(SqlSessionTemplate session, Map<String, Object> paramMap);

	List<Meet> selectMeetByMember(SqlSessionTemplate session, Map<String, Object> params);

	int deleteMeetById(SqlSessionTemplate session, int meetId);

	int selectMeetByIdCount(SqlSessionTemplate session, Map<String, Object> params);



	
}
