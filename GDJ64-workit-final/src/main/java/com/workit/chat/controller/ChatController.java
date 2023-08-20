package com.workit.chat.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.workit.chat.model.dto.Chatroom;
import com.workit.chat.model.dto.MyChatroom;
import com.workit.chat.service.ChatService;
import com.workit.chatroom.model.dto.ChatNotificationVO;
import com.workit.chatroom.service.ChatroomService;
import com.workit.member.model.dto.Member;
import com.workit.member.model.vo.MemberVO;

import lombok.extern.slf4j.Slf4j;



@Controller
@RequestMapping("/chat")
@Slf4j
public class ChatController {
	
	private ChatService chatService;
	private ChatroomService chatroomService;
	
	public ChatController(ChatService chatService, ChatroomService chatroomService) {
		this.chatService = chatService;
		this.chatroomService = chatroomService;
	}
	
	// 로그인한 회원 아이디로 채팅 방 조회 
	@RequestMapping("/")
	public String selectMyChatroomById(Model model, HttpSession session){
		MemberVO loginMember = (MemberVO)session.getAttribute("loginMember");
		Map<String, Object> param = chatService.selectMyChatroomList(loginMember.getMemberId());
		model.addAttribute("chat",param.get("chat"));
		model.addAttribute("myChatroomList",param.get("myChatroomList"));
		model.addAttribute("members", param.get("members"));
		model.addAttribute("dept",param.get("dept"));
		model.addAttribute("unreadMap", param.get("unreadMap"));
		return "/chat/chat";
	}
	
	// 선택한 채팅 방 정보 조회
		@PostMapping("/chatroom/{chatroomId}")
		@ResponseBody
		public ResponseEntity<?> selectChatroom(@RequestParam(value="chatroomId")String chatroomId, @RequestParam int myChatroomNo, HttpSession session, Model model) {
			Map<String, Object> result = chatService.selectChatroomByroomId(chatroomId);
			int delResult = chatroomService.deleteNotify(myChatroomNo);
			if(delResult>0) {
				ChatNotificationVO c = ChatNotificationVO.builder().myChatroomNo(myChatroomNo).readCount(0).build();
				model.addAttribute("unreadMap",c);
				result.put("readCount", c);
			}
			
			result.put("chatMember", chatService.selectCurrentChatMembers(chatroomId));
			result.put("chatList", chatroomService.selectChatroomByroomId(chatroomId));
			log.info("chatroom result");
			return ResponseEntity.ok().body(result);
		}
	
	// 채팅 방 목록에서 검색
	@PostMapping("/keyword")
	@ResponseBody
	public ResponseEntity<?> searchAllByKeyword(@RequestParam(value="keyword")String keyword, Model model){
		return ResponseEntity.ok().body(chatService.searchByKeyword(Map.of("keyword",keyword)));
	}
	
	// 새로운 채팅 방 생성
	@PostMapping("/insert")
	@ResponseBody
	public ResponseEntity<?> insert(@RequestBody Chatroom chatroom, HttpSession session, Model model) {
		MemberVO m = (MemberVO)session.getAttribute("loginMember");
		String loginMember = m.getMemberId();
		log.info("{}", chatroom);
		String chatroomId = chatService.insertChatroom(loginMember, chatroom);
		@SuppressWarnings("unchecked")
		List<MyChatroom> chatroomMembers = (List<MyChatroom>) chatService.selectChatroomByroomId(chatroomId).get("chatroomMember");
		model.addAttribute("chatroomMembers", chatroomMembers);
		model.addAttribute("myChatroomList",chatroomService.selectChatroomById(chatroomId));
	    return ResponseEntity.ok().body(chatroomService.selectChatroomById(chatroomId));
	}
	
	// 채팅 방 나가기
	@DeleteMapping("/delete")
	@ResponseBody
	public int deleteMyChatroom(@RequestParam(value="chatroomId")String chatroomId, @RequestParam(value="loginMember")String loginMember) {
		return chatService.deleteMyChatroom(Map.of("chatroomId",chatroomId, "loginMember",loginMember));
	}
	// 채팅 방 멤버 조회
	@PostMapping("/member")
	@ResponseBody
	public List<Member> selectChatMemberById(@RequestParam(value="chatroomId")String chatroomId){
		return chatService.selectMemberAll();
	}
	
	// 안 읽은 채팅 알림 개수 조회
	@PostMapping("/notify")
	@ResponseBody
	public int chatNotificationCount(@RequestParam String memberId) {
		return chatroomService.chatNotificationCount(memberId);
	}
	
}
