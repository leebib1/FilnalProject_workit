package com.workit.approve.model.service;

import java.util.List;
import java.util.Map;

import com.workit.approve.model.dto.Approve;
import com.workit.approve.model.dto.ApproveAttach;
import com.workit.approve.model.dto.ApproveLine;
import com.workit.approve.model.dto.Expenditure;
import com.workit.approve.model.dto.ReferLine;
import com.workit.approve.model.dto.Time;
import com.workit.approve.model.dto.ToDo;
import com.workit.member.model.dto.Member;

public interface ApproveService {
	/* public List<Approve> selectAllWaitingApprove(String memberId); */
	public List<Approve> selectAllWaitingApprove(Map<String,Object> param);
	public List<Member> selectAllMember();
	public List<Member> changeDep(String deptName);
	public Member printMember(String memberId);
	public int insertApprove(Approve ap);
	public int insertTime(Time t);
	public int insertApproveAttach(ApproveAttach aa);
	public int insertApproveLine(Map<String,Object> param);
	public int insertReferLine(Map<String,Object> param);
	public int insertExpenditure(Expenditure ex);
	public List<Approve> selectAllSaveDocument(Map<String,Object> param);
	public List<Approve> detailSave(Map<String,Object> param);
	public List<ApproveLine> detailApproveLines(Map<String,Object> param);
	public List<ReferLine> detailReferLines(Map<String,Object> param);
	public List<Expenditure> detailExpenditures(Map<String,Object> param);
	public int removeSave(String deleteApproveNo);
	public int reInsertApprove(Approve ap);
	public int reInsertTime(Time t);
	public int reInsertApproveAttach(ApproveAttach aa);
	public int reInsertApproveLine(Map<String,Object> param);
	public int reInsertReferLine(Map<String,Object> param);
	public int reInsertExpenditure(Expenditure ex);
	public int approveAssign(Map<String,Object> param);
	public int selectTotalLineCnt(Map<String,Object> param);
	public int selectCompleteLineCnt(Map<String,Object> param);
	public int plusCurrentOrder(Map<String,Object> param);
	public int updateProcessState(Map<String,Object> param);
	public int updateCompleteState(Map<String,Object> param);
	public int rejectMessage(Map<String,Object> param);
	public int changeStateSave(Map<String,Object> param);
	public List<Approve> selectDraftDocumentBox(Map<String,Object> param);
	public List<Approve> selectReferenceDocumentBox(Map<String,Object> param);
	public int selectDraftDocumentsCount(Map<String,Object> param);
	public int allCompleteAppLine(Map<String,Object> param);
	public int timeDifference(Map<String,Object> param);
	public String selectStartTime(Map<String,Object> param);
	public int insertAnnualLeave(Map<String,Object> param);
	public List<Approve> selectWaitingApproveTopFive(Map<String,Object> param);
	public int selectSelectWaitingApproveCnt(Map<String,Object> param);
	public int insertToDo(Map<String,Object> param);
	public List<ToDo> selectToDoListById(Map<String,Object> param);
	public int selectToDoNo();
	public ToDo selectToDoById(Map<String,Object> param);
	public int deleteToDo(Map<String,Object> param);
}