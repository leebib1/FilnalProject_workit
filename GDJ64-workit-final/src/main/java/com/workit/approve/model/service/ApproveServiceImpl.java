package com.workit.approve.model.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.workit.approve.model.dao.ApproveDao;
import com.workit.approve.model.dto.Approve;
import com.workit.approve.model.dto.ApproveAttach;
import com.workit.approve.model.dto.ApproveLine;
import com.workit.approve.model.dto.Expenditure;
import com.workit.approve.model.dto.ReferLine;
import com.workit.approve.model.dto.Time;
import com.workit.approve.model.dto.ToDo;
import com.workit.member.model.dto.Member;

@Service
public class ApproveServiceImpl implements ApproveService {

	@Autowired
	private ApproveDao dao;
	@Autowired
	private SqlSession session;
	
	@Override
	public List<Approve> selectAllWaitingApprove(Map<String,Object> param) {
		return dao.selectAllWaitingApprove(session,param);
	}
	
	@Override
	public List<Approve> selectDraftDocumentBox(Map<String, Object> param) {
		return dao.selectDraftDocumentBox(session,param);
	}

	@Override
	public List<Member> selectAllMember() {
		return dao.selectAllMember(session);
	}


	@Override
	public List<Approve> selectAllSaveDocument(Map<String, Object> param) {
		return dao.selectAllSaveDocument(session,param);
	}

	@Override
	public List<Approve> detailSave(Map<String, Object> param) {
		return dao.detailSave(session,param);
	}
	
	@Override
	public List<ApproveLine> detailApproveLines(Map<String, Object> param) {
		return dao.detailApproveLines(session,param);
	}

	@Override
	public List<ReferLine> detailReferLines(Map<String, Object> param) {
		return dao.detailReferLines(session,param);
	}
	
	@Override
	public List<Expenditure> detailExpenditures(Map<String, Object> param) {
		return dao.detailExpenditures(session,param);
	}

	@Override
	public int removeSave(String deleteApproveNo) {
		return dao.removeSave(session,deleteApproveNo);
	}

	@Override
	public List<Member> changeDep(String deptName) {
		return dao.changeDep(session,deptName);
	}

	@Override
	public Member printMember(String memberId) {
		return dao.printMember(session,memberId);
	}

	@Override
	public int insertApprove(Approve ap) {
		return dao.insertApprove(session,ap);
	}
	
	@Override
	public int insertTime(Time t) {
		return dao.insertTime(session,t);
	}

	@Override
	public int insertApproveAttach(ApproveAttach aa) {
		return dao.insertApproveAttach(session,aa);
	}
	
	@Override
	public int insertApproveLine(Map<String, Object> param) {
		return dao.insertApproveLine(session,param);
	}

	@Override
	public int insertReferLine(Map<String, Object> param) {
		return dao.insertReferLine(session,param);
	}
	
	@Override
	public int insertExpenditure(Expenditure ex) {
		return dao.insertExpenditure(session, ex);
	}

	@Override
	public int reInsertApprove(Approve ap) {
		return dao.reInsertApporve(session,ap);
	}

	@Override
	public int reInsertTime(Time t) {
		return dao.reInsertTime(session, t);
	}

	@Override
	public int reInsertApproveAttach(ApproveAttach aa) {
		return dao.reInsertApproveAttach(session, aa);
	}

	@Override
	public int reInsertApproveLine(Map<String, Object> param) {
		return dao.reInsertApproveLine(session, param);
	}

	@Override
	public int reInsertReferLine(Map<String, Object> param) {
		return dao.reInsertReferLine(session, param);
	}

	@Override
	public int reInsertExpenditure(Expenditure ex) {
		return dao.reInsertExpenditure(session, ex);
	}

	@Override
	public int approveAssign(Map<String, Object> param) {
		return dao.approveAssign(session,param);
	}

	@Override
	public int selectTotalLineCnt(Map<String, Object> param) {
		return dao.selectTotalLineCnt(session,param);
	}

	@Override
	public int selectCompleteLineCnt(Map<String, Object> param) {
		return dao.selectCompleteLineCnt(session,param);
	}

	@Override
	public int plusCurrentOrder(Map<String, Object> param) {
		return dao.plusCurrentOrder(session,param);
	}

	@Override
	public int updateProcessState(Map<String, Object> param) {
		return dao.updateProcessState(session,param);
	}

	@Override
	public int updateCompleteState(Map<String, Object> param) {
		return dao.updateCompleteState(session,param);
	}

	@Override
	public int changeStateSave(Map<String, Object> param) {
		return dao.changeStateSave(session,param);
	}

	@Override
	public int rejectMessage(Map<String, Object> param) {
		return dao.rejectMessage(session,param);
	}

	@Override
	public List<Approve> selectReferenceDocumentBox(Map<String, Object> param) {
		return dao.selectReferenceDocumentBox(session,param);
	}

	@Override
	public int selectDraftDocumentsCount(Map<String,Object> param) {
		return dao.selectDraftDocumentsCount(session,param);
	}

	@Override
	public int allCompleteAppLine(Map<String, Object> param) {
		return dao.allCompleteAppLine(session,param);
	}

	@Override
	public int timeDifference(Map<String, Object> param) {
		return dao.timeDifference(session,param);
	}

	@Override
	public String selectStartTime(Map<String, Object> param) {
		return dao.selectStartTime(session,param);
	}

	@Override
	public int insertAnnualLeave(Map<String, Object> param) {
		return dao.insertAnnualLeave(session,param);
	}

	@Override
	public List<Approve> selectWaitingApproveTopFive(Map<String, Object> param) {
		return dao.selectWaitingApproveTopFive(session,param);
	}

	@Override
	public int selectSelectWaitingApproveCnt(Map<String, Object> param) {
		return dao.selectSelectWaitingApproveCnt(session,param);
	}

	@Override
	public int insertToDo(Map<String, Object> param) {
		return dao.insertToDo(session,param);
	}

	@Override
	public List<ToDo> selectToDoListById(Map<String, Object> param) {
		return dao.selectToDoListById(session,param);
	}

	@Override
	public int selectToDoNo() {
		return dao.selectToDoNo(session);
	}

	@Override
	public ToDo selectToDoById(Map<String, Object> param) {
		return dao.selectToDoById(session,param);
	}

	@Override
	public int deleteToDo(Map<String, Object> param) {
		return dao.deleteToDo(session,param);
	}
	
	
}