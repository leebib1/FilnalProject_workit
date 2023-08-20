package com.workit.lecture.model.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;

import com.workit.lecture.model.dto.Lecture;
import com.workit.member.model.vo.MemberVO;

public interface LectureDao {

	List<Lecture> selectLectureAll(SqlSessionTemplate session, Map<String, Object> map);

	int selectLectureCount(SqlSessionTemplate session, Map<String, Object> map);

	List<MemberVO> selectTeacher(SqlSessionTemplate session);

	int insertLecture(SqlSessionTemplate session, Map<String, Object> params);

	Lecture selectLectureByNo(SqlSessionTemplate session, int no);

	int updateStatus(SqlSessionTemplate session, Map<String, Object> map);

	int deleteLecture(SqlSessionTemplate session, int no);

	int updateLecture(SqlSessionTemplate session, Map<String, Object> params);
}
