package com.workit.member.model.dao;

import java.util.List;
import java.util.Map;

import com.workit.member.model.vo.ApprovMemberVO;
import com.workit.member.model.vo.MemberVO;

public interface MemberDao {
	MemberVO selectMemberByParam(Map<String,Object> param);

	int updateProfileImg(Map<String, Object> param);

	int insertApprovMember(Map<String, Object> param);

	ApprovMemberVO selectApprovMember(String memberId);

	int selectApprovCount();

	List<ApprovMemberVO> selectApprovAll(Map<String, Object> param);

	int updateMember(Map<String, Object> param);
	
	//윤진추가
	MemberVO selectMemberById(String memberId);
}
