package com.workit.board.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.workit.board.model.dto.Board;
import com.workit.board.model.dto.BoardComment;
import com.workit.board.model.dto.Notice;
import com.workit.board.model.dto.NoticeComment;
import com.workit.board.model.dto.NoticeFile;
import com.workit.chatroom.model.dto.AttachedFile;

@Repository
public class BoardDaoImpl implements BoardDao {

	//	공지사항
	@Override
	public List<Notice> selectNoticeAll(SqlSessionTemplate session, Map<String, Object> map) {
		int cPage=(int)map.get("cPage");
		int numPerpage=(int)map.get("numPerpage");
		RowBounds rb=new RowBounds((cPage-1)*numPerpage,numPerpage);
		return session.selectList("board.selectNoticeAll",map,rb);
	}

	@Override
	public int selectNoticeCount(SqlSessionTemplate session, Map<String, Object> map) {
		return session.selectOne("board.selectNoticeCount",map);
	}

	@Override
	public Notice selectNoticeByNo(SqlSessionTemplate session, int no) {
		return session.selectOne("board.selectNoticeByNo",no);
	}
	
	@Override
	public Notice selectPrevNotice(SqlSessionTemplate session, int no) {
		return session.selectOne("board.selectPrevNotice",no);
	}

	@Override
	public Notice selectNextNotice(SqlSessionTemplate session, int no) {
		return session.selectOne("board.selectNextNotice",no);
	}

	@Override
	public int insertNoticeComment(SqlSessionTemplate session, Map<String, Object> map) {
		return session.insert("board.insertNoticeComment",map);
	}

	@Override
	public List<NoticeComment> selectCommentList(SqlSessionTemplate session, int no) {
		return session.selectList("board.selectCommentList",no);
	}

	@Override
	public int deleteNoticeComment(SqlSessionTemplate session, int commentNo) {
		return session.delete("board.deleteNoticeComment",commentNo);
	}

	@Override
	public int updateNoticeComment(SqlSessionTemplate session, Map<String, Object> map) {
		return session.update("board.updateNoticeComment",map);
	}

	@Override
	public int insertNotice(SqlSessionTemplate session, Map<String, Object> map) {
		return session.insert("insertNotice",map);
	}

	@Override
	public int updateNotice(SqlSessionTemplate session, Map<String, Object> map) {
		return session.update("board.updateNotice",map);
	}

	@Override
	public int deleteNotice(SqlSessionTemplate session, int commentNo) {
		return session.delete("board.deleteNotice",commentNo);
	}

	@Override
	public int insertAttachedFile(SqlSessionTemplate session, Map<String, Object> fileMap) {
		return session.insert("board.insertAttachedFile",fileMap);
	}

	@Override
	public int insertNoticeFile(SqlSessionTemplate session) {
		return session.insert("board.insertNoticeFile");
	}

	@Override
	public List<AttachedFile> selectFileListByNo(SqlSessionTemplate session, int no) {
		return session.selectList("board.selectFileListByNo",no);
	}

	@Override
	public AttachedFile selectFileById(SqlSessionTemplate session, int fileId) {
		return session.selectOne("board.selectFileById",fileId);
	}

	@Override
	public int updateViewCount(SqlSessionTemplate session, int no) {
		return session.update("board.updateViewCount",no);
	}

	//	부서 게시판
	@Override
	public List<Board> selectBoardAll(SqlSessionTemplate session, Map<String, Object> map) {
		int cPage=(int)map.get("cPage");
		int numPerpage=(int)map.get("numPerpage");
		RowBounds rb=new RowBounds((cPage-1)*numPerpage,numPerpage);
		return session.selectList("board.selectBoardAll",map,rb);
	}

	@Override
	public int selectBoardCount(SqlSessionTemplate session, Map<String, Object> map) {
		return session.selectOne("board.selectBoardCount",map);
	}

	@Override
	public Board selectBoardByNo(SqlSessionTemplate session, int no) {
		return	session.selectOne("board.selectBoardByNo",no);
	}

	@Override
	public int insertBoardComment(SqlSessionTemplate session, Map<String, Object> map) {
		return session.insert("board.insertBoardComment",map);
	}

	@Override
	public List<BoardComment> selectBoardCommentList(SqlSessionTemplate session, int no) {
		return session.selectList("board.selectBoardCommentList",no);
	}

	@Override
	public int deleteBoardComment(SqlSessionTemplate session, int commentNo) {
		return session.delete("board.deleteBoardComment",commentNo);
	}

	@Override
	public int updateBoardComment(SqlSessionTemplate session, Map<String, Object> map) {
		return session.update("board.updateBoardComment",map);
	}

	@Override
	public int insertBoard(SqlSessionTemplate session, Map<String, Object> map) {
		return session.insert("board.insertBoard",map);
	}

	@Override
	public int updateBoard(SqlSessionTemplate session, Map<String, Object> map) {
		return session.update("board.updateBoard",map);
	}

	@Override
	public int deleteBoard(SqlSessionTemplate session, int commentNo) {
		return session.delete("board.deleteBoard",commentNo);
	}

	@Override
	public int insertBoardFile(SqlSessionTemplate session) {
		return session.insert("board.insertBoardFile");
	}

	@Override
	public List<AttachedFile> selectFileListByBoardNo(SqlSessionTemplate session, int no) {
		return session.selectList("board.selectFileListByBoardNo",no);
	}

	@Override
	public int updateBoardViewCount(SqlSessionTemplate session, int no) {
		return session.update("board.updateBoardViewCount",no);
	}

	@Override
	public Board selectPrevBoard(SqlSessionTemplate session, int no) {
		return session.selectOne("board.selectPrevBoard",no);
	}

	@Override
	public Board selectNextBoard(SqlSessionTemplate session, int no) {
		return session.selectOne("board.selectNextBoard",no);
	}

	@Override
	public AttachedFile selectAttachedFileById(SqlSessionTemplate session, int fileId) {
		return session.selectOne("board.selectAttachedFileById",fileId);
	}

	@Override
	public int deleteAttachedFile(SqlSessionTemplate session, int fileId) {
		return session.delete("board.deleteAttachedFile",fileId);
	}

	@Override
	public int deleteNoticeFile(SqlSessionTemplate session, int fileId) {
		return session.delete("board.deleteNoticeFile",fileId);
	}

	@Override
	public int deleteBoardFile(SqlSessionTemplate session, int fileId) {
		return session.delete("board.deleteBoardFile",fileId);
	}

	@Override
	public int deleteNoticeFilesByNoticeNo(SqlSessionTemplate session, int no) {
		return session.delete("board.deleteNoticeFilesByNoticeNo",no);
	}

	@Override
	public List<NoticeFile> selectNoticeFileByNo(SqlSessionTemplate session, int no) {
		return session.selectList("board.selectNoticeFileByNo",no);
	}

	@Override
	public int insertNoticeFile(SqlSessionTemplate session, Map<String, Object> noticeFileMap) {
		return session.insert("board.updateNoticeFile",noticeFileMap);
	}

	@Override
	public int insertBoardFile(SqlSessionTemplate session, Map<String, Object> boardFileMap) {
		return session.insert("board.insertBoardFile",boardFileMap);
	}

	@Override
	public List<Notice> selectNoticeTopFive(SqlSessionTemplate session) {
		return session.selectList("board.selectNoticeTopFive");
	}

	@Override
	public List<Board> selectBoardTopFive(SqlSessionTemplate session,Map<String, Object> param) {
		return session.selectList("board.selectBoardTopFive",param);
	}
	
	
}
