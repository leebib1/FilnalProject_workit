package com.workit.member.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.workit.approve.model.dto.Approve;
import com.workit.approve.model.dto.ToDo;
import com.workit.approve.model.service.ApproveService;
import com.workit.board.model.dto.Board;
import com.workit.board.model.dto.Notice;
import com.workit.board.model.service.BoardService;
import com.workit.chatroom.service.ChatroomService;
import com.workit.member.model.vo.MemberVO;
import com.workit.member.service.MemberService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class MemberController {
	@Autowired
	private MemberService service;
	@Autowired
	private JavaMailSender javaMailSender;
	@Autowired
	private ChatroomService chatroomService;
	@Autowired
	private ApproveService aservice;
	@Autowired
	private BoardService bservice;
	
	//로그인 페이지
	@RequestMapping("/loginpage")
	public String loginpage() {
		return "member/login";
	}
	
	//로그인 실패 시
	@RequestMapping("/login/fail")
	public String loginFail(Model model) throws IllegalAccessException{
		model.addAttribute("msg","로그인 실패했습니다.");
		model.addAttribute("url","/loginpage");
		return "common/msg";
	}
	
	//로그인 성공 시
	@RequestMapping("/login/success")
	public String login(@RequestParam Map<String,Object> param, HttpSession session){
		MemberVO loginMember=(MemberVO)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		session.setAttribute("loginMember", loginMember); //로그인 정보 저장
		String memberId = loginMember.getMemberId();
		int unread = chatroomService.chatNotificationCount(memberId);
		session.setAttribute("unread", unread);
		if(loginMember.getEmail()==null) {
			return "member/firstLogin"; //email 인증이 안 된 경우 인증 화면 전환
		}else {
			return "redirect:/";			
		}
	}
	
	//권한 불일치
	@RequestMapping("/error/auth")
	public String errorAuth(Model model) throws IllegalAccessException{
		model.addAttribute("msg","사용 권한이 없습니다.");
		model.addAttribute("url","/");
		return "common/msg";
	}
	
	//로그인 안 하고 접근 시
	@RequestMapping("/error/login")
	public String errorLogin(Model model) throws IllegalAccessException{
		model.addAttribute("msg","로그인 후 이용 가능합니다.");
		model.addAttribute("url","/loginpage");
		return "common/msg";
	}
	
	//메인 페이지
	@GetMapping("/")
	public String mainpage(@RequestParam Map<String,Object> param, HttpSession session, Model m) {
		MemberVO loginMember=(MemberVO)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		String memberId = loginMember.getMemberId();
		String deptName = loginMember.getDept().getDeptName();

		param.put("processState","결재처리중");
		param.put("approveState", "결재대기");
		param.put("mId", memberId);
		param.put("deptName", deptName);
		List<Approve> approves= aservice.selectWaitingApproveTopFive(param); // 본인순서의 결재선 상위 5개 조회
		int approveCnt = aservice.selectSelectWaitingApproveCnt(param); // 본인순서의 결재선의 총 개수
		
		List<Notice> notices = bservice.selectNoticeTopFive();  // 공지사항 최근 5개 조회
		List<Board> boards = bservice.selectBoardTopFive(param); // 본인 부서 게시글 최근 5개 조회
		List<ToDo> toDos = aservice.selectToDoListById(param);
		
		m.addAttribute("approves",approves);
		m.addAttribute("approveCnt",approveCnt);
		m.addAttribute("notices",notices);
		m.addAttribute("boards",boards);
		m.addAttribute("toDos",toDos);
		
		return "index";
	}
	
	//마이 페이지 이동
	@GetMapping("/mypage")
	public String enrollView(Model model, HttpSession session) {
		String memberId=((MemberVO)session.getAttribute("loginMember")).getMemberId();
		
		model.addAttribute("approv",service.selectApprovMember(memberId));
		return "member/mypage";
	}
	
	//비밀번호 찾기 화면
	@GetMapping("/login/password")
	public String loginPwdView() {
		return "member/passwordReissue";
	}
	
	//로그아웃
	@GetMapping("/logout")
	public String logout(HttpServletRequest request, HttpServletResponse reponse) {
		new SecurityContextLogoutHandler().logout(request, reponse, SecurityContextHolder.getContext().getAuthentication());
		return "member/login";
	}
	
	//프로필 이미지 저장
	@PostMapping("/member/profile")
	public String updateProfile(MultipartFile profileImg, HttpSession session, Model model) {
		String path = session.getServletContext().getRealPath("/resources/upload/profile/"); //파일 저장 경로
		if (!profileImg.getOriginalFilename().equals("")) { //파일이 있으면 실행
			String oriName=profileImg.getOriginalFilename();
			Date today = new Date(System.currentTimeMillis());
			String ext=oriName.substring(oriName.lastIndexOf("."));
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
			int random = (int) (Math.random() * 10000) + 1;
			String rename = sdf.format(today) + "_" + random+ext;
			try {
				profileImg.transferTo(new File(path + rename));
			} catch (IOException e) {
				e.printStackTrace();
			}
			Map<String,Object> param=new HashMap<>();
			param.put("profileImg", rename);
			param.put("memberId", ((MemberVO)session.getAttribute("loginMember")).getMemberId());
			if(service.updateProfileImg(param)>0) {
				model.addAttribute("msg","프로필 수정되었습니다.");
				model.addAttribute("url","/mypage");
				session.setAttribute("loginMember", service.selectMemberByParam(param));
			}else {
				model.addAttribute("msg","프로필 수정 실패하였습니다.");
				model.addAttribute("url","/mypage");
			}
		}
		return "common/msg";
	}
	
	//사원 정보 변경 요청
	@PostMapping("/member/info")
	public String insertApprovMember(Model model, @RequestParam Map<String,Object> param) {
		if(service.insertApprovMember(param)>0) {
			model.addAttribute("msg","요청 전송하였습니다.");
			model.addAttribute("url","/mypage");
		}else {
			model.addAttribute("msg","요청 실패하였습니다.");
			model.addAttribute("url","/mypage");
		}
		return "common/msg";
	}
	
	//패스워드 변경
	@PostMapping("/member/password")
	@ResponseBody
	public int updatePwd(Model model, @RequestBody Map<String, Object> param) {
		return service.updateMember(param);
	}
	
	//첫 로그인 시 화면
	@GetMapping("/member/first")
	public String firstLoginView() {
		return "member/firstLogin";
	}
	
	//첫 로그인 데이터 업데이트
	@PostMapping("/member/first")
	public String fistLoginInfo(@RequestParam Map<String,Object> param, Model model) {
		if(service.updateMember(param)>0) {
			model.addAttribute("msg","인증 성공했습니다.");
			model.addAttribute("loc","/");
		}else{
			model.addAttribute("msg","인증 실패했습니다.");
			model.addAttribute("loc","/login/first");
		}
		
		return "common/msg";
	}
	
	//email 인증
	@PostMapping("/email")
	@ResponseBody
	public String sendEmail(@RequestParam(value="email") String email) {
		String key="";
		Random random=new Random();
		SimpleMailMessage message=new SimpleMailMessage();
		message.setTo(email);
		for(int i=0;i<4;i++) {
			int alpa=random.nextInt(25)+65; //A~Z 랜덤 알파벳 생성
			key+=(char)alpa;
		}
		int number=random.nextInt(9999)+1000; //4자리 랜덤 숫자
		key+=number;
		message.setSubject("workit 이메일 인증 코드입니다."); //메일 제목
		message.setText("인증 번호 : "+key);
		javaMailSender.send(message);
		return key;
	}
	
	//비밀번호 재발급
	@PutMapping("/email/password")
	@ResponseBody()
	public int passwordReissue(@RequestBody Map<String,Object> param) {
		String key="";
		Random random=new Random();
		SimpleMailMessage message=new SimpleMailMessage();
		message.setTo((String)param.get("email"));
		for(int i=0;i<2;i++) {
			key+=(char)((int)random.nextInt(25)+65); //A~Z 랜덤 알파벳 생성
			key+=(int)random.nextInt(); //랜덤 숫자
			key+=(char)((int)random.nextInt(25)+ 97); //a~z 랜덤 알파벳 생성
		}
		message.setSubject("workit 임시 비밀번호입니다."); //메일 제목
		message.setText("임시 비밀번호 : "+key);
		param.put("newPwd", key);
		if(service.updateMember(param)>0) {
			javaMailSender.send(message);
			return 1;
		}
		return 0;
	}
}
