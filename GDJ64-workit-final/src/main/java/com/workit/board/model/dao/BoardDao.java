package com.workit.board.model.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;

import com.workit.board.model.dto.Board;
import com.workit.board.model.dto.BoardComment;
import com.workit.board.model.dto.Notice;
import com.workit.board.model.dto.NoticeComment;
import com.workit.board.model.dto.NoticeFile;
import com.workit.chatroom.model.dto.AttachedFile;

public interface BoardDao {

	//	공지사항
	List<Notice> selectNoticeAll(SqlSessionTemplate session, Map<String, Object> map);

	int selectNoticeCount(SqlSessionTemplate session, Map<String, Object> map);

	Notice selectNoticeByNo(SqlSessionTemplate session, int no);
	
	Notice selectPrevNotice(SqlSessionTemplate session, int no);

	Notice selectNextNotice(SqlSessionTemplate session, int no);

	int insertNoticeComment(SqlSessionTemplate session, Map<String, Object> map);

	List<NoticeComment> selectCommentList(SqlSessionTemplate session, int no);

	int deleteNoticeComment(SqlSessionTemplate session, int commentNo);

	int updateNoticeComment(SqlSessionTemplate session, Map<String, Object> map);

	int insertNotice(SqlSessionTemplate session, Map<String, Object> map);

	int updateNotice(SqlSessionTemplate session, Map<String, Object> map);

	int deleteNotice(SqlSessionTemplate session, int commentNo);

	int insertAttachedFile(SqlSessionTemplate session, Map<String, Object> fileMap);

	int insertNoticeFile(SqlSessionTemplate session);

	List<AttachedFile> selectFileListByNo(SqlSessionTemplate session, int no);

	AttachedFile selectFileById(SqlSessionTemplate session, int fileId);

	int updateViewCount(SqlSessionTemplate session, int no);

	//	부서게시판
	List<Board> selectBoardAll(SqlSessionTemplate session, Map<String, Object> map);

	int selectBoardCount(SqlSessionTemplate session, Map<String, Object> map);

	Board selectBoardByNo(SqlSessionTemplate session, int no);

	int insertBoardComment(SqlSessionTemplate session, Map<String, Object> map);

	List<BoardComment> selectBoardCommentList(SqlSessionTemplate session, int no);

	int deleteBoardComment(SqlSessionTemplate session, int commentNo);

	int updateBoardComment(SqlSessionTemplate session, Map<String, Object> map);

	int insertBoard(SqlSessionTemplate session, Map<String, Object> map);

	int updateBoard(SqlSessionTemplate session, Map<String, Object> map);

	int deleteBoard(SqlSessionTemplate session, int commentNo);

	int insertBoardFile(SqlSessionTemplate session);

	List<AttachedFile> selectFileListByBoardNo(SqlSessionTemplate session, int no);

	int updateBoardViewCount(SqlSessionTemplate session, int no);

	Board selectPrevBoard(SqlSessionTemplate session, int no);

	Board selectNextBoard(SqlSessionTemplate session, int no);

	AttachedFile selectAttachedFileById(SqlSessionTemplate session, int fileId);

	int deleteAttachedFile(SqlSessionTemplate session, int fileId);

	int deleteNoticeFile(SqlSessionTemplate session, int fileId);

	int deleteBoardFile(SqlSessionTemplate session, int fileId);

	int deleteNoticeFilesByNoticeNo(SqlSessionTemplate session, int no);

	List<NoticeFile> selectNoticeFileByNo(SqlSessionTemplate session, int no);

	int insertNoticeFile(SqlSessionTemplate session, Map<String, Object> noticeFileMap);

	int insertBoardFile(SqlSessionTemplate session, Map<String, Object> boardFileMap);

	List<Notice> selectNoticeTopFive(SqlSessionTemplate session);
	
	List<Board> selectBoardTopFive(SqlSessionTemplate session,Map<String, Object> param);
}
