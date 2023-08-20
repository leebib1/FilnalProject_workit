package com.workit.lecture.model.service;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.workit.lecture.model.dao.LectureDao;
import com.workit.lecture.model.dto.Lecture;
import com.workit.member.model.vo.MemberVO;

@Service
public class LectureServiceImpl implements LectureService {

	private SqlSessionTemplate session;
	
	private LectureDao dao;
	
	@Autowired
	public LectureServiceImpl(SqlSessionTemplate session,LectureDao dao ) {
		this.session = session;
		this.dao = dao;
	}

	@Override
	public List<Lecture> selectLectureAll(Map<String, Object> map) {
		return dao.selectLectureAll(session,map);
	}

	@Override
	public int selectLectureCount(Map<String, Object> map) {
		return dao.selectLectureCount(session, map);
	}

	@Override
	public List<MemberVO> selectTeacher() {
		return dao.selectTeacher(session);
	}

	@Override
	public int insertLecture(Map<String, Object> params) {
		return dao.insertLecture(session, params);
	}

	@Override
	public Lecture selectLectureByNo(int no) {
		return dao.selectLectureByNo(session, no);
	}

	@Override
	public int updateStatus(Map<String, Object> map) {
		return dao.updateStatus(session, map);
	}

	@Override
	public int deleteLecture(int no) {
		return dao.deleteLecture(session, no);
	}

	@Override
	public int updateLecture(Map<String, Object> params) {
		return dao.updateLecture(session, params);
	}
}
