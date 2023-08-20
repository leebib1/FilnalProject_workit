package com.workit.lecture.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.google.gson.Gson;
import com.workit.common.Pagenation;
import com.workit.lecture.model.dto.Lecture;
import com.workit.lecture.model.service.LectureService;
import com.workit.member.model.vo.MemberVO;

@Controller
@RequestMapping("/lecture")
public class LectureController {

	private LectureService service;
	
	public LectureController(LectureService service) {
		this.service = service;
	}
	
	@GetMapping("/lectureList")
	public String selectLectureAll(Model model,@RequestParam(value="cPage",defaultValue="1") int cPage,
			@RequestParam(value="searchType", required=false) String searchType,
            @RequestParam(value="searchKeyword", required=false) String searchKeyword,
            HttpServletRequest request) {
		Map<String, Object> params = new HashMap<>();
		params.put("cPage", cPage);
		params.put("numPerpage", 5);
		if(searchType != null) {
		    params.put("searchType", searchType);
		}
		if(searchKeyword != null) {
		    params.put("searchKeyword", searchKeyword);
		}

		List<Lecture> lectureList = service.selectLectureAll(params);
	
		 int totalData=service.selectLectureCount(params);
		model.addAttribute("searchType", searchType);
		model.addAttribute("searchKeyword", searchKeyword);
		model.addAttribute("lectureList", lectureList);
		model.addAttribute("pageBar",Pagenation.getPage(cPage,5,totalData,request.getRequestURI()));
		
		return "/lecture/lectureList";
	}
	
	@GetMapping("/insertLecture")
	public String lectureForm(Model model) {
		model.addAttribute("teacherList", service.selectTeacher());
		return "/lecture/lectureForm";
	}
	
	@PostMapping("/insertLectureEnd")
	public String insertLectureEnd(Lecture l,@RequestParam String memberId, Model model) {
		Map<String, Object> params = new HashMap<>();
		params.put("l", l);
		params.put("memberId", memberId);
		System.out.println(params);
		if(service.insertLecture(params)>0) {
			model.addAttribute("msg","강의를 성공적으로 등록하였습니다.");
			model.addAttribute("url","/lecture/lectureList");			
		}else {
			model.addAttribute("msg","등록에 실패하였습니다.");
			model.addAttribute("url","/lecture/insertLecture");
		}
		return "/common/msg";
	}
	@GetMapping("/detail")
	public String detailView(Model model, @RequestParam int no) {
		model.addAttribute("lecture", service.selectLectureByNo(no));
		return "/lecture/lectureView";
	}
	@PostMapping("/updatStatus")
	public void updatStatus(@RequestParam String status,
			@RequestParam int lectureNo,HttpServletResponse response) throws IOException {
		String registrationStatus="";
		switch (status) {
		case "waiting": registrationStatus="대기중"; break;
		case "approved": registrationStatus="승인"; break;
		case "rejected": registrationStatus="반려"; break;
		}
		int result = service.updateStatus(Map.of("status", registrationStatus, "no", lectureNo));
		 Gson gson = new Gson();
		    String json = gson.toJson(result);
		    response.setContentType("application/json");
	        response.setCharacterEncoding("UTF-8");
	        response.getWriter().write(json);
	}
	@GetMapping("/updateLecture")
	public String updateForm(@RequestParam int no,Model model) {
		model.addAttribute("lecture",service.selectLectureByNo(no));
		model.addAttribute("teacherList", service.selectTeacher());
		return "/lecture/updateForm";
	}
	@PostMapping("deleteLecture")
	public void deleteLecture(@RequestParam int no,HttpServletResponse response) throws IOException {
		int result = service.deleteLecture(no);
		 Gson gson = new Gson();
		    String json = gson.toJson(result);
		    response.setContentType("application/json");
	        response.setCharacterEncoding("UTF-8");
	        response.getWriter().write(json);
	}
	@PostMapping("/updateLectureEnd")
	public String updateLectureEnd(@RequestParam int no,Lecture l,@RequestParam String memberId, Model model) {
		Map<String, Object> params = new HashMap<>();
		l.setLectureNo(no);
		params.put("l", l);
		params.put("memberId", memberId);
		System.out.println(params);
		if(service.updateLecture(params)>0) {
			model.addAttribute("msg","강의 정보를 성공적으로 수정하였습니다.");
			model.addAttribute("url","/lecture/lectureList");			
		}else {
			model.addAttribute("msg","수정에 실패하였습니다.");
			model.addAttribute("url","/lecture/insertLecture");
		}
		return "/common/msg";
	}
}
