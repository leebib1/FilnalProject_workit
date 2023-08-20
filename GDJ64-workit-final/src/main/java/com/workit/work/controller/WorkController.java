package com.workit.work.controller;

import java.io.IOException;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.TimeZone;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;
import com.workit.common.Pagenation;
import com.workit.member.model.dto.Member;
import com.workit.member.model.vo.MemberVO;
import com.workit.member.service.MemberService;
import com.workit.work.model.dto.AnnualLeaveCount;
import com.workit.work.model.dto.Work;
import com.workit.work.model.dto.WorkChange;
import com.workit.work.model.service.WorkService;

@Controller
@RequestMapping("/work")
public class WorkController {

	private WorkService service;
	
	private MemberService memberService;

	@Autowired
	public WorkController(WorkService service,MemberService memberService) {
		this.service = service;
		this.memberService = memberService;
	}

	@GetMapping("/workTime")
	public String monthWorkTime(
			@RequestParam(required = false) Integer currentYear, 
            @RequestParam(required = false) Integer currentMonth,
            HttpSession session,
			HttpServletRequest request, HttpServletResponse response, Model model) throws IOException{
		String memberId=((MemberVO)session.getAttribute("loginMember")).getMemberId();
		 // 오늘의 날짜 정보를 가져옴
	    LocalDate today = LocalDate.now();//2023-08-07
	    //System.out.println("오늘 날짜"+today.toString());
	    
	    Map<String, Object> paramMap = new HashMap<>();
        paramMap.put("memberId", memberId);
        paramMap.put("workDate", today.toString());
	    // 오늘의 근태 정보 조회
	    Work todayWork = service.selectWorkByDateAndMemberId(paramMap);
	    //System.out.println(paramMap);
	    System.out.println(todayWork);
	    model.addAttribute("todayWork", todayWork); // 오늘의 근태 정보를 모델에 추가
		
		 if (currentYear == null || currentMonth == null) {
	            Calendar cal = Calendar.getInstance();
	            currentYear = cal.get(Calendar.YEAR);
	            currentMonth = cal.get(Calendar.MONTH) + 1;
	            // 년월 정보를 Map에 담기
	            paramMap.put("currentYear", currentYear);//2023
	            paramMap.put("currentMonth", currentMonth);//8
	            //System.out.println(paramMap);
	            
	            List<Work> workList = service.getMonthWorkTime(paramMap);
	            int lateCount = service.lateCount(paramMap);
	            int earlyLeaveCount = service.earlyLeaveCount(paramMap);
	            AnnualLeaveCount usedLeaveCount = service.usedLeaveCount(memberId);
	            //System.out.println(workList);
	            // 뷰에 데이터 전달
	            model.addAttribute("workList", workList);
	            model.addAttribute("lateCount",lateCount);
	            model.addAttribute("earlyLeaveCount", earlyLeaveCount);
	            model.addAttribute("usedLeaveCount", usedLeaveCount);
	            return "/work/workBoard";
	        }else {
	            paramMap.put("currentYear", currentYear);
	            paramMap.put("currentMonth", currentMonth);
	            List<Work> workList = service.getMonthWorkTime(paramMap);
	            int lateCount = service.lateCount(paramMap);
	            int earlyLeaveCount = service.earlyLeaveCount(paramMap);
	            AnnualLeaveCount usedLeaveCount = service.usedLeaveCount(memberId);

	            Map<String, Object> data = new HashMap<>();
	            data.put("workList", workList);
	            data.put("lateCount", lateCount);
	            data.put("earlyLeaveCount", earlyLeaveCount);
	            data.put("usedLeaveCount", usedLeaveCount);

	            //Gson gson = new Gson();
	            // String json = gson.toJson(data);
	            ObjectMapper mapper = new ObjectMapper();
		   	    String json=mapper.writeValueAsString(data);
	            response.setContentType("application/json");
	            response.setCharacterEncoding("UTF-8");
	            response.getWriter().write(json);
	        }
		 return null;
	}
	
	@GetMapping("/workTime2")
	@ResponseBody
	public Map<String,Object> monthWorkTime2(
			@RequestParam(required = false) Integer currentYear, 
            @RequestParam(required = false) Integer currentMonth,
            HttpSession session,
			HttpServletRequest request, HttpServletResponse response, Model model) throws IOException{
		String memberId=((MemberVO)session.getAttribute("loginMember")).getMemberId();
		 // 오늘의 날짜 정보를 가져옴
	    LocalDate today = LocalDate.now();//2023-08-07

	    Map<String, Object> paramMap = new HashMap<>();
        paramMap.put("memberId", memberId);
        paramMap.put("workDate", today.toString());
	    // 오늘의 근태 정보 조회
	    Work todayWork = service.selectWorkByDateAndMemberId(paramMap);
	    //System.out.println(paramMap);
	    //System.out.println(todayWork);
	    model.addAttribute("todayWork", todayWork); // 오늘의 근태 정보를 모델에 추가
		
	            paramMap.put("currentYear", currentYear);
	            paramMap.put("currentMonth", currentMonth);
	            List<Work> workList = service.getMonthWorkTime(paramMap);
	            int lateCount = service.lateCount(paramMap);
	            int earlyLeaveCount = service.earlyLeaveCount(paramMap);

	            Map<String, Object> data = new HashMap<>();
	            data.put("workList", workList);
	            data.put("lateCount", lateCount);
	            data.put("earlyLeaveCount", earlyLeaveCount);

	            return data;
	        

	}

	 @PostMapping("/workStart")
	 @ResponseBody
	    public Map<String, String> startWork(@RequestParam("workStartTime") String workStartTime,HttpSession session) {
	        Map<String, String> result = new HashMap<>();
	        String memberId=((MemberVO)session.getAttribute("loginMember")).getMemberId();
	        Member m = service.selectMemberById(memberId);
	        // 임시 사용자 ID
	        //String memberId = "user01";
	        Timestamp currentTimestamp = null;
	        String workStatus = null;
	        try {
	        	SimpleDateFormat utcFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
	            utcFormat.setTimeZone(TimeZone.getTimeZone("UTC")); // UTC 시간대로 설정
	            java.util.Date parsedDate = utcFormat.parse(workStartTime);  // UTC 기준 java.util.Date로 변경

	            SimpleDateFormat seoulFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS");
	            seoulFormat.setTimeZone(TimeZone.getTimeZone("Asia/Seoul")); // 서울 시간대로 설정
	            String seoulTime = seoulFormat.format(parsedDate); // 서울 시간대 기준 문자열로 변환
	            parsedDate = seoulFormat.parse(seoulTime); // 다시 Date 객체로 변환

	            currentTimestamp = new Timestamp(parsedDate.getTime());
	            // 시간을 24시간 형식으로 구해서 9시 이후인지 체크
	            LocalDateTime currentTime = currentTimestamp.toLocalDateTime();
	            int hour = currentTime.getHour();
	            workStatus = (hour >= 9) ? "지각" : "정상출근";
	        } catch (ParseException e) {
	            e.printStackTrace();
	            result.put("status", "error");
	            result.put("msg", "잘못된 시간 형식입니다.");
	            return result;
	        }
	        
	        Work w = Work.builder()
	                        .member(m)
	                        .workStart(currentTimestamp)
	                        .workStatus(workStatus)
	                        .build();
	        
	        if(service.insertStartWorkTime(w) > 0) {
	            result.put("status", "success");
	            result.put("msg", "출근 시간이 저장되었습니다.");
	        } else {
	            result.put("status", "error");
	            result.put("msg", "저장 중 오류가 발생했습니다.");
	        }

	        return result;
	    }
	 
	 @PostMapping("/workEnd")
	 @ResponseBody
	 public Map<String, String> endWork(@RequestParam("workEndTime") String workEndTime,HttpSession session) {
	      Map<String, String> result = new HashMap<>();
	      String memberId=((MemberVO)session.getAttribute("loginMember")).getMemberId();

	      Timestamp currentTimestamp = null;
	      String workStatus = "지각";
	      try {
	          SimpleDateFormat utcFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
	          utcFormat.setTimeZone(TimeZone.getTimeZone("UTC")); // UTC 시간대로 설정
	          java.util.Date parsedDate = utcFormat.parse(workEndTime);  // UTC 기준 java.util.Date로 변경

	          currentTimestamp = new Timestamp(parsedDate.getTime());
	          // 시간을 24시간 형식으로 구해서 18시 이전인지 체크
	          LocalDateTime currentTime = currentTimestamp.toLocalDateTime();
	          int hour = currentTime.getHour();
	          
	          // 해당 날짜에 대한 근무데이터
	          LocalDate today = LocalDate.now();//2023-08-07
	          Map<String, Object> paramMap = new HashMap<>();
	          paramMap.put("memberId", memberId);
	          paramMap.put("workDate", today.toString());
	          Work todayWork = service.selectWorkByDateAndMemberId(paramMap);
	          System.out.println(todayWork);

	          // 작업 상태가 지각이 아닌 경우에만 상태를 재설정
	          if (todayWork.getWorkStatus().equals("정상출근")) {
	              workStatus = (hour < 18) ? "조퇴" : "정상출근";
	          } else {
	              workStatus = todayWork.getWorkStatus();
	          }

	          Work w = Work.builder()
	        		  		.member(service.selectMemberById(memberId))
	                       .workEnd(currentTimestamp)
	                       .workStatus(workStatus)
	                       .build();

	          if(service.updateEndWorkTime(w) > 0) {
	              result.put("status", "success");
	              result.put("msg", "퇴근 시간이 저장되었습니다.");
	          } else {
	              result.put("status", "error");
	              result.put("msg", "저장 중 오류가 발생했습니다.");
	          }
	      } catch (ParseException e) {
	          e.printStackTrace();
	          result.put("status", "error");
	          result.put("msg", "잘못된 시간 형식입니다.");
	      }
	      return result;
	 }

	 @GetMapping("/checkTodayWork")
	 @ResponseBody
	 public Map<String, Boolean> checkTodayWork(@RequestParam("date") String workDate,HttpSession session) {

		 String memberId=((MemberVO)session.getAttribute("loginMember")).getMemberId();
	     Map<String, String> mapParam = new HashMap<>();
	     mapParam.put("memberId", memberId);
	     mapParam.put("workDate", workDate);

	     Map<String, Boolean> result = new HashMap<>();
	     boolean alreadyRegistered = service.isWorkDataRegisteredForDate(mapParam);
	     boolean alreadyCheckedOut = service.isCheckOutRegisteredForDate(mapParam);

	     result.put("alreadyRegistered", alreadyRegistered);
	     result.put("alreadyCheckedOut", alreadyCheckedOut);

	     return result;
	 }

	 @PostMapping("/getTime")
	 @ResponseBody
	 public void getWorkTime(@RequestParam("date") String workDate,
			 HttpServletRequest request, HttpServletResponse response,HttpSession session) throws IOException {

		 String memberId=((MemberVO)session.getAttribute("loginMember")).getMemberId();
	     Map<String, Object> paramMap = new HashMap<>();
	     paramMap.put("memberId", memberId);
	     paramMap.put("workDate", workDate);
	     //System.out.println(paramMap);
	     Work w = service.selectWorkByDateAndMemberId(paramMap);
	     //System.out.println(w);
	     //Gson gson = new Gson();
	     ObjectMapper mapper = new ObjectMapper();
	     //String json = gson.toJson(w);
	     String json=mapper.writeValueAsString(w);
         response.setContentType("application/json");
         response.setCharacterEncoding("UTF-8");
         response.getWriter().write(json);
	 }
	 
	 @PostMapping("/requestTimeChange")
	 @ResponseBody
	 public void requestTimeChange(@RequestParam("date") String workDate,@RequestParam("reason") String reason,
			 HttpServletRequest request, HttpServletResponse response,HttpSession session) throws IOException {

		 String memberId=((MemberVO)session.getAttribute("loginMember")).getMemberId();
	     Map<String, Object> paramMap = new HashMap<>();
	     paramMap.put("memberId", memberId);
	     paramMap.put("workDate", workDate);
	     Work w = service.selectWorkByDateAndMemberId(paramMap);
	     WorkChange wc = WorkChange.builder()
	    		 .work(w)
	    		 .changeStatus("수정 요청")
	    		 .reason(reason)
	    		 .build();
	     int insertResult = service.insertWorkchange(wc);
	     boolean result = insertResult>0;

	     Gson gson = new Gson();
	     String json = gson.toJson(result);
         response.setContentType("application/json");
         response.setCharacterEncoding("UTF-8");
         response.getWriter().write(json);
	 }

	 @GetMapping("/workChange")
	 public String workChangeList(Model model, @RequestParam(value="cPage",defaultValue="1") int cPage,
			 HttpServletRequest request) {
		 List<WorkChange> workChangeList = service.selectAllWorkChange(Map.of("cPage",cPage,"numPerpage",10));
		 int totalData=service.selectWorkChangeCount();
		 model.addAttribute("workChangeList", workChangeList);
		 model.addAttribute("pageBar",Pagenation.getPage(cPage,10,totalData,request.getRequestURI()));
		 return "/work/workChangeList";
	 }

	 @PostMapping("/approveRequest")
	 public void approveRequest(@RequestParam("workChangeNo") int workChangeNo,
			 @RequestParam("workNo") int no,@RequestParam("workStatus") String workStatus,
			 @RequestParam("workStart") String workStart,@RequestParam("workEnd") String workEnd,
			 HttpServletRequest request, HttpServletResponse response) throws IOException, ParseException {
		 
		 switch (workStatus) {
		 	case "normal":workStatus = "정상출근"; break;
		 	case "late":workStatus = "지각"; break;
		 	case "early_leave":workStatus = "조퇴"; break;
		}
		 
		 Work w = service.selectWorkByNo(no);
		 
		// 날짜 정보 추출
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		String existingDate = dateFormat.format(w.getWorkStart());

		// 날짜와 시간을 결합하여 수정된 timestamp 생성
		SimpleDateFormat datetimeFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		Date tempWorkStart = datetimeFormat.parse(existingDate + " " + workStart);
		Date tempWorkEnd = datetimeFormat.parse(existingDate + " " + workEnd);
		// work 객체의 시작 및 종료 시간 설정 (Date를 Timestamp로 변환)
		Timestamp newWorkStart = new Timestamp(tempWorkStart.getTime());
		Timestamp newWorkEnd = new Timestamp(tempWorkEnd.getTime());
		//System.out.println("세팅전"+w);
		 w.setWorkStart(newWorkStart);
		 w.setWorkEnd(newWorkEnd);
		 w.setWorkStatus(workStatus);
		 //System.out.println("세팅후"+w);
		 int result = service.updateWorkTime(w);
		 
		 int statusResult=0;
		 if(result>0) {
			 String status="수정 완료";
			 Map<String, Object> paramMap = new HashMap<>();
			 paramMap.put("changeStatus", status);
			 paramMap.put("workChangeNo", workChangeNo);
			 statusResult = service.updateWorkChangeStatus(paramMap);
		 }
		 
		 Gson gson = new Gson();
	     String json = gson.toJson(statusResult);
         response.setContentType("application/json");
         response.setCharacterEncoding("UTF-8");
         response.getWriter().write(json);
	 }
	 
	 @PostMapping("/deleteRequest")
	 public void approveRequest(@RequestParam("workChangeNo") int workChangeNo,
			 HttpServletRequest request, HttpServletResponse response) throws IOException, ParseException {
		 
		 int result = service.deleteWorkChange(workChangeNo);
		 
		 Gson gson = new Gson();
	     String json = gson.toJson(result);
         response.setContentType("application/json");
         response.setCharacterEncoding("UTF-8");
         response.getWriter().write(json);
	 }
	 	
		@GetMapping("/workTimeByTeam")
		public String monthWorkTimeByTeam(
				@RequestParam(required = false) Integer currentYear, 
	            @RequestParam(required = false) Integer currentMonth,
	            @RequestParam(required = false) String memberName,
	            HttpSession session,
				HttpServletRequest request, HttpServletResponse response, Model model) throws IOException{
			String deptName=((MemberVO)session.getAttribute("loginMember")).getDept().getDeptName();

		    Map<String, Object> paramMap = new HashMap<>();
	        paramMap.put("deptName", deptName);
	        paramMap.put("memberName", memberName);

			 if (currentYear == null || currentMonth == null) {
		            Calendar cal = Calendar.getInstance();
		            currentYear = cal.get(Calendar.YEAR);
		            currentMonth = cal.get(Calendar.MONTH) + 1;
		            // 년월 정보를 Map에 담기
		            paramMap.put("currentYear", currentYear);//2023
		            paramMap.put("currentMonth", currentMonth);//8
		            
		            List<Work> workList = service.getMonthWorkTimeByTeam(paramMap);

		            model.addAttribute("workList", workList);
		            return "/work/workBoard-team";
		        }else {
		            paramMap.put("currentYear", currentYear);
		            paramMap.put("currentMonth", currentMonth);
		            List<Work> workList = service.getMonthWorkTimeByTeam(paramMap);
		            
		            Gson gson = new Gson();
		            String json = gson.toJson(workList);
		            response.setContentType("application/json");
		            response.setCharacterEncoding("UTF-8");
		            response.getWriter().write(json);
		        }
			 return null;
		}
}
