package com.workit.work.model.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;

import com.workit.member.model.dto.Member;
import com.workit.work.model.dto.AnnualLeaveCount;
import com.workit.work.model.dto.Work;
import com.workit.work.model.dto.WorkChange;

public interface WorkDao {
	
	List<Work> getMonthWorkTime(SqlSessionTemplate session, Map<String, Object> paramMap);

	int insertStartWorkTime(SqlSessionTemplate session, Work w);

	boolean isWorkDataRegisteredForDate(SqlSessionTemplate session, Map<String, String> mapParam);

	Work selectWorkByDateAndMemberId(SqlSessionTemplate session, Map<String, Object> paramMap);

	boolean isCheckOutRegisteredForDate(SqlSessionTemplate session, Map<String, String> mapParam);

	int updateEndWorkTime(SqlSessionTemplate session, Work w);

	int lateCount(SqlSessionTemplate session, Map<String, Object> paramMap);

	int earlyLeaveCount(SqlSessionTemplate session, Map<String, Object> paramMap);

	int insertWorkchange(SqlSessionTemplate session, WorkChange wc);

	List<WorkChange> selectAllWorkChange(SqlSessionTemplate session, Map<String, Integer> map);

	int selectWorkChangeCount(SqlSessionTemplate session);

	Work selectWorkByNo(SqlSessionTemplate session, int no);

	int updateWorkTime(SqlSessionTemplate session, Work w);

	int updateWorkChangeStatus(SqlSessionTemplate session, Map<String, Object> paramMap);

	int deleteWorkChange(SqlSessionTemplate session, int workChangeNo);

	List<Work> getMonthWorkTimeByTeam(SqlSessionTemplate session, Map<String, Object> paramMap);

	Member selectMemberById(SqlSessionTemplate session, String memberId);

	AnnualLeaveCount usedLeaveCount(SqlSessionTemplate session, String memberId);
}
