package com.workit.work.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.workit.member.model.dto.Member;
import com.workit.work.model.dto.AnnualLeaveCount;
import com.workit.work.model.dto.Work;
import com.workit.work.model.dto.WorkChange;

@Repository
public class WorkDaoImpl implements WorkDao {

	@Override
	public List<Work> getMonthWorkTime(SqlSessionTemplate session, Map<String, Object> paramMap) {
		return session.selectList("work.getMonthWorkTime", paramMap);
	}

	@Override
	public int insertStartWorkTime(SqlSessionTemplate session, Work w) {
		return session.insert("work.insertStartWorkTime",w);
	}

	@Override
	public boolean isWorkDataRegisteredForDate(SqlSessionTemplate session, Map<String, String> mapParam) {
		int count = session.selectOne("work.isWorkDataRegisteredForDate",mapParam);
		return count>0;
	}

	@Override
	public Work selectWorkByDateAndMemberId(SqlSessionTemplate session, Map<String, Object> paramMap) {
		return session.selectOne("work.selectWorkByDateAndMemberId",paramMap);
	}

	@Override
	public boolean isCheckOutRegisteredForDate(SqlSessionTemplate session, Map<String, String> mapParam) {
		int count = session.selectOne("work.isCheckOutRegisteredForDate",mapParam); 
		return count>0;
	}

	@Override
	public int updateEndWorkTime(SqlSessionTemplate session, Work w) {
		return session.update("work.updateEndWorkTime",w);
	}

	@Override
	public int lateCount(SqlSessionTemplate session, Map<String, Object> paramMap) {
		return session.selectOne("work.lateCount",paramMap);
	}

	@Override
	public int earlyLeaveCount(SqlSessionTemplate session, Map<String, Object> paramMap) {
		return session.selectOne("work.earlyLeaveCount",paramMap);
	}

	@Override
	public int insertWorkchange(SqlSessionTemplate session, WorkChange wc) {
		return session.insert("work.insertWorkchange",wc);
	}

	@Override
	public List<WorkChange> selectAllWorkChange(SqlSessionTemplate session, Map<String, Integer> param) {
		int cPage=(int)param.get("cPage");
		int numPerpage=(int)param.get("numPerpage");
		RowBounds rb=new RowBounds((cPage-1)*numPerpage,numPerpage);
		return session.selectList("work.selectAllWorkChange","",rb);
	}

	@Override
	public int selectWorkChangeCount(SqlSessionTemplate session) {
		return session.selectOne("work.selectWorkChangeCount");
	}

	@Override
	public Work selectWorkByNo(SqlSessionTemplate session, int no) {
		return session.selectOne("work.selectWorkByNo",no);
	}

	@Override
	public int updateWorkTime(SqlSessionTemplate session, Work w) {
		return session.update("work.updateWorkTime",w);
	}

	@Override
	public int updateWorkChangeStatus(SqlSessionTemplate session, Map<String, Object> paramMap) {
		return session.update("work.updateWorkChangeStatus",paramMap);
	}

	@Override
	public int deleteWorkChange(SqlSessionTemplate session, int workChangeNo) {
		return session.delete("work.deleteWorkChange",workChangeNo);
	}

	@Override
	public List<Work> getMonthWorkTimeByTeam(SqlSessionTemplate session, Map<String, Object> paramMap) {
		return session.selectList("work.getMonthWorkTimeByTeam",paramMap);
	}

	@Override
	public Member selectMemberById(SqlSessionTemplate session, String memberId) {
		// TODO Auto-generated method stub
		return session.selectOne("work.selectMemberById",memberId);
	}

	@Override
	public AnnualLeaveCount usedLeaveCount(SqlSessionTemplate session, String memberId) {
		// TODO Auto-generated method stub
		return session.selectOne("work.usedLeaveCount",memberId);
	}

}
