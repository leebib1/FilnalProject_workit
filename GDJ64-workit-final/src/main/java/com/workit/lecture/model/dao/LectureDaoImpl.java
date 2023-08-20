package com.workit.lecture.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.workit.lecture.model.dto.Lecture;
import com.workit.member.model.vo.MemberVO;

@Repository
public class LectureDaoImpl implements LectureDao {

	@Override
	public List<Lecture> selectLectureAll(SqlSessionTemplate session, Map<String, Object> map) {
		int cPage=(int)map.get("cPage");
		int numPerpage=(int)map.get("numPerpage");
		RowBounds rb=new RowBounds((cPage-1)*numPerpage,numPerpage);
		return session.selectList("lecture.selectLectureAll",map,rb);
	}

	@Override
	public int selectLectureCount(SqlSessionTemplate session, Map<String, Object> map) {
		return session.selectOne("lecture.selectLectureCount",map);
	}

	@Override
	public List<MemberVO> selectTeacher(SqlSessionTemplate session) {
		return session.selectList("lecture.selectTeacher");
	}

	@Override
	public int insertLecture(SqlSessionTemplate session, Map<String, Object> params) {
		return session.insert("lecture.insertLecture",params);
	}

	@Override
	public Lecture selectLectureByNo(SqlSessionTemplate session, int no) {
		return session.selectOne("lecture.selectLectureByNo",no);
	}

	@Override
	public int updateStatus(SqlSessionTemplate session, Map<String, Object> map) {
		return session.update("lecture.updateStatus",map);
	}

	@Override
	public int deleteLecture(SqlSessionTemplate session, int no) {
		return session.delete("lecture.deleteLecture",no);
	}

	@Override
	public int updateLecture(SqlSessionTemplate session, Map<String, Object> params) {
		return session.update("lecture.updateLecture",params);
	}

	
	
}
