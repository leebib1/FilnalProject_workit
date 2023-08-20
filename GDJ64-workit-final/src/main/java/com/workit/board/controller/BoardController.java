	package com.workit.board.controller;

import java.io.File;
import java.io.IOException;
import java.net.MalformedURLException;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.core.io.UrlResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.google.gson.Gson;
import com.workit.board.model.dto.Board;
import com.workit.board.model.dto.Notice;
import com.workit.board.model.dto.NoticeFile;
import com.workit.board.model.service.BoardService;
import com.workit.chatroom.model.dto.AttachedFile;
import com.workit.common.Pagenation;
import com.workit.member.model.vo.MemberVO;

@Controller
@RequestMapping("/board")
public class BoardController {
	private BoardService service;
	
	@Autowired
	public BoardController(BoardService service) {
		this.service = service;
	}
	//	공지사항
	@GetMapping("/noticeList")
	public String noticeList(Model model, 
	                         @RequestParam(value="cPage",defaultValue="1") int cPage,
	                         @RequestParam(value="type", required=false) String searchType,
	                         @RequestParam(value="keyword", required=false) String searchKeyword,
	                         HttpServletRequest request) {

	    Map<String, Object> params = new HashMap<>();
	    params.put("cPage", cPage);
	    params.put("numPerpage", 10);

	    if(searchType != null && !searchType.isEmpty() && 
	       searchKeyword != null && !searchKeyword.isEmpty()) {
	        params.put("searchType", searchType);
	        params.put("searchKeyword", searchKeyword);
	    }

	    List<Notice> noticeList = service.selectNoticeAll(params);
	    int totalData = service.selectNoticeCount(params);

	    model.addAttribute("searchType", searchType);
	    model.addAttribute("searchKeyword", searchKeyword);
	    model.addAttribute("noticeList", noticeList);
	    model.addAttribute("pageBar", Pagenation.getPage(cPage,10,totalData,request.getRequestURI()));
	    return "board/noticeList";
	}

	@GetMapping("/noticeView")
	public String noticeView(Model model, @RequestParam int no,HttpServletRequest request, HttpServletResponse response) {
		Cookie[] cookies = request.getCookies();
	    boolean isViewed = false;

	    if(cookies != null) {
	        for(Cookie cookie : cookies) {
	            if(cookie.getName().equals("noticeView"+no) && cookie.getValue().contains("|" + no + "|")) {
	                isViewed = true;
	                break;
	            }
	        }
	    }

	    if(!isViewed) {

	        service.updateViewCount(no);

	        Cookie viewCookie = new Cookie("noticeView"+no, "|" + no + "|");
	        viewCookie.setMaxAge(60*60*24); // 24시간 저장
	        response.addCookie(viewCookie);
	    }
		
		model.addAttribute("n", service.selectNoticeByNo(no));
		model.addAttribute("commentList", service.selectCommentList(no));
	   model.addAttribute("prevNotice", service.selectPrevNotice(no));
	    model.addAttribute("nextNotice", service.selectNextNotice(no));
		model.addAttribute("fileList", service.selectFileListByNo(no));
		return "board/noticeView";
	}
	
	@PostMapping("/noticeCommentAdd")
	@ResponseBody
	public String addNoticeComment(@RequestParam int noticeNo, @RequestParam String commentContent,
            @RequestParam(required = false) Integer refCommentNo, HttpSession session) {
		 Map<String, Object> map = new HashMap<>();
		String memberId=((MemberVO)session.getAttribute("loginMember")).getMemberId();
		map.put("memberId", memberId);
		map.put("noticeNo", noticeNo);
		map.put("commentContent", commentContent);
		map.put("refCommentNo", refCommentNo);
		//System.out.println(map);
	    service.insertNoticeComment(map);

	    return "success";
	}
	
	@PostMapping("/noticeCommentDelete")
	public void noticeCommentDelete(@RequestParam int commentNo, HttpServletResponse response) throws IOException {
	    Map<String, String> resultMap = new HashMap<>();
	    try {
	        service.deleteNoticeComment(commentNo);
	        resultMap.put("status", "success");
	    } catch (Exception e) {
	        resultMap.put("status", "error");
	    }
	    Gson gson = new Gson();
	    String json = gson.toJson(resultMap);
	    response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(json);
	
	}
	
	@PostMapping("/noticeCommentUpdate")
	public void noticeCommentUpdate(@RequestParam int commentNo, @RequestParam String commentContent,
		 HttpServletResponse response) throws IOException {
		 Map<String, Object> map = new HashMap<>();
		map.put("commentNo", commentNo);
		map.put("commentContent", commentContent);
	    
	    Map<String, String> resultMap = new HashMap<>();
	    try {
	    	service.updateNoticeComment(map);
	        resultMap.put("status", "success");
	    } catch (Exception e) {
	        resultMap.put("status", "error");
	    }
	    Gson gson = new Gson();
	    String json = gson.toJson(resultMap);
	    response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(json);
	}
	@PostMapping("/deleteNotice")
	public void deleteNotice(@RequestParam int noticeNo,HttpServletResponse response) throws IOException {
		int result = service.deleteNotice(noticeNo);
		Map<String, String> resultMap = new HashMap<>();
		if(result>0) {
			resultMap.put("status", "success");			
		}else {
			resultMap.put("status", "error");			
		}

	    Gson gson = new Gson();
	    String json = gson.toJson(resultMap);
	    response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(json);
	}
	@GetMapping("/insertNotice")
	public String insertNotice() {
		return "board/insertNotice";
	}
	@PostMapping("/insertNoticeEnd")
	public void insertNoticeEnd(@RequestParam String content, @RequestParam String title,
			@RequestParam(value = "file", required = false) MultipartFile[] files,
			HttpServletResponse response, HttpSession session, HttpServletRequest request) throws IOException {
		//System.out.println(files);
	    // 서버의 업로드 폴더 경로 설정
	    String saveDir = request.getServletContext().getRealPath("/resources/upload/notice");
	    
	    // 첨부파일들을 저장할 리스트
	    List<AttachedFile> fileList = new ArrayList<>();

	    if (files != null) {
	    // 첨부파일 각각에 대해
		    for (MultipartFile file : files) {
		        // 원본 파일명 추출
		        String oriFileName = file.getOriginalFilename();
		        // 파일 확장자 추출
		        String ext = oriFileName.substring(oriFileName.lastIndexOf("."));
		        
		        // 서버에 저장될 새 파일명 생성 (날짜_랜덤값 형식으로 중복 방지)
		        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd_HHmmssSSS");
		        int rndNum = (int)(Math.random()*1000);
		        String renamedFileName = sdf.format(new Date(System.currentTimeMillis())) + "_" + rndNum + ext;
		        
		        // 파일을 서버에 저장
		        try {
		            file.transferTo(new File(saveDir + "/" + renamedFileName));
		            AttachedFile attachedFile = new AttachedFile();
		            attachedFile.setOriginalFile(oriFileName);
		            attachedFile.setUploadFile(renamedFileName);
		            attachedFile.setUploadPath(saveDir);
		            fileList.add(attachedFile); // 리스트에 추가
		        } catch (IOException e) {
		            e.printStackTrace();
		        }
		    }
	    }

	    // 게시글 정보를 맵에 저장
	    Map<String, Object> map = new HashMap<>();
	    map.put("memberId", ((MemberVO)session.getAttribute("loginMember")).getMemberId());
	    map.put("noticeContent", content);
	    map.put("noticeTitle", title);
	    
	    int result = service.insertNotice(map);

	    if(result > 0 && !fileList.isEmpty()) {
	        for (AttachedFile attachedFile : fileList) {
	            Map<String, Object> fileMap = new HashMap<>();
	            fileMap.put("originalFile", attachedFile.getOriginalFile());
	            fileMap.put("uploadFile", attachedFile.getUploadFile());
	            fileMap.put("uploadPath", attachedFile.getUploadPath());
	            
	            int attachResult = service.insertAttachedFile(fileMap);
	            if(attachResult>0) service.insertNoticeFile();  // 첨부파일과 게시글의 관계 저장
	        }
	    }
	    
	    Map<String, String> resultMap = new HashMap<>();
	    if(result > 0) {
	        resultMap.put("status", "success");
	    } else {
	        resultMap.put("status", "error");
	    }
	    
	    Gson gson = new Gson();
	    String json = gson.toJson(resultMap);
	    response.setContentType("application/json");
	    response.setCharacterEncoding("UTF-8");
	    response.getWriter().write(json);
	}
	
	@GetMapping("/updateNotice")
	public String updateNotice(@RequestParam int no,Model model) {
		model.addAttribute("notice", service.selectNoticeByNo(no));
		model.addAttribute("fileList", service.selectFileListByNo(no));
		return "board/updateNotice";
	}
	
	@PostMapping("/updateNoticeEnd")
	public void updateNoticeEnd(@RequestParam String content, @RequestParam String title,
	        @RequestParam(value = "files", required = false) MultipartFile[] files,// + 추가된 파일
	        @RequestParam int no, HttpServletResponse response, HttpSession session,
	        HttpServletRequest request) throws IOException {

	    // 서버의 업로드 폴더 경로 설정
	    String saveDir = request.getServletContext().getRealPath("/resources/upload/notice");

	    // 기존의 공지사항 정보 업데이트
	    Map<String, Object> map = new HashMap<>();
	    map.put("noticeNo", no);
	    map.put("noticeContent", content);
	    map.put("noticeTitle", title);

	    int result = service.updateNotice(map);

	    if (result > 0) {
	        // 새로운 첨부파일 처리
	        if (files != null) {
	        	System.out.println("새로 저장될 첨부파일"+files);
	            List<AttachedFile> fileList = new ArrayList<>();

	            for (MultipartFile file : files) {
	                // 원본 파일명 추출
	                String oriFileName = file.getOriginalFilename();
	                // 파일 확장자 추출
	                String ext = oriFileName.substring(oriFileName.lastIndexOf("."));

	                // 서버에 저장될 새 파일명 생성 (날짜_랜덤값 형식으로 중복 방지)
	                SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd_HHmmssSSS");
	                int rndNum = (int)(Math.random()*1000);
	                String renamedFileName = sdf.format(new Date(System.currentTimeMillis())) + "_" + rndNum + ext;

	                // 파일을 서버에 저장
	                try {
	                    file.transferTo(new File(saveDir + "/" + renamedFileName));
	                    AttachedFile attachedFile = new AttachedFile();
	                    attachedFile.setOriginalFile(oriFileName);
	                    attachedFile.setUploadFile(renamedFileName);
	                    attachedFile.setUploadPath(saveDir);
	                    fileList.add(attachedFile); // 리스트에 추가
	                } catch (IOException e) {
	                    e.printStackTrace();
	                }
	            }

	            // 새로운 첨부파일 정보를 데이터베이스에 저장
	            for (AttachedFile attachedFile : fileList) {
	                Map<String, Object> fileMap = new HashMap<>();
	                fileMap.put("originalFile", attachedFile.getOriginalFile());
	                fileMap.put("uploadFile", attachedFile.getUploadFile());
	                fileMap.put("uploadPath", attachedFile.getUploadPath());

	                int attachResult = service.insertAttachedFile(fileMap);
	                if (attachResult > 0) {
	                    Map<String, Object> noticeFileMap = new HashMap<>();
	                    noticeFileMap.put("noticeNo", no);
	                    service.insertNoticeFile(noticeFileMap); // 첨부파일과 공지사항의 관계 저장
	                }
	            }
	        }

	        // 결과 반환
	        Map<String, String> resultMap = new HashMap<>();
	        resultMap.put("status", "success");

	        Gson gson = new Gson();
	        String json = gson.toJson(resultMap);
	        response.setContentType("application/json");
	        response.setCharacterEncoding("UTF-8");
	        response.getWriter().write(json);
	    }
	}


	
	@PostMapping("/removeNoticeFile")
	@ResponseBody
	public Map<String, String> removeNoticeFile(@RequestParam int fileId) {
	    Map<String, String> resultMap = new HashMap<>();
	    
	    // 데이터베이스에서 해당 파일 정보 가져오기
	    AttachedFile attachedFile = service.selectAttachedFileById(fileId);
	    System.out.println(attachedFile);
	    if(attachedFile != null) {
	        String filePath = attachedFile.getUploadPath() + "/" + attachedFile.getUploadFile();
	        File file = new File(filePath);
	        System.out.println(filePath);
	        // 파일이 존재하면 삭제 시도
	        if(file.exists()) {
	            if (file.delete()) {
	                // 파일 삭제 성공
	            	int result = service.deleteNoticeFile(fileId);
	                if(result > 0) {
	                	result = service.deleteAttachedFile(fileId);
	                    if(result > 0) {
	                        resultMap.put("status", "success");
	                    } else {
	                        resultMap.put("status", "error");
	                    }
	                } else {
	                    resultMap.put("status", "error");
	                }
	            } else {
	                // 파일 삭제 실패
	                resultMap.put("status", "error");
	            }
	        } else {
	            // 파일이 존재하지 않음
	            resultMap.put("status", "notfound");
	        }
	    } else {
	        resultMap.put("status", "notfound");
	    }

	    return resultMap;
	}

	
	@PostMapping("/removeBoardFile")
	@ResponseBody
	public Map<String, String> removeBoardFile(@RequestParam int fileId) {
		 Map<String, String> resultMap = new HashMap<>();
		    
		    // 데이터베이스에서 해당 파일 정보 가져오기
		    AttachedFile attachedFile = service.selectAttachedFileById(fileId);
		    System.out.println(attachedFile);
		    if(attachedFile != null) {
		        String filePath = attachedFile.getUploadPath() + "/" + attachedFile.getUploadFile();
		        File file = new File(filePath);
		        System.out.println(filePath);
		        // 파일이 존재하면 삭제 시도
		        if(file.exists()) {
		            if (file.delete()) {
		                // 파일 삭제 성공
		            	int result = service.deleteBoardFile(fileId);
		                if(result > 0) {
		                	result = service.deleteAttachedFile(fileId);
		                    if(result > 0) {
		                        resultMap.put("status", "success");
		                    } else {
		                        resultMap.put("status", "error");
		                    }
		                } else {
		                    resultMap.put("status", "error");
		                }
		            } else {
		                // 파일 삭제 실패
		                resultMap.put("status", "error");
		            }
		        } else {
		            // 파일이 존재하지 않음
		            resultMap.put("status", "notfound");
		        }
		    } else {
		        resultMap.put("status", "notfound");
		    }

		    return resultMap;
	}


	@GetMapping("/downloadFile")
	public ResponseEntity<Resource> downloadFile(@RequestParam int fileId) throws MalformedURLException {
		AttachedFile file = service.selectFileById(fileId);
		System.out.println(file);
		// 파일의 전체 경로 생성
		Path filePath = Paths.get(file.getUploadPath() + "/" + file.getUploadFile()).normalize();

	    Resource resource = new UrlResource(filePath.toUri());

	    if (!resource.exists()) {
	        throw new RuntimeException("File not found: " + file.getOriginalFile());
	    }

	    return ResponseEntity.ok()
	            .contentType(MediaType.parseMediaType("application/octet-stream"))
	            .header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\"" + resource.getFilename() + "\"")
	            .body(resource);
	}
	
	
	
	//	부서 게시판
	@GetMapping("/boardList")
	public String boardList(Model model, 
	                         @RequestParam(value="cPage",defaultValue="1") int cPage,
	                         @RequestParam(value="type", required=false) String searchType,
	                         @RequestParam(value="keyword", required=false) String searchKeyword,
	                         HttpSession session, HttpServletRequest request) {
		String deptCode = ((MemberVO)session.getAttribute("loginMember")).getDept().getDeptCode();
	    Map<String, Object> params = new HashMap<>();
	    params.put("deptCode", deptCode);
	    params.put("cPage", cPage);
	    params.put("numPerpage", 10);

	    if(searchType != null && !searchType.isEmpty() && 
	       searchKeyword != null && !searchKeyword.isEmpty()) {
	        params.put("searchType", searchType);
	        params.put("searchKeyword", searchKeyword);
	    }

	    List<Board> boardList = service.selectBoardAll(params);
	    int totalData = service.selectBoardCount(params);

	    model.addAttribute("searchType", searchType);
	    model.addAttribute("searchKeyword", searchKeyword);
	    model.addAttribute("boardList", boardList);
	    model.addAttribute("pageBar", Pagenation.getPage(cPage,10,totalData,request.getRequestURI()));
	    return "board/boardList";
	}

	@GetMapping("/boardView")
	public String boardView(Model model, @RequestParam int no,
			HttpServletRequest request, HttpServletResponse response) {
		Cookie[] cookies = request.getCookies();
	    boolean isViewed = false;

	    if(cookies != null) {
	        for(Cookie cookie : cookies) {
	            if(cookie.getName().equals("boardView"+no) && cookie.getValue().contains("|" + no + "|")) {
	                isViewed = true;
	                break;
	            }
	        }
	    }

	    if(!isViewed) {
	        service.updateBoardViewCount(no);

	        Cookie viewCookie = new Cookie("boardView"+no, "|" + no + "|");
	        viewCookie.setMaxAge(60*60*24); // 24시간 저장
	        response.addCookie(viewCookie);
	    }
		
		model.addAttribute("b", service.selectBoardByNo(no));
		model.addAttribute("commentList", service.selectBoardCommentList(no));
		model.addAttribute("prevBoard", service.selectPrevBoard(no));
	    model.addAttribute("nextBoard", service.selectNextBoard(no));
		model.addAttribute("fileList", service.selectFileListByBoardNo(no));
		return "board/boardView";
	}
	
	@PostMapping("/boardCommentAdd")
	@ResponseBody
	public String addBoardComment(@RequestParam int boardNo, @RequestParam String commentContent,
            @RequestParam(required = false) Integer refCommentNo, HttpSession session) {
		 Map<String, Object> map = new HashMap<>();
		String memberId=((MemberVO)session.getAttribute("loginMember")).getMemberId();
		map.put("memberId", memberId);
		map.put("boardNo", boardNo);
		map.put("commentContent", commentContent);
		map.put("refCommentNo", refCommentNo);
	    service.insertBoardComment(map);

	    return "success";
	}
	
	@PostMapping("/boardCommentDelete")
	public void boardCommentDelete(@RequestParam int commentNo, HttpServletResponse response) throws IOException {
	    Map<String, String> resultMap = new HashMap<>();
	    try {
	        service.deleteBoardComment(commentNo);
	        resultMap.put("status", "success");
	    } catch (Exception e) {
	        resultMap.put("status", "error");
	    }
	    Gson gson = new Gson();
	    String json = gson.toJson(resultMap);
	    response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(json);
	
	}
	
	@PostMapping("/boardCommentUpdate")
	public void boardCommentUpdate(@RequestParam int commentNo, @RequestParam String commentContent,
		 HttpServletResponse response) throws IOException {
		 Map<String, Object> map = new HashMap<>();
		map.put("commentNo", commentNo);
		map.put("commentContent", commentContent);
	    
	    Map<String, String> resultMap = new HashMap<>();
	    try {
	    	service.updateBoardComment(map);
	        resultMap.put("status", "success");
	    } catch (Exception e) {
	        resultMap.put("status", "error");
	    }
	    Gson gson = new Gson();
	    String json = gson.toJson(resultMap);
	    response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(json);
	}
	@PostMapping("/deleteBoard")
	public void deleteBoard(@RequestParam int boardNo,HttpServletResponse response) throws IOException {
		int result = service.deleteBoard(boardNo);
		Map<String, String> resultMap = new HashMap<>();
		if(result>0) {
			resultMap.put("status", "success");			
		}else {
			resultMap.put("status", "error");			
		}

	    Gson gson = new Gson();
	    String json = gson.toJson(resultMap);
	    response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(json);
	}
	@GetMapping("/insertBoard")
	public String insertBoard() {
		return "board/insertBoard";
	}
	@PostMapping("/insertBoardEnd")
	public void insertBoardEnd(@RequestParam String content, @RequestParam String title,
			@RequestParam(value = "file", required = false) MultipartFile[] files,
			HttpServletResponse response, HttpSession session, HttpServletRequest request) throws IOException {
	    String saveDir = request.getServletContext().getRealPath("/resources/upload/board");
	    List<AttachedFile> fileList = new ArrayList<>();
	    if (files != null) {
		    for (MultipartFile file : files) {
		        String oriFileName = file.getOriginalFilename();
		        String ext = oriFileName.substring(oriFileName.lastIndexOf("."));
		        
		        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd_HHmmssSSS");
		        int rndNum = (int)(Math.random()*1000);
		        String renamedFileName = sdf.format(new Date(System.currentTimeMillis())) + "_" + rndNum + ext;
		        
		        try {
		            file.transferTo(new File(saveDir + "/" + renamedFileName));
		            AttachedFile attachedFile = new AttachedFile();
		            attachedFile.setOriginalFile(oriFileName);
		            attachedFile.setUploadFile(renamedFileName);
		            attachedFile.setUploadPath(saveDir);
		            fileList.add(attachedFile);
		        } catch (IOException e) {
		            e.printStackTrace();
		        }
		    }
	    }

	    Map<String, Object> map = new HashMap<>();
	    map.put("memberId", ((MemberVO)session.getAttribute("loginMember")).getMemberId());
	    map.put("boardContent", content);
	    map.put("boardTitle", title);
	    
	    int result = service.insertBoard(map);

	    if(result > 0 && !fileList.isEmpty()) {
	        for (AttachedFile attachedFile : fileList) {
	            Map<String, Object> fileMap = new HashMap<>();
	            fileMap.put("originalFile", attachedFile.getOriginalFile());
	            fileMap.put("uploadFile", attachedFile.getUploadFile());
	            fileMap.put("uploadPath", attachedFile.getUploadPath());
	            
	            int attachResult = service.insertAttachedFile(fileMap);
	            if(attachResult>0) service.insertBoardFile();  // 첨부파일과 게시글의 관계 저장
	        }
	    }
	    
	    Map<String, String> resultMap = new HashMap<>();
	    if(result > 0) {
	        resultMap.put("status", "success");
	    } else {
	        resultMap.put("status", "error");
	    }
	    
	    Gson gson = new Gson();
	    String json = gson.toJson(resultMap);
	    response.setContentType("application/json");
	    response.setCharacterEncoding("UTF-8");
	    response.getWriter().write(json);
	}
	
	@GetMapping("/updateBoard")
	public String updateBoard(@RequestParam int no,Model model) {
		model.addAttribute("board", service.selectBoardByNo(no));
		model.addAttribute("fileList", service.selectFileListByBoardNo(no));
		return "board/updateBoard";
	}
	@PostMapping("/updateBoardEnd")
	public void updateBoardEnd(@RequestParam String content, @RequestParam String title,
	        @RequestParam(value = "files", required = false) MultipartFile[] files,// + 추가된 파일
	        @RequestParam int no, HttpServletResponse response, HttpSession session, HttpServletRequest request) throws IOException {
		// 서버의 업로드 폴더 경로 설정
	    String saveDir = request.getServletContext().getRealPath("/resources/upload/board");
		
		Map<String, Object> map = new HashMap<>();
		map.put("boardNo", no);
		map.put("boardContent", content);
		map.put("boardTitle", title);
		int result=service.updateBoard(map);
		
		
		if (result > 0) {
	        // 새로운 첨부파일 처리
	        if (files != null) {
	        	System.out.println("새로 저장될 첨부파일"+files);
	            List<AttachedFile> fileList = new ArrayList<>();

	            for (MultipartFile file : files) {
	                // 원본 파일명 추출
	                String oriFileName = file.getOriginalFilename();
	                // 파일 확장자 추출
	                String ext = oriFileName.substring(oriFileName.lastIndexOf("."));

	                // 서버에 저장될 새 파일명 생성 (날짜_랜덤값 형식으로 중복 방지)
	                SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd_HHmmssSSS");
	                int rndNum = (int)(Math.random()*1000);
	                String renamedFileName = sdf.format(new Date(System.currentTimeMillis())) + "_" + rndNum + ext;

	                // 파일을 서버에 저장
	                try {
	                    file.transferTo(new File(saveDir + "/" + renamedFileName));
	                    AttachedFile attachedFile = new AttachedFile();
	                    attachedFile.setOriginalFile(oriFileName);
	                    attachedFile.setUploadFile(renamedFileName);
	                    attachedFile.setUploadPath(saveDir);
	                    fileList.add(attachedFile); // 리스트에 추가
	                } catch (IOException e) {
	                    e.printStackTrace();
	                }
	            }

	            // 새로운 첨부파일 정보를 데이터베이스에 저장
	            for (AttachedFile attachedFile : fileList) {
	                Map<String, Object> fileMap = new HashMap<>();
	                fileMap.put("originalFile", attachedFile.getOriginalFile());
	                fileMap.put("uploadFile", attachedFile.getUploadFile());
	                fileMap.put("uploadPath", attachedFile.getUploadPath());

	                int attachResult = service.insertAttachedFile(fileMap);
	                if (attachResult > 0) {
	                    Map<String, Object> boardFileMap = new HashMap<>();
	                    boardFileMap.put("boardNo", no);
	                    service.insertBoardFile(boardFileMap); // 첨부파일과 공지사항의 관계 저장
	                }
	            }
	        }

	        // 결과 반환
	        Map<String, String> resultMap = new HashMap<>();
	        resultMap.put("status", "success");

	        Gson gson = new Gson();
	        String json = gson.toJson(resultMap);
	        response.setContentType("application/json");
	        response.setCharacterEncoding("UTF-8");
	        response.getWriter().write(json);
	    }
	}
	
}
