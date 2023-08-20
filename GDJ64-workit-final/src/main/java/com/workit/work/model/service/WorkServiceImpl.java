package com.workit.work.model.service;

import java.util.List;
import java.util.Map;

import org.checkerframework.checker.units.qual.m;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.workit.member.model.dto.Member;
import com.workit.work.model.dao.WorkDao;
import com.workit.work.model.dto.AnnualLeaveCount;
import com.workit.work.model.dto.Work;
import com.workit.work.model.dto.WorkChange;

@Service
public class WorkServiceImpl implements WorkService {

	private WorkDao dao;
	private SqlSessionTemplate session;
	
	@Autowired
	public WorkServiceImpl(WorkDao dao, SqlSessionTemplate session) {
		this.dao = dao;
		this.session = session;
	}

	@Override
	public List<Work> getMonthWorkTime(Map<String, Object> paramMap) {
		return dao.getMonthWorkTime(session, paramMap);
	}

	@Override
	public int insertStartWorkTime(Work w) {
		return dao.insertStartWorkTime(session,w);
	}

	@Override
	public boolean isWorkDataRegisteredForDate(Map<String, String> mapParam) {
		return dao.isWorkDataRegisteredForDate(session,mapParam);
	}

	@Override
	public Work selectWorkByDateAndMemberId(Map<String, Object> paramMap) {
		return dao.selectWorkByDateAndMemberId(session,paramMap);
	}

	@Override
	public boolean isCheckOutRegisteredForDate(Map<String, String> mapParam) {
		return dao.isCheckOutRegisteredForDate(session,mapParam);
	}

	@Override
	public int updateEndWorkTime(Work w) {
		return dao.updateEndWorkTime(session, w);
	}

	@Override
	public int lateCount(Map<String, Object> paramMap) {
		return dao.lateCount(session,paramMap);
	}

	@Override
	public int earlyLeaveCount(Map<String, Object> paramMap) {
		return dao.earlyLeaveCount(session,paramMap);
	}

	@Override
	public int insertWorkchange(WorkChange wc) {
		return dao.insertWorkchange(session,wc);
	}

	@Override
	public List<WorkChange> selectAllWorkChange(Map<String, Integer> map) {
		return dao.selectAllWorkChange(session,map);
	}

	@Override
	public int selectWorkChangeCount() {
		return dao.selectWorkChangeCount(session);
	}

	@Override
	public Work selectWorkByNo(int no) {
		return dao.selectWorkByNo(session, no);
	}

	@Override
	public int updateWorkTime(Work w) {
		return dao.updateWorkTime(session, w);
	}

	@Override
	public int updateWorkChangeStatus(Map<String, Object> paramMap) {
		return dao.updateWorkChangeStatus(session,paramMap);
	}

	@Override
	public int deleteWorkChange(int workChangeNo) {
		return dao.deleteWorkChange(session, workChangeNo);
	}

	@Override
	public List<Work> getMonthWorkTimeByTeam(Map<String, Object> paramMap) {
		return dao.getMonthWorkTimeByTeam(session, paramMap);
	}

	@Override
	public Member selectMemberById(String memberId) {
		// TODO Auto-generated method stub
		return dao.selectMemberById(session,memberId);
	}

	@Override
	public AnnualLeaveCount usedLeaveCount(String memberId) {
		return dao.usedLeaveCount(session, memberId);
	}



}
