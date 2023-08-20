package com.workit.approve.controller;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.workit.approve.model.dto.Approve;
import com.workit.approve.model.dto.ApproveAttach;
import com.workit.approve.model.dto.ApproveLine;
import com.workit.approve.model.dto.Expenditure;
import com.workit.approve.model.dto.ReferLine;
import com.workit.approve.model.dto.Time;
import com.workit.approve.model.dto.ToDo;
import com.workit.approve.model.service.ApproveService;
import com.workit.common.PageFactory;
import com.workit.employee.service.EmployeeService;
import com.workit.member.model.dto.Department;
import com.workit.member.model.dto.Member;

@Controller
@RequestMapping("/approve")
public class ApproveController {
	@Autowired
	private ApproveService service;

	@Autowired
	private EmployeeService eservice;

	@Autowired
	private ObjectMapper mapper;

	
	@RequestMapping("/extendsView.do") // 연장근무신청서 페이지로 이동
	public String extendsView(Model m) {
		LocalDate now = LocalDate.now();
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
		String time = now.format(formatter);

		List<Department> deps = eservice.selectDept();

		m.addAttribute("deps", deps);
		m.addAttribute("time", time); // 현재날짜 전달
		return "approve/extends-app";
	}

	@RequestMapping("/attendanceView.do") // 근태신청서 페이지로 이동
	public String attendacneView(Model m) {
		LocalDate now = LocalDate.now();
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
		String time = now.format(formatter);
		List<Department> deps = eservice.selectDept();
		/* List<Member> members = service.selectAllMember(); */

		/* m.addAttribute("members",members); */
		m.addAttribute("deps", deps);

		m.addAttribute("time", time); // 현재날짜 전달
		return "approve/attendance-app";
	}

	@RequestMapping("/expenditureView.do") // 지출결의서 페이지로 이동
	public String expenditureView(Model m) {
		LocalDate now = LocalDate.now();
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
		String time = now.format(formatter);
		List<Department> deps = eservice.selectDept();
		/* List<Member> members = service.selectAllMember(); */

		/* m.addAttribute("members",members); */
		m.addAttribute("deps", deps);

		m.addAttribute("time", time); // 현재날짜 전달
		return "approve/expenditure-app";
	}
	
	@RequestMapping("/referenceDocumentBox.do")  // 본인이 참조대상인 참조문서함 들어가기
	public String referenceDocumentBox(Model m, String mId) {
		Map<String, Object> param = new HashMap<>();
		param.put("mId", mId);
	
		List<Approve> referDocuments = service.selectReferenceDocumentBox(param);
		m.addAttribute("referDocuments", referDocuments);
		
		return "approve/refer-document-box"; 
	}
	
	@RequestMapping("/draftDocumentBox.do")  // 본인이 작성한 기안문서함들 들어가기
	public String selectDraftDocumentBox(@RequestParam(value="cPage",defaultValue="1") int cPage,
			@RequestParam(value="numPerpage",defaultValue="10") int numPerpage,
			Model m, @RequestParam(value="mId") String mId) {
		Map<String, Object> param = new HashMap<>();
		param.put("c","완료");
		param.put("w", "결재대기");
		param.put("p", "결재처리중");
		param.put("r", "반려");
		param.put("mId", mId);
		param.put("cPage", cPage);
		param.put("numPerpage", numPerpage);
		
	
		List<Approve> draftDocuments = service.selectDraftDocumentBox(param);
		int totalData=service.selectDraftDocumentsCount(param); 		
		

		m.addAttribute("pageBar",PageFactory.getPage(cPage,numPerpage,totalData,"draftDocumentBox.do",mId));
		m.addAttribute("totalData",totalData);
		m.addAttribute("draftDocuments", draftDocuments);
		
		System.out.println(draftDocuments.toString());
		
		return "approve/draft-document-box";
	}
	
	@RequestMapping("/changeStateSave.do") // 결재대기인 기안서 임시저장상태로 바꿈
	public String changeStateSave(Model m, String approveNo,String mId) {
		Map<String, Object> param = new HashMap<>();
		param.put("approveNo",approveNo);
		param.put("state", "임시저장");
	
		int result = service.changeStateSave(param);
		
		if(result >= 1) {
			m.addAttribute("msg", "철회 성공");
			m.addAttribute("url", "/approve/draftDocumentBox.do?mId="+mId);
		} else {
			m.addAttribute("msg", "철회 실패");
			m.addAttribute("url", "/approve/draftDocumentBox.do?mId="+mId);
		}
		return "common/msg";
	}


	@RequestMapping("/waitingApprove.do") // 결재대기문서로 이동
	public String selectWaitingApprove(Model m, @RequestParam(value = "mId") String mId) {
		Map<String, Object> param = new HashMap<>();
		param.put("processState","결재처리중");
		param.put("approveState", "결재대기");
		param.put("mId", mId);
		List<Approve> waitingApps = service.selectAllWaitingApprove(param);
		m.addAttribute("waitingApps", waitingApps);

		return "approve/waiting-approve";
	}
	
	@RequestMapping("/detailApprove.do") // 결재대기함에서 해당 본인대상인 결재문서들 상세보기
	public String detailApprove(Model m, String approveNo, String approveKind, String approveState,String name) {

		List<Department> deps = eservice.selectDept();
		Map<String, Object> param = new HashMap<>();
		param.put("approveNo", approveNo);
		param.put("approveKind", approveKind);
		m.addAttribute("name",name);
		
		if (approveKind.equals("연장근무신청서")) { // 임시저장 문서의 종류가 연장근무신청서의 경우
			List<Approve> saveExtends = service.detailSave(param); // 기안서에 대해서 갖고왔으며 (시간,첨부파일,작성자에대한 멤버테이블과 조인(
			List<ApproveLine> approveLines = service.detailApproveLines(param);
			List<ReferLine> referLines = service.detailReferLines(param);

			LocalDate now = LocalDate.now();
			DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
			String time = now.format(formatter);

			String date = "";
			String stime = "";
			String etime = "";
			
			date += saveExtends.get(0).getTime().getStartTime().toLocalDateTime().getYear();// 년
			date += "-";
			if (saveExtends.get(0).getTime().getStartTime().toLocalDateTime().getMonthValue() < 10) {
				date += "0";
			}
			date += saveExtends.get(0).getTime().getStartTime().toLocalDateTime().getMonthValue();// 월

			date += "-";

			if (saveExtends.get(0).getTime().getStartTime().toLocalDateTime().getDayOfMonth() < 10) {
				date += "0";
			}
			date += saveExtends.get(0).getTime().getStartTime().toLocalDateTime().getDayOfMonth();

			if (saveExtends.get(0).getTime().getStartTime().toLocalDateTime().getHour() < 10) {
				stime += "0";
			}
			stime += saveExtends.get(0).getTime().getStartTime().toLocalDateTime().getHour();
			stime += ":";
			if (saveExtends.get(0).getTime().getStartTime().toLocalDateTime().getMinute() < 10) {
				stime += "0";
			}
			stime += saveExtends.get(0).getTime().getStartTime().toLocalDateTime().getMinute();

			if (saveExtends.get(0).getTime().getEndTime().toLocalDateTime().getHour() < 10) {
				etime += "0";
			}
			etime += saveExtends.get(0).getTime().getEndTime().toLocalDateTime().getHour();
			etime += ":";
			if (saveExtends.get(0).getTime().getEndTime().toLocalDateTime().getMinute() < 10) {
				etime += "0";
			}
			etime += saveExtends.get(0).getTime().getEndTime().toLocalDateTime().getMinute();

			m.addAttribute("deps", deps); // 결재선에서 출력될 부서들
			m.addAttribute("time", time); // 작성일
			m.addAttribute("stime", stime); // 시작시간
			m.addAttribute("etime", etime); // 날짜
			m.addAttribute("date", date); // 날짜
			m.addAttribute("saveExtends", saveExtends);
			m.addAttribute("approveNo", approveNo);
			m.addAttribute("approveState",approveState);
			m.addAttribute("oriFileName",saveExtends.get(0).getApproveAttach().getOriName());
			m.addAttribute("saveFileName",saveExtends.get(0).getApproveAttach().getSaveName());
			m.addAttribute("message",saveExtends.get(0).getRejectMessage());
			
//			ObjectMapper mapper=new ObjectMapper();// Jackson에서 제공하는(라이브러리) ObjectMapper  -> config에 빈으로 등록해서 객체 생성 생략가능
			// 자바에서 해당 객체를 문자열로 저장한후 중간역할담당인 mapper를 통해 자바스크립트에서 객체형태로 저장이됨
			try {
				m.addAttribute("approveLines", mapper.writeValueAsString(approveLines));
				m.addAttribute("referLines", mapper.writeValueAsString(referLines));
				// m.addAttribute("lines",
				// mapper.writeValueAsString(Map.of("referenceLine",referLines,"approveLine",approveLines)));
				// // 한번에 map으로 객체로 저장

			} catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
			}
			
			System.out.println(saveExtends.get(0).getMemberId().getMemberName());
			System.out.println(saveExtends.get(0).getMemberId().getDept().getDeptName());
			System.out.println(saveExtends.get(0).getMemberId().getJob().getJobName());
			
			
			if(name.equals("기안문서함") || name.equals("참조문서함")) {
				return "approve/draft-extends-app";
			}
			if(name.equals("결재대기문서")) {
				return "approve/waiting-extends-app";				
			}
		}
		
		
		if (approveKind.equals("연차") || approveKind.equals("반차") || approveKind.equals("보건") || approveKind.equals("경조") || approveKind.equals("외출")) { // 임시저장 문서의 종류가 근태신청서의 경우
			List<Approve> saveExtends = service.detailSave(param); // 기안서에 대해서 갖고왔으며 (시간,첨부파일,작성자에대한 멤버테이블과 조인(
			List<ApproveLine> approveLines = service.detailApproveLines(param);
			List<ReferLine> referLines = service.detailReferLines(param);

			LocalDate now = LocalDate.now();
			DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
			String time = now.format(formatter);

			String sdate = "";
			String edate = "";
			String stime = "";
			String etime = "";
			

			if(approveKind.equals("반차") || approveKind.equals("외출")) {
				sdate += saveExtends.get(0).getTime().getStartTime().toLocalDateTime().getYear();// 년
				sdate += "-";
				if (saveExtends.get(0).getTime().getStartTime().toLocalDateTime().getMonthValue() < 10) {
					sdate += "0";
				}
				sdate += saveExtends.get(0).getTime().getStartTime().toLocalDateTime().getMonthValue();// 월

				sdate += "-";

				if (saveExtends.get(0).getTime().getStartTime().toLocalDateTime().getDayOfMonth() < 10) {
					sdate += "0";
				}
				sdate += saveExtends.get(0).getTime().getStartTime().toLocalDateTime().getDayOfMonth();

				if (saveExtends.get(0).getTime().getStartTime().toLocalDateTime().getHour() < 10) {
					stime += "0";
				}
				stime += saveExtends.get(0).getTime().getStartTime().toLocalDateTime().getHour();
				stime += ":";
				if (saveExtends.get(0).getTime().getStartTime().toLocalDateTime().getMinute() < 10) {
					stime += "0";
				}
				stime += saveExtends.get(0).getTime().getStartTime().toLocalDateTime().getMinute();

				if (saveExtends.get(0).getTime().getEndTime().toLocalDateTime().getHour() < 10) {
					etime += "0";
				}
				etime += saveExtends.get(0).getTime().getEndTime().toLocalDateTime().getHour();
				etime += ":";
				if (saveExtends.get(0).getTime().getEndTime().toLocalDateTime().getMinute() < 10) {
					etime += "0";
				}
				etime += saveExtends.get(0).getTime().getEndTime().toLocalDateTime().getMinute();
				m.addAttribute("stime", stime); // 시작시간
				m.addAttribute("etime", etime); // 날짜
				m.addAttribute("sdate", sdate); // 날짜
			}else {
				sdate += saveExtends.get(0).getTime().getStartTime().toLocalDateTime().getYear();// 년
				sdate += "-";
				if (saveExtends.get(0).getTime().getStartTime().toLocalDateTime().getMonthValue() < 10) {
					sdate += "0";
				}
				sdate += saveExtends.get(0).getTime().getStartTime().toLocalDateTime().getMonthValue();// 월

				sdate += "-";

				if (saveExtends.get(0).getTime().getStartTime().toLocalDateTime().getDayOfMonth() < 10) {
					sdate += "0";
				}
				sdate += saveExtends.get(0).getTime().getStartTime().toLocalDateTime().getDayOfMonth();
				
				//
				edate += saveExtends.get(0).getTime().getEndTime().toLocalDateTime().getYear();// 년
				edate += "-";
				if (saveExtends.get(0).getTime().getEndTime().toLocalDateTime().getMonthValue() < 10) {
					edate += "0";
				}
				edate += saveExtends.get(0).getTime().getEndTime().toLocalDateTime().getMonthValue();// 월

				edate += "-";

				if (saveExtends.get(0).getTime().getEndTime().toLocalDateTime().getDayOfMonth() < 10) {
					edate += "0";
				}
				edate += saveExtends.get(0).getTime().getEndTime().toLocalDateTime().getDayOfMonth();
				m.addAttribute("sdate", sdate); // 날짜
				m.addAttribute("edate", edate); // 날짜			
			}

			m.addAttribute("deps", deps); // 결재선에서 출력될 부서들
			m.addAttribute("time", time); // 작성일
			m.addAttribute("saveExtends", saveExtends);
			m.addAttribute("approveNo", approveNo);
			m.addAttribute("approveState",approveState);
			m.addAttribute("approveKind",approveKind);
			m.addAttribute("oriFileName",saveExtends.get(0).getApproveAttach().getOriName());
			m.addAttribute("saveFileName",saveExtends.get(0).getApproveAttach().getSaveName());
			m.addAttribute("message",saveExtends.get(0).getRejectMessage());
			try {
				m.addAttribute("approveLines", mapper.writeValueAsString(approveLines));
				m.addAttribute("referLines", mapper.writeValueAsString(referLines));
			} catch (Exception e) {
				e.printStackTrace();
			}
			System.out.println(approveLines);
			
			if(name.equals("기안문서함") || name.equals("참조문서함")) {
				return "approve/draft-attendance-app";
			}
			if(name.equals("결재대기문서")) {
				return "approve/waiting-attendance-app";			
			}
		}
		
		
		if (approveKind.equals("지출결의서")) { // 임시저장 문서의 종류가 지출결의서의 경우
			List<Approve> saveExtends = service.detailSave(param); // 기안서에 대해서 갖고왔으며 (시간,첨부파일,작성자에대한 멤버테이블과 조인(
			List<ApproveLine> approveLines = service.detailApproveLines(param);
			List<ReferLine> referLines = service.detailReferLines(param);
			List<Expenditure> expenditures = service.detailExpenditures(param);
			
			
			System.out.println(expenditures.toString());
				
			LocalDate now = LocalDate.now();
			DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
			String time = now.format(formatter);
			
			m.addAttribute("deps", deps); // 결재선에서 출력될 부서들
			m.addAttribute("time", time); // 작성일
			m.addAttribute("saveExtends", saveExtends);
			m.addAttribute("approveNo", approveNo);
			m.addAttribute("approveState",approveState);
			m.addAttribute("oriFileName",saveExtends.get(0).getApproveAttach().getOriName());
			m.addAttribute("saveFileName",saveExtends.get(0).getApproveAttach().getSaveName());
			m.addAttribute("message",saveExtends.get(0).getRejectMessage());
//			ObjectMapper mapper=new ObjectMapper();// Jackson에서 제공하는(라이브러리) ObjectMapper  -> config에 빈으로 등록해서 객체 생성 생략가능
			// 자바에서 해당 객체를 문자열로 저장한후 중간역할담당인 mapper를 통해 자바스크립트에서 객체형태로 저장이됨
			try {
				m.addAttribute("approveLines", mapper.writeValueAsString(approveLines));
				m.addAttribute("referLines", mapper.writeValueAsString(referLines));
				m.addAttribute("expenditures",mapper.writeValueAsString(expenditures));

			} catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
			}
			if(name.equals("기안문서함") || name.equals("참조문서함")) {
				return "approve/draft-expenditure-app";
			}
			if(name.equals("결재대기문서")) {
				return "approve/waiting-expenditure-app";		
			}
		}
		return null;
	}
		
	
	@RequestMapping("/filedownload") // 해당 첨부파일 다운로드해서 확인하는 작업
	public void fileDown(String oriname, String rename, OutputStream out,
			@RequestHeader(value="user-agent") String header,
			HttpSession session,
			HttpServletResponse res) {
		
		String path=session.getServletContext().getRealPath("/resources/upload/approve/");
		File downloadFile=new File(path+rename);
		try(FileInputStream fis=new FileInputStream(downloadFile);
				BufferedInputStream bis=new BufferedInputStream(fis);
				BufferedOutputStream bos=new BufferedOutputStream(out)) {
			
			boolean isMS=header.contains("Trident")||header.contains("MSIE");
			String ecodeRename="";
			if(isMS) {
				ecodeRename=URLEncoder.encode(oriname,"UTF-8");
				ecodeRename=ecodeRename.replaceAll("\\+","%20");
			}else {
				ecodeRename=new String(oriname.getBytes("UTF-8"),"ISO-8859-1");
			}
			res.setContentType("application/octet-stream;charset=utf-8");
			res.setHeader("Content-Disposition","attachment;filename=\""+ecodeRename+"\"");
			
			int read=-1;
			while((read=bis.read())!=-1) {
				bos.write(read);
			}
			
		}catch(IOException e) {
			e.printStackTrace();
		}
	}
	
	
	@RequestMapping("rejectMessage.do") // 결재대기문서에서 결재 반려하는 작업
	public String rejectMessage(Model m,String mId,String approveNo,String message) {
		Map<String, Object> param = new HashMap<>();
		param.put("approveNo",approveNo);
		param.put("mId", mId);
		param.put("message", message);
		param.put("state", "반려");
		
		int result = service.rejectMessage(param);
		
		if (result >= 1) {
			m.addAttribute("msg", "반려 성공");
			m.addAttribute("url", "/approve/waitingApprove.do?mId="+mId);
		} else {
			m.addAttribute("msg", "반려 실패");
			m.addAttribute("url", "/approve/waitingApprove.do?mId="+mId);
		}
		return "common/msg";
	}
	
	
	@RequestMapping("approveAssign.do") // 결재대기문서에서 결재 승인하는 작업
	public String approveAssign(Model m,String mId,String approveNo,String currentOrder, String writer, String approveKind) {
		Map<String, Object> param = new HashMap<>();
		
		param.put("approveNo",approveNo);
		param.put("mId", mId);
		param.put("status", "완료");
		param.put("currentOrder", currentOrder);
		param.put("writer", writer);
		param.put("approveKind", approveKind);
		
		int result = service.approveAssign(param); // update문을 사용하여 해당 결재선의 상태를 완료로 바꿈
		System.out.println(result);
		int result1 = service.plusCurrentOrder(param); // 결재선의 현재 번호를 1 증가시킴
		
		int totalLineCnt = service.selectTotalLineCnt(param); // 해당 결재서의 결재선 총 개수
		int completeLineCnt = service.selectCompleteLineCnt(param); // 해당 결재서의 결재선 중 완료된 결재선의 개수
		
		if(totalLineCnt > completeLineCnt) { // 결재선 전체개수가 완료된 결재선 개수보다 많을경우 -> 결재선은 결재처리중으로 바뀜
			param.put("state","결재처리중");
			int result2 = service.updateProcessState(param); 
		}else { // 같을 경우 -> 결재선은 완료
			param.put("state","완료");
			int result3 = service.updateCompleteState(param);
			
			if(approveKind.equals("연차")) {
				int cnt = service.timeDifference(param);
				String startDate = service.selectStartTime(param);
				param.put("startDate", startDate);
				for(int i=1; i<=cnt; i++) {
					param.put("i", i);
					service.insertAnnualLeave(param);
				}
			}
			
			if(approveKind.equals("반차")) {
				String startDate = service.selectStartTime(param);
				param.put("startDate", startDate);
				param.put("i", 0);
					service.insertAnnualLeave(param);
			}
		}

		if (result >= 1) {
			m.addAttribute("msg", "승인 성공");
			m.addAttribute("url", "/approve/waitingApprove.do?mId="+mId);
		} else {
			m.addAttribute("msg", "승인 실패");
			m.addAttribute("url", "/approve/waitingApprove.do?mId="+mId);
		}
		return "common/msg"; 
	}
	
	@RequestMapping("/saveDocument.do") // 임시저장함문서로 이동
	public String saveDocument(Model m, @RequestParam(value = "mId") String mId) {
		Map<String, Object> param = new HashMap<>();

		param.put("state", "임시저장");
		param.put("mId", mId);

		List<Approve> saveApps = service.selectAllSaveDocument(param);

		m.addAttribute("saveApps", saveApps);

		return "approve/save-document";
	}

	@RequestMapping("/detailSave.do") // 임시저장함 문서에서 해당 문서들 상세보기
	public String detailSave(Model m, String approveNo, String approveKind, String approveState) {

		List<Department> deps = eservice.selectDept();
		Map<String, Object> param = new HashMap<>();
		param.put("approveNo", approveNo);
		param.put("approveKind", approveKind);

		if (approveKind.equals("연장근무신청서")) { // 임시저장 문서의 종류가 연장근무신청서의 경우
			List<Approve> saveExtends = service.detailSave(param); // 기안서에 대해서 갖고왔으며 (시간,첨부파일,작성자에대한 멤버테이블과 조인(
			List<ApproveLine> approveLines = service.detailApproveLines(param);
			List<ReferLine> referLines = service.detailReferLines(param);

			LocalDate now = LocalDate.now();
			DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
			String time = now.format(formatter);

			String date = "";
			String stime = "";
			String etime = "";

			date += saveExtends.get(0).getTime().getStartTime().toLocalDateTime().getYear();// 년
			date += "-";
			if (saveExtends.get(0).getTime().getStartTime().toLocalDateTime().getMonthValue() < 10) {
				date += "0";
			}
			date += saveExtends.get(0).getTime().getStartTime().toLocalDateTime().getMonthValue();// 월

			date += "-";

			if (saveExtends.get(0).getTime().getStartTime().toLocalDateTime().getDayOfMonth() < 10) {
				date += "0";
			}
			date += saveExtends.get(0).getTime().getStartTime().toLocalDateTime().getDayOfMonth();

			if (saveExtends.get(0).getTime().getStartTime().toLocalDateTime().getHour() < 10) {
				stime += "0";
			}
			stime += saveExtends.get(0).getTime().getStartTime().toLocalDateTime().getHour();
			stime += ":";
			if (saveExtends.get(0).getTime().getStartTime().toLocalDateTime().getMinute() < 10) {
				stime += "0";
			}
			stime += saveExtends.get(0).getTime().getStartTime().toLocalDateTime().getMinute();

			if (saveExtends.get(0).getTime().getEndTime().toLocalDateTime().getHour() < 10) {
				etime += "0";
			}
			etime += saveExtends.get(0).getTime().getEndTime().toLocalDateTime().getHour();
			etime += ":";
			if (saveExtends.get(0).getTime().getEndTime().toLocalDateTime().getMinute() < 10) {
				etime += "0";
			}
			etime += saveExtends.get(0).getTime().getEndTime().toLocalDateTime().getMinute();

			m.addAttribute("deps", deps); // 결재선에서 출력될 부서들
			m.addAttribute("time", time); // 작성일
			m.addAttribute("stime", stime); // 시작시간
			m.addAttribute("etime", etime); // 날짜
			m.addAttribute("date", date); // 날짜
			m.addAttribute("saveExtends", saveExtends);
			m.addAttribute("approveNo", approveNo);
			m.addAttribute("approveState",approveState);
			m.addAttribute("fileName",saveExtends.get(0).getApproveAttach().getOriName());
			System.out.println(saveExtends.toString());

//			ObjectMapper mapper=new ObjectMapper();// Jackson에서 제공하는(라이브러리) ObjectMapper  -> config에 빈으로 등록해서 객체 생성 생략가능
			// 자바에서 해당 객체를 문자열로 저장한후 중간역할담당인 mapper를 통해 자바스크립트에서 객체형태로 저장이됨
			try {
				m.addAttribute("approveLines", mapper.writeValueAsString(approveLines));
				m.addAttribute("referLines", mapper.writeValueAsString(referLines));
				// m.addAttribute("lines",
				// mapper.writeValueAsString(Map.of("referenceLine",referLines,"approveLine",approveLines)));
				// // 한번에 map으로 객체로 저장

			} catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
			}
			return "approve/extends-app";
		}
		
		
		if (approveKind.equals("연차") || approveKind.equals("반차") || approveKind.equals("보건") || approveKind.equals("경조") || approveKind.equals("외출")) { // 임시저장 문서의 종류가 근태신청서의 경우
			List<Approve> saveExtends = service.detailSave(param); // 기안서에 대해서 갖고왔으며 (시간,첨부파일,작성자에대한 멤버테이블과 조인(
			List<ApproveLine> approveLines = service.detailApproveLines(param);
			List<ReferLine> referLines = service.detailReferLines(param);

			LocalDate now = LocalDate.now();
			DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
			String time = now.format(formatter);

			String sdate = "";
			String edate = "";
			String stime = "";
			String etime = "";
			

			if(approveKind.equals("반차") || approveKind.equals("외출")) {
				sdate += saveExtends.get(0).getTime().getStartTime().toLocalDateTime().getYear();// 년
				sdate += "-";
				if (saveExtends.get(0).getTime().getStartTime().toLocalDateTime().getMonthValue() < 10) {
					sdate += "0";
				}
				sdate += saveExtends.get(0).getTime().getStartTime().toLocalDateTime().getMonthValue();// 월

				sdate += "-";

				if (saveExtends.get(0).getTime().getStartTime().toLocalDateTime().getDayOfMonth() < 10) {
					sdate += "0";
				}
				sdate += saveExtends.get(0).getTime().getStartTime().toLocalDateTime().getDayOfMonth();

				if (saveExtends.get(0).getTime().getStartTime().toLocalDateTime().getHour() < 10) {
					stime += "0";
				}
				stime += saveExtends.get(0).getTime().getStartTime().toLocalDateTime().getHour();
				stime += ":";
				if (saveExtends.get(0).getTime().getStartTime().toLocalDateTime().getMinute() < 10) {
					stime += "0";
				}
				stime += saveExtends.get(0).getTime().getStartTime().toLocalDateTime().getMinute();

				if (saveExtends.get(0).getTime().getEndTime().toLocalDateTime().getHour() < 10) {
					etime += "0";
				}
				etime += saveExtends.get(0).getTime().getEndTime().toLocalDateTime().getHour();
				etime += ":";
				if (saveExtends.get(0).getTime().getEndTime().toLocalDateTime().getMinute() < 10) {
					etime += "0";
				}
				etime += saveExtends.get(0).getTime().getEndTime().toLocalDateTime().getMinute();
				m.addAttribute("stime", stime); // 시작시간
				m.addAttribute("etime", etime); // 날짜
				m.addAttribute("sdate", sdate); // 날짜
			}else {
				sdate += saveExtends.get(0).getTime().getStartTime().toLocalDateTime().getYear();// 년
				sdate += "-";
				if (saveExtends.get(0).getTime().getStartTime().toLocalDateTime().getMonthValue() < 10) {
					sdate += "0";
				}
				sdate += saveExtends.get(0).getTime().getStartTime().toLocalDateTime().getMonthValue();// 월

				sdate += "-";

				if (saveExtends.get(0).getTime().getStartTime().toLocalDateTime().getDayOfMonth() < 10) {
					sdate += "0";
				}
				sdate += saveExtends.get(0).getTime().getStartTime().toLocalDateTime().getDayOfMonth();
				
				//
				edate += saveExtends.get(0).getTime().getEndTime().toLocalDateTime().getYear();// 년
				edate += "-";
				if (saveExtends.get(0).getTime().getEndTime().toLocalDateTime().getMonthValue() < 10) {
					edate += "0";
				}
				edate += saveExtends.get(0).getTime().getEndTime().toLocalDateTime().getMonthValue();// 월

				edate += "-";

				if (saveExtends.get(0).getTime().getEndTime().toLocalDateTime().getDayOfMonth() < 10) {
					edate += "0";
				}
				edate += saveExtends.get(0).getTime().getEndTime().toLocalDateTime().getDayOfMonth();
				m.addAttribute("sdate", sdate); // 날짜
				m.addAttribute("edate", edate); // 날짜			
			}
						
			m.addAttribute("deps", deps); // 결재선에서 출력될 부서들
			m.addAttribute("time", time); // 작성일
			m.addAttribute("saveExtends", saveExtends);
			m.addAttribute("approveNo", approveNo);
			m.addAttribute("approveState",approveState);
			m.addAttribute("approveKind",approveKind);
			m.addAttribute("fileName",saveExtends.get(0).getApproveAttach().getOriName());
			
			try {
				m.addAttribute("approveLines", mapper.writeValueAsString(approveLines));
				m.addAttribute("referLines", mapper.writeValueAsString(referLines));
			} catch (Exception e) {
				e.printStackTrace();
			}
			return "approve/attendance-app";
		}
		
		
		if (approveKind.equals("지출결의서")) { // 임시저장 문서의 종류가 지출결의서의 경우
			List<Approve> saveExtends = service.detailSave(param); // 기안서에 대해서 갖고왔으며 (시간,첨부파일,작성자에대한 멤버테이블과 조인(
			List<ApproveLine> approveLines = service.detailApproveLines(param);
			List<ReferLine> referLines = service.detailReferLines(param);
			List<Expenditure> expenditures = service.detailExpenditures(param);
			
			
			System.out.println(expenditures.toString());
			
			LocalDate now = LocalDate.now();
			DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
			String time = now.format(formatter);
			
			m.addAttribute("deps", deps); // 결재선에서 출력될 부서들
			m.addAttribute("time", time); // 작성일
			m.addAttribute("saveExtends", saveExtends);
			m.addAttribute("approveNo", approveNo);
			m.addAttribute("approveState",approveState);
			m.addAttribute("fileName",saveExtends.get(0).getApproveAttach().getOriName());
//			ObjectMapper mapper=new ObjectMapper();// Jackson에서 제공하는(라이브러리) ObjectMapper  -> config에 빈으로 등록해서 객체 생성 생략가능
			// 자바에서 해당 객체를 문자열로 저장한후 중간역할담당인 mapper를 통해 자바스크립트에서 객체형태로 저장이됨
			try {
				m.addAttribute("approveLines", mapper.writeValueAsString(approveLines));
				m.addAttribute("referLines", mapper.writeValueAsString(referLines));
				m.addAttribute("expenditures",mapper.writeValueAsString(expenditures));

			} catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
			}
			return "approve/expenditure-app";
		}
		return null;
	}

	@RequestMapping("/removeSave.do") // 임시저장된 기안서 삭제하기
	public String removeSave(String deleteApproveNo, Model model,String mId) {

		if (service.removeSave(deleteApproveNo) >= 1) {
			model.addAttribute("msg", "성공적으로 삭제하였습니다.");
			model.addAttribute("url", "/approve/saveDocument.do?mId="+mId);
		} else {
			model.addAttribute("msg", "삭제에 실패하였습니다.");
			model.addAttribute("url", "/");
		}
		return "common/msg";
	}

	@PostMapping("/changeDep.do") // 결재선에서 부서클릭시 맞는 부서들 출력
	@ResponseBody // 비동기식으로 받기위해서 @ResponseBody 어노테이션을 사용해야함
	public List<Member> changeDep(String deptName) { // 선택한 부서에 맞는 사원들 리스트로 반환
		List<Member> m = service.changeDep(deptName);
		return m;
	}

	@PostMapping("/printMember.do")
	@ResponseBody // 비동기식으로 받기위해서 @ResponseBody 어노테이션을 사용해야함
	// 배열로 받으려면 @RequestParam(value="키값[]") 아무변수명[]을 받아주면됨
	public List<Member> printMember(@RequestParam(value = "memberId[]") String[] ListData) { // 선택한 부서에 맞는 사원들 리스트로 반환

		List<Member> members = new ArrayList<Member>();

		for (int i = 0; i < ListData.length; i++) {
			members.add(service.printMember(ListData[i]));
		}

		return members;
		/* return service.printMember(memberId); */
	}

	@RequestMapping("/insertDraft.do") // 모든 기안서 작성할때 이 컨트롤러 사용함
	public String insertDraft(String memberId, String startDate, String endDate, String startTime, String endTime,
			String content, String title, String approveKind, String geuntae, String account[], String useHistory[],
			String price[], String paraApp[], String paraRefer[], MultipartFile upFile, HttpSession session, Model model)
			throws ParseException {
		
		boolean flag = true;
	
		String approveState = "결재대기";
		Member m = Member.builder().memberId(memberId).build();

		String path = session.getServletContext().getRealPath("/resources/upload/approve/"); // 파일 저장 경로

		if (geuntae == null && title != null) { // 연장근무신청서의 경우
			Approve ap = Approve.builder().approveTitle(title).approveContent(content).memberId(m)
					.approveState(approveState).approveKind(approveKind).build();
			int result = service.insertApprove(ap); // 기안서 테이블 생성
		}

		if (geuntae != null) { // 근태신청서의 경우
			Approve ap = Approve.builder().approveTitle(title).approveContent(content).memberId(m)
					.approveState(approveState).approveKind(geuntae).build();
			int result = service.insertApprove(ap); // 기안서 테이블 생성
			if(result<1)flag=false;
		}

		if (account != null && useHistory != null && price != null) { // 지출결의서의 경우
			System.out.println(approveKind);
			System.out.println(title);
			System.out.println(content);
			Approve ap = Approve.builder().approveTitle(title).approveContent(content).memberId(m)
					.approveState(approveState).approveKind(approveKind).build();
			int result = service.insertApprove(ap);
			if(result<1)flag=false;
		}
		
		
		
		if (endDate == null && account == null) { // endDate가 null일경우 -> 연장근무신청서, 반차, 외출의 경우(한 날짜에서 시작시간과 끝시간을 고름)
			startTime = startDate + " " + startTime;
			endTime = startDate + " " + endTime;
			DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm");
			Date date = df.parse(startTime);
			long stime = date.getTime();

			Date date2 = df.parse(endTime);
			long etime = date2.getTime();

			Timestamp st = new Timestamp(stime);
			Timestamp et = new Timestamp(etime);

			Time t = Time.builder().startTime(st).endTime(et).build();
			int result2 = service.insertTime(t);
			if(result2<1)flag=false;
		}

		if (endDate != null && account == null) { // -> 연차, 보건, 경조의 경우
			startTime = startDate + " " + "00:00";
			endTime = endDate + " " + "00:00";
			DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm");
			Date date = df.parse(startTime);
			long stime = date.getTime();

			Date date2 = df.parse(endTime);
			long etime = date2.getTime();

			System.out.println(stime);
			System.out.println(etime);

			Timestamp st = new Timestamp(stime);
			Timestamp et = new Timestamp(etime);

			Time t = Time.builder().startTime(st).endTime(et).build();

			int result2 = service.insertTime(t);
			if(result2<1)flag=false;
		}

		if (!upFile.getOriginalFilename().equals("")) { // 첨부파일 추가했을경우
			String oriName = upFile.getOriginalFilename(); // 원본이름
			Date today = new Date(System.currentTimeMillis());
			String ext = oriName.substring(oriName.lastIndexOf("."));
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
			int random = (int) (Math.random() * 10000) + 1;
			String rename = sdf.format(today) + "_" + random + ext;
			try {
				upFile.transferTo(new File(path + rename)); // transferTo()메소드 통해 파일 저장
				ApproveAttach aa = ApproveAttach.builder().oriName(oriName).saveName(rename).build();
				int result3 = service.insertApproveAttach(aa); // 첨부파일 테이블 생성
				if(result3<1)flag=false;
			} catch (IOException e) {
				e.printStackTrace();
			}
		}

		if (account != null) { // 지출결의서 내용 테이블 생성

			for (int i = 0; i < account.length; i++) {
				if (!account[i].equals("")) { // 내용부분이 비어있으면 생성 x
					Expenditure ex = Expenditure.builder().account(account[i]).useHistory(useHistory[i]).price(price[i])
							.build();
					int result6 = service.insertExpenditure(ex);
					if(result6<1)flag=false;
				}
			}
		}

		if (paraApp != null) {
			for (int i = 0; i < paraApp.length; i++) {
				Map<String, Object> param = new HashMap<>();
				param.put("memberId", paraApp[i]);
				param.put("order", i + 1);
				int result4 = service.insertApproveLine(param); // 결재선 테이블 추가
				if(result4<1)flag=false;
			}
		}

		if (paraRefer != null) {
			for (int i = 0; i < paraRefer.length; i++) {
				Map<String, Object> param = new HashMap<>();
				param.put("memberId", paraRefer[i]);
				int result5 = service.insertReferLine(param); // 결재선 테이블 추가
				if (result5<1)flag=false; 
			}
		}
		
		if (flag == true) {
			model.addAttribute("msg", "작성 성공");
			model.addAttribute("url", "/");
		} else {
			model.addAttribute("msg", "작성 실패");
			model.addAttribute("url", "/");
		}
		return "common/msg";
	}

	@RequestMapping("/saveExtends.do") // 연장근무신청서 임시저장할때 사용하는 컨트롤러
	public String saveDraft(String memberId, String startDate, String startTime, String endTime, String content,
			String title, String approveKind, String paraApp[], String paraRefer[], MultipartFile upFile,Model model,
			HttpSession session) throws ParseException {
		Member m = Member.builder().memberId(memberId).build();
		boolean flag= true;
		
		String approveState = "임시저장";

		String path = session.getServletContext().getRealPath("/resources/upload/approve/"); // 파일 저장 경로

		Approve ap = Approve.builder().approveTitle(title).approveContent(content).memberId(m)
				.approveState(approveState).approveKind(approveKind).build();
		int result = service.insertApprove(ap); // 기안서 테이블 생성
		if(result<1)flag=false;
		
		if (!startDate.equals("") && !startTime.equals("") && !endTime.equals("")) {
			startTime = startDate + " " + startTime;
			endTime = startDate + " " + endTime;
			DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm");
			Date date = df.parse(startTime);
			long stime = date.getTime();

			Date date2 = df.parse(endTime);
			long etime = date2.getTime();

			Timestamp st = new Timestamp(stime);
			Timestamp et = new Timestamp(etime);

			Time t = Time.builder().startTime(st).endTime(et).build(); // 시간테이블 생성
			int result2 = service.insertTime(t);
			if(result2<1)flag=false;
		} else {
			Time t = Time.builder().startTime(null).endTime(null).build(); // 시간테이블 생성
			int result2 = service.insertTime(t);
			if(result2<1)flag=false;
		}
		

		if (!upFile.getOriginalFilename().equals("")) { // 첨부파일 추가했을경우
			String oriName = upFile.getOriginalFilename(); // 원본이름
			Date today = new Date(System.currentTimeMillis());
			String ext = oriName.substring(oriName.lastIndexOf("."));
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
			int random = (int) (Math.random() * 10000) + 1;
			String rename = sdf.format(today) + "_" + random + ext;
			try {
				upFile.transferTo(new File(path + rename));
				ApproveAttach aa = ApproveAttach.builder().oriName(oriName).saveName(rename).build();
				int result3 = service.insertApproveAttach(aa); // 첨부파일 테이블 생성
				if(result3<1)flag=false;
			} catch (IOException e) {
				e.printStackTrace();
			}
		}

		if (paraApp != null) {
			for (int i = 0; i < paraApp.length; i++) {
				Map<String, Object> param = new HashMap<>();
				param.put("memberId", paraApp[i]);
				param.put("order", i + 1);
				int result4 = service.insertApproveLine(param); // 결재선 테이블 추가
				if(result4<1)flag=false;
			}
		}

		if (paraRefer != null) {
			for (int i = 0; i < paraRefer.length; i++) {
				Map<String, Object> param = new HashMap<>();
				param.put("memberId", paraRefer[i]);
				int result5 = service.insertReferLine(param); // 결재선 테이블 추가
				if(result5<1)flag=false;
			}
		}
		if (flag == true) {
			model.addAttribute("msg", "저장 성공");
			model.addAttribute("url", "/");
		} else {
			model.addAttribute("msg", "저장 실패");
			model.addAttribute("url", "/");
		}
		return "common/msg";
	}

	@RequestMapping("/reSaves.do") // 임시저장된 연장근무신청서에서 다시 임시저장하는 작업과  임시저장된 신청에서 바로 신청하는 작업
	public String reSaves(String memberId, String startDate, String startTime, String endTime, String endDate,
			String content, String title, String approveKind,String geuntae, String paraApp[], String paraRefer[], 
			String deleteApproveNo, String approveState,Model model,
			MultipartFile upFile, HttpSession session) throws ParseException{
		Member m = Member.builder().memberId(memberId).build();
		String path = session.getServletContext().getRealPath("/resources/upload/approve/"); //파일 저장 경로
		boolean flag = true;
		
		if(approveState==null){
			approveState = "임시저장";			
		}else {
			approveState = "결재대기";			
		}
		
		int approveNo = Integer.parseInt(deleteApproveNo);
		
		int result7 = service.removeSave(deleteApproveNo); // 기존에있던 기안서들과 그 안의 내용들 다 삭제한 후 다시 작성
		if(result7<1)flag=false;
		Approve ap = Approve.builder().approveNo(approveNo).approveTitle(title).approveContent(content).memberId(m).approveState(approveState).approveKind(approveKind).build();
		
		int result = service.reInsertApprove(ap); // 기안서 테이블 생성 
		if(result<1)flag=false;
		
		if (startTime!= null && endTime!=null) {
			startTime = startDate + " " + startTime;
			endTime = startDate + " " + endTime;
			DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm");
			Date date = df.parse(startTime);
			long stime = date.getTime();

			Date date2 = df.parse(endTime);
			long etime = date2.getTime();

			Timestamp st = new Timestamp(stime);
			Timestamp et = new Timestamp(etime);

			Time t = Time.builder().approveNo(approveNo).startTime(st).endTime(et).build(); // 시간테이블 생성
			int result2 = service.reInsertTime(t);
			if(result2<1)flag=false;
		}
		if(startTime == null && endTime ==null) {
			startTime = startDate + " " + "00:00";
			endTime = endDate + " " + "00:00";

			DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm");
			Date date = df.parse(startTime);
			long stime = date.getTime();

			Date date2 = df.parse(endTime);
			long etime = date2.getTime();

			Timestamp st = new Timestamp(stime);
			Timestamp et = new Timestamp(etime);

			Time t = Time.builder().approveNo(approveNo).startTime(st).endTime(et).build(); // 시간테이블 생성
			int result2 = service.reInsertTime(t);
			if(result2<1)flag=false;
		}
		

		if (!upFile.getOriginalFilename().equals("")) { // 첨부파일 추가했을경우
			String oriName = upFile.getOriginalFilename(); // 원본이름
			Date today = new Date(System.currentTimeMillis());
			String ext = oriName.substring(oriName.lastIndexOf("."));
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
			int random = (int) (Math.random() * 10000) + 1;
			String rename = sdf.format(today) + "_" + random + ext;
			try {
				upFile.transferTo(new File(path + rename));
				ApproveAttach aa = ApproveAttach.builder().oriName(oriName).saveName(rename).approveNo(approveNo).build();
				int result3 = service.reInsertApproveAttach(aa); // 첨부파일 테이블 생성
				if(result3<1)flag=false;
			} catch (IOException e) {
				e.printStackTrace();
			}
		}

		if (paraApp != null) {
			for (int i = 0; i < paraApp.length; i++) {
				Map<String, Object> param = new HashMap<>();
				param.put("memberId", paraApp[i]);
				param.put("order", i + 1);
				param.put("approveNo",approveNo);
				int result4 = service.reInsertApproveLine(param); // 결재선 테이블 추가
				if (result4<1)flag=false; 
			}
		}

		if (paraRefer != null) {
			for (int i = 0; i < paraRefer.length; i++) {
				Map<String, Object> param = new HashMap<>();
				param.put("memberId", paraRefer[i]);
				param.put("approveNo",approveNo);
				int result5 = service.reInsertReferLine(param); // 결재선 테이블 추가
				if (result5<1)flag=false; 
			}
		}
		
		if ((flag == true) && approveState.equals("임시저장")) {
			model.addAttribute("msg", "저장 성공");
			model.addAttribute("url", "/");
			return "common/msg";
		} 
		if ((flag == false) && approveState.equals("임시저장")) {
			model.addAttribute("msg", "저장 실패");
			model.addAttribute("url", "/");
			return "common/msg";
		}
		if ((flag == true) && approveState.equals("결재대기")) {
			model.addAttribute("msg", "재작성 성공");
			model.addAttribute("url", "/");
			return "common/msg";
		} 
		if ((flag == false) && approveState.equals("결재대기")) {
			model.addAttribute("msg", "재작성 실패");
			model.addAttribute("url", "/");
			return "common/msg";
		} 
		
		return "common/msg";
	}
	
	@RequestMapping("/saveAttendance.do") // 근태신청서 임시저장할때 사용하는 컨트롤러
	public String saveAttendance(String memberId, String startDate, String startTime, String endTime, String endDate,
			String content, String title, String geuntae, String paraApp[], String paraRefer[], MultipartFile upFile, Model model,
			HttpSession session) throws ParseException {
		Member m = Member.builder().memberId(memberId).build();
		String path = session.getServletContext().getRealPath("/resources/upload/approve/"); // 파일 저장 경로
		String approveState = "임시저장";
		boolean flag = true;
		
		Approve ap = Approve.builder().approveTitle(title).approveContent(content).memberId(m)
				.approveState(approveState).approveKind(geuntae).build();
		int result = service.insertApprove(ap); // 기안서 테이블 생성
		if(result<1)flag=false;
		
		if (geuntae.equals("반차") || geuntae.equals("외출")) { // endDate가 null일경우 -> 반차, 외출의 경우(한 날짜에서 시작시간과 끝시간을 고름)
			if (!startDate.equals("") && !startTime.equals("") && !endTime.equals("")) {
				startTime = startDate + " " + startTime;
				endTime = startDate + " " + endTime;
				DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm");
				Date date = df.parse(startTime);
				long stime = date.getTime();

				Date date2 = df.parse(endTime);
				long etime = date2.getTime();

				Timestamp st = new Timestamp(stime);
				Timestamp et = new Timestamp(etime);

				Time t = Time.builder().startTime(st).endTime(et).build();
				int result2 = service.insertTime(t);
				if(result2<1)flag=false;
			} else {
				Time t = Time.builder().startTime(null).endTime(null).build();
				int result2 = service.insertTime(t);
				if(result2<1)flag=false;
			}
		}

		if (geuntae.equals("연차") || geuntae.equals("보건") || geuntae.equals("경조")) { // -> 연차, 보건, 경조의 경우
			if (!startDate.equals("") && !endDate.equals("")) {
				startTime = startDate + " " + "00:00";
				endTime = endDate + " " + "00:00";
				DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm");
				Date date = df.parse(startTime);
				long stime = date.getTime();

				Date date2 = df.parse(endTime);
				long etime = date2.getTime();

				Timestamp st = new Timestamp(stime);
				Timestamp et = new Timestamp(etime);

				Time t = Time.builder().startTime(st).endTime(et).build();
				int result2 = service.insertTime(t);
				if(result2<1)flag=false;
			} else {
				Time t = Time.builder().startTime(null).endTime(null).build();
				int result2 = service.insertTime(t);
				if(result2<1)flag=false;
			}
		}

		if (!upFile.getOriginalFilename().equals("")) { // 첨부파일 추가했을경우
			String oriName = upFile.getOriginalFilename(); // 원본이름
			Date today = new Date(System.currentTimeMillis());
			String ext = oriName.substring(oriName.lastIndexOf("."));
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
			int random = (int) (Math.random() * 10000) + 1;
			String rename = sdf.format(today) + "_" + random + ext;
			try {
				upFile.transferTo(new File(path + rename));
				ApproveAttach aa = ApproveAttach.builder().oriName(oriName).saveName(rename).build();
				int result3 = service.insertApproveAttach(aa); // 첨부파일 테이블 생성
				if(result3<1)flag=false;
			} catch (IOException e) {
				e.printStackTrace();
			}
		}

		if (paraApp != null) {
			for (int i = 0; i < paraApp.length; i++) {
				Map<String, Object> param = new HashMap<>();
				param.put("memberId", paraApp[i]);
				param.put("order", i + 1);
				int result4 = service.insertApproveLine(param); // 결재선 테이블 추가
				if(result4<1)flag=false;
			}
		}

		if (paraRefer != null) {
			for (int i = 0; i < paraRefer.length; i++) {
				Map<String, Object> param = new HashMap<>();
				param.put("memberId", paraRefer[i]);
				int result5 = service.insertReferLine(param); // 결재선 테이블 추가
				if(result5<1)flag=false;
			}
		}
		if (flag == true) {
			model.addAttribute("msg", "저장 성공");
			model.addAttribute("url", "/");
		} else {
			model.addAttribute("msg", "저장 실패");
			model.addAttribute("url", "/");
		}
		return "common/msg";
	}

	
	@RequestMapping("/saveExpenditure.do") // 지출결의서 임시저장할때 사용하는 컨트롤러
	public String saveExpenditure(String memberId, String content, String title, String approveKind, String paraApp[],
			String paraRefer[], String account[], String useHistory[], String price[], MultipartFile upFile, Model model,
			HttpSession session) throws ParseException {
		boolean flag = true;
		Member m = Member.builder().memberId(memberId).build();
		String approveState = "임시저장";
		String path = session.getServletContext().getRealPath("/resources/upload/approve/"); // 파일 저장 경로

		Approve ap = Approve.builder().approveTitle(title).approveContent(content).memberId(m)
				.approveState(approveState).approveKind(approveKind).build();
		int result = service.insertApprove(ap); // 기안서 테이블 생성
		if(result<1)flag=false;
		
		if (!upFile.getOriginalFilename().equals("")) { // 첨부파일 추가했을경우
			String oriName = upFile.getOriginalFilename(); // 원본이름
			Date today = new Date(System.currentTimeMillis());
			String ext = oriName.substring(oriName.lastIndexOf("."));
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
			int random = (int) (Math.random() * 10000) + 1;
			String rename = sdf.format(today) + "_" + random + ext;
			try {
				upFile.transferTo(new File(path + rename));
				ApproveAttach aa = ApproveAttach.builder().oriName(oriName).saveName(rename).build();
				int result3 = service.insertApproveAttach(aa); // 첨부파일 테이블 생성
				if(result3<1)flag=false;
			} catch (IOException e) {
				e.printStackTrace();
			}
		}

		if (account != null) { // 지출결의서 내용 테이블 생성
			for (int i = 0; i < account.length; i++) {
				if (!account[i].equals("")) { // 내용부분이 비어있으면 생성 x
					Expenditure ex = Expenditure.builder().account(account[i]).useHistory(useHistory[i]).price(price[i])
							.build();
					int result6 = service.insertExpenditure(ex);
					if(result6<1)flag=false;
				}
			}
		}

		if (paraApp != null) {
			for (int i = 0; i < paraApp.length; i++) {
				Map<String, Object> param = new HashMap<>();
				param.put("memberId", paraApp[i]);
				param.put("order", i + 1);
				int result4 = service.insertApproveLine(param); // 결재선 테이블 추가
				if(result4<1)flag=false;
			}
		}

		if (paraRefer != null) {
			for (int i = 0; i < paraRefer.length; i++) {
				Map<String, Object> param = new HashMap<>();
				param.put("memberId", paraRefer[i]);
				int result5 = service.insertReferLine(param); // 결재선 테이블 추가
				if(result5<1)flag=false;
			}
		}

		if (flag == true) {
			model.addAttribute("msg", "저장 성공");
			model.addAttribute("url", "/");
		} else {
			model.addAttribute("msg", "저장 실패");
			model.addAttribute("url", "/");
		}
		return "common/msg";
	}
	
	@RequestMapping("/reSaveExpenditure.do") // 임시저장된 지출결의서에서 다시 임시저장하는 작업과 임시저장된 신청에서 바로 신청하는 작업
	public String reSaveExpenditure(String memberId, String content, String title, String approveKind, String paraApp[], String paraRefer[], 
			String deleteApproveNo, String account[], String useHistory[], String price[], String approvState, Model model,
			String approveState,MultipartFile upFile, HttpSession session) throws ParseException{
		Member m = Member.builder().memberId(memberId).build();
		String path = session.getServletContext().getRealPath("/resources/upload/approve/"); //파일 저장 경로
		
		boolean flag = true;
		
		
		if(approveState==null){
			approveState = "임시저장";			
		}else {
			approveState = "결재대기";			
		}
		
		int approveNo = Integer.parseInt(deleteApproveNo);
		
		int result7 = service.removeSave(deleteApproveNo); // 기존에있던 기안서들과 그 안의 내용들 다 삭제한 후 다시 작성
		if(result7<1)flag=false;
		Approve ap = Approve.builder().approveNo(approveNo).approveTitle(title).approveContent(content).memberId(m).approveState(approveState).approveKind(approveKind).build();
		int result = service.reInsertApprove(ap); // 기안서 테이블 생성 
		if(result<1)flag=false;
		
		if (account != null) { // 지출결의서 내용 테이블 생성
			for (int i = 0; i < account.length; i++) {
				if (!account[i].equals("")) { // 내용부분이 비어있으면 생성 x
					Expenditure ex = Expenditure.builder().approveNo(approveNo).account(account[i]).useHistory(useHistory[i]).price(price[i])
							.build();
					int result6 = service.reInsertExpenditure(ex);
					if(result6<1)flag=false;
				}
			}
		}
	
		if (!upFile.getOriginalFilename().equals("")) { // 첨부파일 추가했을경우
			String oriName = upFile.getOriginalFilename(); // 원본이름
			Date today = new Date(System.currentTimeMillis());
			String ext = oriName.substring(oriName.lastIndexOf("."));
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
			int random = (int) (Math.random() * 10000) + 1;
			String rename = sdf.format(today) + "_" + random + ext;
			try {
				upFile.transferTo(new File(path + rename)); // transferTo()메소드 통해 파일 저장
				ApproveAttach aa = ApproveAttach.builder().oriName(oriName).saveName(rename).build();
				int result3 = service.insertApproveAttach(aa); // 첨부파일 테이블 생성
				if(result3<1)flag=false;
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		
		
		if (paraApp != null) {
			for (int i = 0; i < paraApp.length; i++) {
				Map<String, Object> param = new HashMap<>();
				param.put("memberId", paraApp[i]);
				param.put("order", i + 1);
				param.put("approveNo",approveNo);
				int result4 = service.reInsertApproveLine(param); // 결재선 테이블 추가
				if(result4<1)flag=false;
			}
		}

		if (paraRefer != null) {
			for (int i = 0; i < paraRefer.length; i++) {
				Map<String, Object> param = new HashMap<>();
				param.put("memberId", paraRefer[i]);
				param.put("approveNo",approveNo);
				int result5 = service.reInsertReferLine(param); // 결재선 테이블 추가
				if(result5<1)flag=false;
			}
		}
		
		if ((flag == true) && approveState.equals("임시저장")) {
			model.addAttribute("msg", "저장 성공");
			model.addAttribute("url", "/");
			return "common/msg";
		} 
		if ((flag == false) && approveState.equals("임시저장")) {
			model.addAttribute("msg", "저장 실패");
			model.addAttribute("url", "/");
			return "common/msg";
		}
		if ((flag == true) && approveState.equals("결재대기")) {
			model.addAttribute("msg", "재작성 성공");
			model.addAttribute("url", "/");
			return "common/msg";
		} 
		if ((flag == false) && approveState.equals("결재대기")) {
			model.addAttribute("msg", "재작성 실패");
			model.addAttribute("url", "/");
			return "common/msg";
		} 
		
		return "common/msg";
	}


	@RequestMapping("/fullPayment.do") // 전결처리버튼 
	public String fullPayment(Model m, String approveNo,String mId,String writer,String approveKind) {
		Map<String, Object> param = new HashMap<>();
		param.put("approveNo",approveNo);
		param.put("approveKind", approveKind);
		param.put("writer", writer);
		param.put("mId", mId);
		param.put("state", "완료");
		
		
		int result = service.updateCompleteState(param);
		int result2 = service.allCompleteAppLine(param);
		
		if(approveKind.equals("연차")) {
			int cnt = service.timeDifference(param);
			String startDate = service.selectStartTime(param);
			param.put("startDate", startDate);
			for(int i=1; i<=cnt; i++) {
				param.put("i", i);
				service.insertAnnualLeave(param);
			}
		}
		
		if(approveKind.equals("반차")) {
			String startDate = service.selectStartTime(param);
			param.put("startDate", startDate);
			param.put("i", 0);
				service.insertAnnualLeave(param);
		}
		
		
		m.addAttribute("msg", "전결 성공");
		m.addAttribute("url", "/approve/waitingApprove.do?mId="+mId);
		/*
		 * if(result >= 1 && result2 >=1) { } else { m.addAttribute("msg", "전결 실패");
		 * m.addAttribute("url", "/approve/waitingApprove.do?mId="+mId); }
		 */
		return "common/msg";	
	}
	

	
	@PostMapping("/insertToDo") // 해당 유저의 todo 리스트 추가
	@ResponseBody  // ajax 처리할때 꼭 필요한 어노테이션 -> ResponseBody
	public ToDo todo(String mId, String content) {
		Map<String,Object> param= new HashMap<>();
		param.put("mId", mId);
		param.put("content", content);

		int result = service.insertToDo(param);
		int no = service.selectToDoNo();
		param.put("no", no);
		ToDo todo = service.selectToDoById(param);
	
		return todo; // 객체자체를 반환해서 js에서 태그로 만들어줌
	}
	
	@PostMapping("/deleteToDo") // 해당 유저의 todo 리스트 추가
	@ResponseBody  // ajax 처리할때 꼭 필요한 어노테이션 -> ResponseBody
	public String deleteToDo(String no) {
		Map<String,Object> param= new HashMap<>();
		param.put("no", no);

		int result = service.deleteToDo(param); 

		return no; // 번호자체를 반환
	}
}