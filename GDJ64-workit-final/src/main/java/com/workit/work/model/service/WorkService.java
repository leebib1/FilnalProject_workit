package com.workit.work.model.service;

import java.util.List;
import java.util.Map;

import com.workit.member.model.dto.Member;
import com.workit.work.model.dto.AnnualLeaveCount;
import com.workit.work.model.dto.Work;
import com.workit.work.model.dto.WorkChange;

public interface WorkService {
	
	// 월별 근무 정보 가져오기
	List<Work> getMonthWorkTime(Map<String, Object> paramMap);
	
	//출근시간 등록
	int insertStartWorkTime(Work w);
	//퇴근시간 등록
	int updateEndWorkTime(Work w);

	//출근여부확인
	boolean isWorkDataRegisteredForDate(Map<String, String> mapParam);
	//퇴근여부확인
	boolean isCheckOutRegisteredForDate(Map<String, String> mapParam);

	//오늘 출퇴근 정보
	Work selectWorkByDateAndMemberId(Map<String, Object> paramMap);
	
	//지각계카운트
	int lateCount(Map<String, Object> paramMap);
	//조퇴계카운트
	int earlyLeaveCount(Map<String, Object> paramMap);

	//출퇴근 수정요청
	int insertWorkchange(WorkChange wc);
	//출퇴근 요청 리스트
	List<WorkChange> selectAllWorkChange(Map<String, Integer> map);
	int selectWorkChangeCount();
	
	//workNo로 구하기
	Work selectWorkByNo(int no);
	//출퇴근 수정처리
	int updateWorkTime(Work w);
	//상태를 수정완료로 처리
	int updateWorkChangeStatus(Map<String, Object> paramMap);
	//출퇴근요청 삭제
	int deleteWorkChange(int workChangeNo);

	//부서별 근무 정보
	List<Work> getMonthWorkTimeByTeam(Map<String, Object> paramMap);

	Member selectMemberById(String memberId);

	AnnualLeaveCount usedLeaveCount(String memberId);




	
}
