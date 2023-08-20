<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>                            
<c:set var="path" value="${pageContext.request.contextPath }"/>
<!-- <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script> -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.js"></script>
<link rel="stylesheet"href="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.css" />
<div class="chatList-container section-shadow">
	<div class="chat-header">
		<h2 id="startChat">채팅</h2>
		<div class="chat-icon-container">
			<img src="${path}/resources/images/common/search.svg" alt="chat-search" class="searchIcon">
			<img src="${path}/resources/images/chat/addchat.svg" alt="chat-addChat" class="addChatIcon">
		</div>
	</div>
	<div class="chat-room-list chat-inner">
		<div class="modal-chat section-shadow modal-add-chatContainer chatHidden">
			<div class="modal-content modal-add-chat">
				<div class="modal-close">X</div>
				<h4 class="chatRoomPersonal">1:1 채팅</h4>
				<h4 class="chatRoomGroup">그룹 채팅</h4>
			</div>
		</div>
		<div class="modal-searchContainer chatHidden">
			<input type="search" name="searchChatList" placeholder="이름, 파일명 검색" class="modalSearchInput">
			<img src="${path}/resources/images/common/search.svg" alt="chat-search" class="modalSearchAllIcon">
		</div>
		<c:if test="${empty myChatroomList}">
			<div class="chat-room">
				<h3 class="title">참여 중인 채팅이 없습니다</h3>
			</div>
		</c:if>
		<c:if test="${not empty myChatroomList}">
			<c:forEach var="r" items="${myChatroomList}">
				<div class="chat-room chat-select" data-Id="${r.chatroom.chatroomId}" data-no="${r.myChatroomNo}" data-title="${r.chatroom.chatroomTitle}" data-code="${r.chatroom.chatroomCode}">
					<h5 class="chatroom-title chat-select">${r.chatroom.chatroomTitle}</h5>
					<img src="${path}/resources/images/common/more.svg" alt="chat-delete" class="deleteChatRoom" data-cNo="${r.myChatroomNo}">
					<input type="hidden" value="${r.myChatroomNo}" name="chatRoomNo" class="roomNo">
					<h5>${r.myChatroomNo}</h5>
					<c:if test="${not empty unreadMap}">
						<c:forEach var="unread" items="${unreadMap}">
							 <c:if test="${r.myChatroomNo == unread.myChatroomNo && unread.readCount!=0}">
								<span class="chatroomNotifyNumber">${unread.readCount}</span>
							</c:if>
							<input type="hidden" value="${unread.myChatroomNo}" name="myChatroomNo" class="myChatroomNo">
						</c:forEach>
					</c:if>
					<c:if test="${not empty chat}">
						<c:forEach var="c" items="${chat}">
							<c:if test="${r.chatroom.chatroomId == c.chatroomId}">
								<span class="chat-content chat-select">${c.chatContent}</span>
								<span class="chat-date chat-select"><fmt:formatDate value="${c.chatDate}" type="both" pattern="yyyy-MM-dd (E) hh:mm:ss"/></span>
								<input type="hidden" value="${c.chatroomId}" name="chatRoomId" class="roomId">
							</c:if>
						</c:forEach>
					</c:if>
				</div>
			</c:forEach>
		</c:if>
	</div>
</div>
<div class="modal-view-chatMemberProfile">
	<div class="modal-content section-shadow scroll">
		<h2>채팅 중인 회원 정보 보기</h2>
	</div>
</div>
<div class="searchResultContainer chatHidden">
	<div class="modal-content section-shadow scroll">
		<div class="modal-searchContainer">
			<input type="search" name="searchChatList" placeholder="이름, 파일명 검색" class="modalSearchInput">
			<img src="${path}/resources/images/common/search.svg" alt="chat-search" class="modalSearchAllIcon">
			<button class='modal-close-up'>닫기</button>
		</div>
	</div>
</div>
<div class="chatroomFileContainer chatHidden">
	<div class="modal-content section-shadow scroll"></div>
</div>
<script>
	window.onload = function() {
	    fn_updateChatNotify();
	};
	
	// 채팅방 나가기
	$("img.deleteChatRoom").click(function() {
		event.stopPropagation();
		chatroomId = $(this).next().val();
		fn_deleteChatroom(chatroomId);
	}) 
	
	let chatroomId= '${chatroomId}';
	let loginMember = '${loginMember.memberId}';
	let loginMemberName = '${loginMember.memberName}';
	let chatroomContainer = $(".chat-room-list");
	let chatroomTitle;
	let myChatroomNo;
	let chatroomCode;
	var readCount;
	
	$(".chat-room").click(function() {
		var clickedDiv = $(this);
		chatroomId = clickedDiv.data("id"); 
		myChatroomNo = clickedDiv.data("no");
		chatroomTitle = clickedDiv.data("title");
		chatroomCode = clickedDiv.data("code");
		$(".chat-msgBox-container").empty();
		if(chatroomCode=='P') $(".addPersonIcon").css("display","none");
		fn_openChatroom();
	 });
	var chatMsg;
	
	const fn_openChatroom=()=>{
		$(".prev-chat").empty();
		
		$.ajax({
			url: "${path}/chat/chatroom/"+chatroomId,
			type: "post",
			data: {
				chatroomId: chatroomId,
				myChatroomNo : myChatroomNo
			},
			success: function(data) {
				
				if(data == null || data == "" ){
					$(".chat-header .title-container .title").text(chatroomTitle);
					fn_startChat();
				}else{
					fn_viewChatMsg(data);
					fn_startChat();
					fn_updateChatNotify();
					$(".chatroomNotifyNumber").addClass("chatHidden");
				}
			},
			error: function(xhr, status, error) {
				console.error('AJAX Error:', error);
			}
		});
	}
	
	let chatroomMembers = ""; // 현재 채팅 멤버 
	let chatroomFiles;
	let divPrevChat;
	let chatroomMemberName = "";
	let chatroomMemberIds = "";
	
	const fn_viewChatMsg=(data)=>{
		console.log("chatMsg method");
		console.log(data);
		divPrevChat = $("<div>").attr("class","prev-chat");
		
		// 현재 채팅 방에 참여 중인 회원 가져오기
		var chatroomMember = data.chatMember;
		chatroomMember.forEach(member =>{
			console.log("chatroommember : ", member.member.memberName);
			chatroomMembers += member.member.memberName+",";
			chatroomMemberIds += member.member.memberId+","; 
		})
		chatroomMembers = chatroomMembers.slice(0,-1);
		chatroomMemberIds = chatroomMemberIds.slice(0,-1);
		var chatList = data.chatList;
		chatList.forEach(chat =>{
			var chats = chat.chat;
			chats.forEach(c=>{
				const cDate = new Date(c.chatDate);
				const chatDate = cDate.toLocaleString('ko-KO');
				if (c.member.memberId == loginMember) {
					var chatMsg = $("<div>").attr("class", "chat-msg chat-send");
					chatMsg.append($("<span>").attr("class", "chat-msgbx").text(c.chatContent));
					chatMsg.append($("<span>").attr("class", "chat-date block").text(chatDate));
					chatMsg.append($("<input type='hidden'>").attr("value",c.chatId).attr("class","chat-msg-Id"));
				}else {
					var chatMsg = $("<div>").attr("class", "chat-msg");
					chatMsg.append($("<div class='chatMember'>").append($("<h5>").text(c.member.memberName)).append($("<input>").attr("type", "hidden").attr("value", c.member.memberId).addClass("chatMemberId")));
					chatMsg.append($("<span>").attr("class", "chat-msgbx").text(c.chatContent));
					chatMsg.append($("<span>").attr("class", "chat-date block").text(chatDate));
					chatMsg.append($("<input type='hidden'>").attr("value",c.chatId).attr("class","chat-msg-Id"));
				}
				chatMsg.append($("<input>").attr("type", "hidden").attr("value", data.chatroomId).attr("class","roomId"));
				chatMsg.append($("<input>").attr("type", "hidden").attr("value", chatroomMembers).attr("class","chatroomMembers"));
				chatMsg.append($("<input>").attr("type", "hidden").attr("value", chatroomMemberIds).attr("class","chatroomMemberIds"));
				divPrevChat.append(chatMsg);
				$(".chat-fileform input[type='hidden']").attr("value",data.chatroomId);
			})
			$(".chatRoom-container .chat-room-inner .chat-msgBox-container").append(divPrevChat);
		})
	}
	
	const fn_viewChatroomFile=(data)=>{
			chatroomFiles.forEach(f=>{
				divPrevChat.append(chatMsg);
				const fDate = new Date(f.fileId.uploadDate);
				const chatfileDate = f.fileId.uploadDate.toLocaleString('ko-KO');
				var chatMsg = $("<div>").attr("class", "chat-msg");
				chatMsg.append($("<img class='fileName'>").attr("src","${path}/resources/images/common/attach.svg").css("width","16px"));
				chatMsg.append($("<span>").attr("class", "fileName chat-msgbx").text(f.fileId.originalFile));
				chatMsg.append($("<span>").attr("class", "chat-date").text(chatfileDate));
				chatMsg.append($("<input type='hidden'>").attr("value",f.fileId.fileId).attr("class","chat-msg-Id"));
				divPrevChat.append(chatMsg);
			})
	}
	
	$(".modalSearchAllIcon").click(e => {
		const keyword = $(e.target).prev().val();
		
		$.ajax({
			url: "${path}/chat/keyword",
			type: "post",
			data: {
				keyword: keyword
			},
			success: data => {
				$(".chat-room-nothing").addClass("chatHidden");
				fn_viewSearchResult(data);
			},
			error: function(xhr, status, error) {
				console.error('AJAX Error:', error);
			}
		});
	})
	
	var formData = new FormData();
	
	
	const fn_deleteChatroom=(chatroomId)=>{
		swal({
			title : '채팅방 나가기',
			text : "한 번 나간 채팅방의 내용은 복구되지 않습니다. 삭제 하시겠습니까?", 
			type : 	'warning',
			showCancelButton : true,
			confirmButtonClass : "btn-danger",
			confirmButtonText : "삭제",
			cancelButtonText : "취소",
			closeOnConfirm : false,
			closeOnCancel : true
			}, function(isConfirm) {
				if(isConfirm){
					$.ajax({
						url: "${path}/chat/delete",
						method: "delete",
						data: {
							chatroomId: chatroomId,
							loginMember: loginMember
						},
						success: data => {
							console.log(data);
							if (data > 0) {
								swal('',"채팅 방 나가기 성공했습니다." , "success");
								fn_closeChatModal();
								location.href = location.href;
							} else {
								swal('',"채팅 방 나가기 실패했습니다." , "failed");
							}
						},
						error: function(xhr, status, error) {
							console.error('AJAX Error:', error);
						}
					});
				}else {
					swal("채팅 방 삭제가 취소되었습니다.");
				}
			}
		);
	}
	
</script>
</body>
</html>
