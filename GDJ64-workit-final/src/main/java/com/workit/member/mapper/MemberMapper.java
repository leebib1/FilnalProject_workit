package com.workit.member.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.session.RowBounds;

import com.workit.member.model.dto.Member;
import com.workit.member.model.vo.ApprovMemberVO;
import com.workit.member.model.vo.MemberVO;

@Mapper
public interface MemberMapper {
	
	MemberVO selectMemberByParam(Map<String, Object> param);

	int updateProfileImg(Map<String, Object> param);

	int insertApprovMember(Map<String, Object> param);

	ApprovMemberVO selectApprovMember(String memberId);

	int selectApprovCount();

	List<ApprovMemberVO> selectApprovAll(RowBounds rb);

	int updateMember(Map<String, Object> param);
	
	MemberVO selectMemberById(String memberId);
}
