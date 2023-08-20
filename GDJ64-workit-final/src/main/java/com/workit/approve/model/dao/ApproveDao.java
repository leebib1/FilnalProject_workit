package com.workit.approve.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.workit.approve.model.dto.Approve;
import com.workit.approve.model.dto.ApproveAttach;
import com.workit.approve.model.dto.ApproveLine;
import com.workit.approve.model.dto.Expenditure;
import com.workit.approve.model.dto.ReferLine;
import com.workit.approve.model.dto.Time;
import com.workit.approve.model.dto.ToDo;
import com.workit.member.model.dto.Member;

public interface ApproveDao {
	public List<Approve> selectAllWaitingApprove(SqlSession session,Map<String,Object> param);
	public List<Approve> selectDraftDocumentBox(SqlSession session,Map<String,Object> param);
	public List<Member> selectAllMember(SqlSession session);
	public List<Member> changeDep(SqlSession session,String deptName);
	public Member printMember(SqlSession session,String memberId);
	public int insertApprove(SqlSession session, Approve ap);
	public int insertTime(SqlSession session, Time t);
	public int insertApproveAttach(SqlSession session, ApproveAttach aa);
	public int insertApproveLine(SqlSession session, Map<String,Object> param);
	public int insertReferLine(SqlSession session, Map<String,Object> param);
	public int insertExpenditure(SqlSession session, Expenditure ex);
	public List<Approve> selectAllSaveDocument(SqlSession session, Map<String,Object> param);
	public List<Approve> detailSave(SqlSession session, Map<String,Object> param);
	public List<ApproveLine> detailApproveLines(SqlSession session, Map<String,Object> param);
	public List<ReferLine> detailReferLines(SqlSession session, Map<String,Object> param);
	public List<Expenditure> detailExpenditures(SqlSession session, Map<String,Object> param);
	public int removeSave(SqlSession session, String deleteApproveNo);
	public int reInsertApporve(SqlSession session, Approve ap);
	public int reInsertTime(SqlSession session, Time t);
	public int reInsertApproveAttach(SqlSession session, ApproveAttach aa);
	public int reInsertApproveLine(SqlSession session, Map<String,Object> param);
	public int reInsertReferLine(SqlSession session, Map<String,Object> param);
	public int reInsertExpenditure(SqlSession session, Expenditure ex);
	public int approveAssign(SqlSession session, Map<String,Object> param);
	public int selectTotalLineCnt(SqlSession session, Map<String,Object> param);
	public int selectCompleteLineCnt(SqlSession session, Map<String,Object> param);
	public int plusCurrentOrder(SqlSession session, Map<String,Object> param);
	public int updateProcessState(SqlSession session,Map<String,Object> param);
	public int updateCompleteState(SqlSession session,Map<String,Object> param);
	public int rejectMessage(SqlSession session,Map<String,Object> param);
	public int changeStateSave(SqlSession session,Map<String,Object> param);
	public List<Approve> selectReferenceDocumentBox(SqlSession session,Map<String,Object> param);
	public int selectDraftDocumentsCount(SqlSession session,Map<String,Object> param);
	public int allCompleteAppLine(SqlSession session,Map<String,Object> param);
	public int timeDifference(SqlSession session,Map<String,Object> param);
	public String selectStartTime(SqlSession session,Map<String,Object> param);
	public int insertAnnualLeave(SqlSession session,Map<String,Object> param);
	public List<Approve> selectWaitingApproveTopFive(SqlSession session,Map<String,Object> param);
	public int selectSelectWaitingApproveCnt(SqlSession session,Map<String,Object> param);
	public int insertToDo(SqlSession session, Map<String,Object> param);
	public List<ToDo> selectToDoListById(SqlSession session, Map<String,Object> param);
	public int selectToDoNo(SqlSession session);
	public ToDo selectToDoById(SqlSession session, Map<String,Object> param);
	public int deleteToDo(SqlSession session,Map<String,Object> param);
}