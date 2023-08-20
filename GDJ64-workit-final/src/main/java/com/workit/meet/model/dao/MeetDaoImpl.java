package com.workit.meet.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.workit.meet.model.dto.Meet;

@Repository
public class MeetDaoImpl implements MeetDao {

	@Override
	public List<Meet> selectMeetByRoomId(SqlSessionTemplate session, int roomId) {
		return session.selectList("meet.selectMeetByRoomId",roomId);
	}

	@Override
	public List<Meet> getMeetingsByRoomIdAndDate(SqlSessionTemplate session, Map<String,Object> paramMap) {
		return session.selectList("meet.getMeetingsByRoomIdAndDate",paramMap);
	}

	@Override
	public int insertMeet(SqlSessionTemplate session, Map<String,Object> paramMap) {
		return session.insert("meet.insertMeet",paramMap);
	}

	@Override
	public List<Meet> selectMeetByMember(SqlSessionTemplate session, Map<String,Object> paramMap) {
		int cPage=(int)paramMap.get("cPage");
		int numPerpage=(int)paramMap.get("numPerpage");
		RowBounds rb=new RowBounds((cPage-1)*numPerpage,numPerpage);
		
		return session.selectList("meet.selectMeetByMember",paramMap,rb);
	}

	@Override
	public int deleteMeetById(SqlSessionTemplate session, int meetId) {
		return session.delete("meet.deleteMeetById",meetId);
	}

	@Override
	public int selectMeetByIdCount(SqlSessionTemplate session, Map<String, Object> params) {
		return session.selectOne("meet.selectMeetByIdCount",params);
	}



}
