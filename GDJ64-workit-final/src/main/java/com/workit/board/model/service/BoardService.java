package com.workit.board.model.service;

import java.util.List;
import java.util.Map;

import com.workit.board.model.dto.Board;
import com.workit.board.model.dto.BoardComment;
import com.workit.board.model.dto.Notice;
import com.workit.board.model.dto.NoticeComment;
import com.workit.board.model.dto.NoticeFile;
import com.workit.chatroom.model.dto.AttachedFile;

public interface BoardService {
	
	//공지사항 목록
	List<Notice> selectNoticeAll(Map<String, Object> params);
	int selectNoticeCount(Map<String, Object> params);
	//공지사항 화면 출력
	Notice selectNoticeByNo(int no);
	Notice selectPrevNotice(int no);
	Notice selectNextNotice(int no);

	List<NoticeComment> selectCommentList(int no);
	
	//공지사항 댓글
	int insertNoticeComment(Map<String, Object> map);
	int deleteNoticeComment(int commentNo);
	int updateNoticeComment(Map<String, Object> map);
	//공지사항 등록
	int insertNotice(Map<String, Object> map);
	int updateNotice(Map<String, Object> map);
	int deleteNotice(int commentNo);
	//첨부파일 등록
	int insertAttachedFile(Map<String, Object> fileMap);
	int insertNoticeFile();
	//첨부파일 조회
	List<AttachedFile> selectFileListByNo(int no);
	AttachedFile selectFileById(int fileId);
	//조회수 증가
	int updateViewCount(int no);

	//게시판 목록
	List<Board> selectBoardAll(Map<String, Object> params);
	int selectBoardCount(Map<String, Object> params);
	//게시판 화면 출력
	Board selectBoardByNo(int no);
	List<BoardComment> selectBoardCommentList(int no);
	Board selectPrevBoard(int no);
	Board selectNextBoard(int no);
	
	//게시판 댓글
	int insertBoardComment(Map<String, Object> map);
	int deleteBoardComment(int commentNo);
	int updateBoardComment(Map<String, Object> map);
	//게시판 등록
	int insertBoard(Map<String, Object> map);
	int updateBoard(Map<String, Object> map);
	int deleteBoard(int commentNo);
	//첨부파일 등록
	int insertBoardFile();
	int updateBoardViewCount(int no);
	List<AttachedFile> selectFileListByBoardNo(int no);
	//파일제거
	AttachedFile selectAttachedFileById(int fileId);
	int deleteAttachedFile(int fileId);
	int deleteNoticeFile(int fileId);
	int deleteBoardFile(int fileId);
	int deleteNoticeFilesByNoticeNo(int no);
	List<NoticeFile> selectNoticeFileByNo(int no);
	int insertNoticeFile(Map<String, Object> noticeFileMap);
	int insertBoardFile(Map<String, Object> boardFileMap);
	List<Notice> selectNoticeTopFive();
	List<Board> selectBoardTopFive(Map<String, Object> param);
}
