<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>                            
 <c:set var="path" value="${pageContext.request.contextPath }"/>     
<link rel="stylesheet" href="${path}/resources/css/common/common.css">
<link rel="stylesheet" href="${path}/resources/css/chat/chat.css">
<div class="modal-addChatMember chatHidden scroll">
	<div class="modal-content section-shadow">
		<h2 class="title">채팅 멤버 선택</h2>
		<div class="chat-DeptContainer">
			<div class="modal-new-chat-title">
				<label for="chatroomTitle">채팅 제목 : </label><input type="text" name="chatroomTitle" placeholder="채팅 제목"><br>
				<span>채팅 제목 입력 하지 않으면 참여 멤버 이름, 참여 멤버 수로 설정됩니다</span>
			</div>
			<c:if test="${not empty dept && not empty members}">
				<c:forEach var="dept" items="${dept}">
					<div class="dept-list-container section-shadow">
						<h4 class="dept-title"><c:out value="${dept.deptName}"/></h4>
						<form class="modal-memberList chatHidden">
							<c:forEach var="member" items="${members }">
								<c:if test="${dept.deptCode == member.dept.deptCode && member.memberId!=loginMember.memberId}">
									<label for="memberId"><input type="checkbox" name="memberId" value="${member.memberId }"><span><c:out value="${member.memberName }"/></span><c:out value="${member.job.jobName }"/></label>
								</c:if>
							</c:forEach>
						</form>
					</div>
				</c:forEach>
				<button class="modal-addchatBtn">채팅 시작</button>
				<button class="modal-close-up">닫기</button>
			</c:if>
		</div>
	</div>
</div>
<div class="modal-updateChat chatHidden">
	<div class="modal-content section-shadow">
		<h2 class="title">채팅 멤버 선택</h2>
		<div class="chat-DeptContainer">
			<div class="modal-new-chat-title chatHidden">
				<label for="chatroomTitle">채팅 제목 : </label><input type="text" name="chatroomTitle" placeholder="채팅 제목"><br>
			</div>
			<div class="currentChatMember"></div>
			<c:if test="${not empty dept && not empty members}">
				<c:forEach var="dept" items="${dept}">
					<div class="dept-list-container section-shadow">
						<h4 class="dept-title"><c:out value="${dept.deptName}"/></h4>
						<form class="modal-memberList chatHidden">
							<c:forEach var="member" items="${members }">
								<c:if test="${dept.deptCode == member.dept.deptCode && member.memberId!=loginMember.memberId}">
									<label for="memberId">
										<input type="checkbox" name="memberId" value="${member.memberId }"><span><c:out value="${member.memberName }"/></span><c:out value="${member.job.jobName}"/>
									</label>
								</c:if>
							</c:forEach>
						</form>
					</div>
				</c:forEach>
				<button class="modal-update-chat-btn">변경</button>
				<button class="modal-close-up">닫기</button>
			</c:if>
		</div>
	</div>
</div>
<div class="chatRoom-container section-shadow">
	<div class="chat-header">
		<div class="title-container">
			<h3 class="title"></h3>
			<span class="chat-member"></span>
		</div>
		<div class="chat-icon-container chatHidden">
			<img src="${path}/resources/images/common/search.svg" alt="chat-search" class="searchChatroomIcon">
			<img src="${path}/resources/images/common/attach.svg" alt="chat-attach" class="attachChatIcon">
			<img src="${path}/resources/images/chat/addPerson.svg" alt="chat-addPerson" class="addPersonIcon">
		</div>
	</div>
	<div class="chat-room-inner">
		<div class="modalNewChat section-shadow chatHidden"></div>
		<div class="chat-room-nothing">
			<img src="${path}/resources/images/common/workit.svg">
			<h2 class="title">선택한 채팅이 없습니다</h2>
		</div>
		<div class="modal-searchRoomContainer chatHidden">
			<input type="search" name="searchChatRoomList" class="modal-searchRoomInput" placeholder="검색">
			<img src="${path}/resources/images/common/search.svg" alt="chat-search" class="modalChatSearchIcon">
		</div>
		<div class="modal-result-container chatHidden"></div>
		<div class="chat-msgBox-container scroll"></div>
	</div>
	<div class="chat-input-container chatHidden">
		<form action="" class="chat-fileform" method="post" enctype="multipart/form-data">
			<input type="file" name="uploadFile" multiple class="chat-upFile chatHidden">
			<img src="${path}/resources/images/common/attach.svg" alt="uploadIcon" class="chat-fileIcon"/>
			<input type="hidden" name="chatroomId"/>
		</form>
		<input type="text" name="chat-msg" class="chat-msg-input">
		<button class="sendChat">send</button>
	</div>
</div>
<script>
	let currentUrl = window.location.href;
	var dgs = currentUrl.slice(7);
	var sdg = dgs.slice(0, -5);
	currentUrl = sdg;

	const fn_fileSend=()=>{
		console.log("id :",chatroomId);
		var files = document.querySelector(".chat-upFile").files;
		var originalFile;
		if(files!=null || files!=""){
			for(let i = 0; i<files.length; i++){
				console.log(files[i].name);
				originalFile = files[i].name;
				websocket.send(JSON.stringify(new Chat("file", loginMember, originalFile, today))); 
			}
		}
	};
	
	$(".chat-fileIcon").click(e=>{
		$(".chat-upFile").click();
	});
	// 파일 업로드
	var formData = new FormData();
	$(".chat-upFile").change(e=>{
		let files = document.querySelector(".chat-upFile").files[0];
		console.log("files ",files);
		formData.append("chatroomId",chatroomId);
		formData.append("files",files);
		
		$.ajax({
			url : "${path}/chatroom/upload",
			data : formData,
			type : "post",
			async : true,
			enctype : "multipart/form-data",
			processData : false,
			contentType : false,
			success : data =>{
				console.log(data);
				fn_fileSend();
			},
			error: function(xhr, status, error) {
		        console.error('AJAX Error:', error);
		    }
		});
	});
	
	// 채팅 멤버 변경 모달 창에서 변경 클릭 메소드
	$(".modal-update-chat-btn").click(e=>{
		let selectedMember = $(".modal-memberList input:checked");
		let chatroomTitle = selectedMember.next().text();
		console.log("chatroommember ; ", chatroomMembers);
		if(selectedMember.length>0){
			chatMember = selectedMember.val();
			$.ajax({
				url: "${path}/chatroom/update",
				type: "post",
				data:{
					chatroomId : chatroomId,
					chatMember : chatMember,
					chatroomTitle : chatroomTitle
				},
				success: data => {
					console.log(data);
					if(data>0){
						swal("채팅 멤버 업데이트", "채팅 멤버 초대에 성공했습니다 :)", "success");
						fn_closeChatModal();
						fn_openChatroom();
					}else{
						swal("", "채팅 멤버 초대에 실패했습니다 ;<", "warning");
						fn_closeChatModal();
					}
				},
				error: function(xhr, status, error) {
			        console.error('AJAX Error:', error);
			    }
			});
		}else if((chatroomTitle=="" || chatroomTitle==null || chatroomTitle=="null") && (selectedMember ==null && selectedMember=="")){
			swal("", "선택된 멤버가 없습니다. ;<", "warning");
		}
	})
	
	
	var chatMember="";
	$(".modal-addchatBtn").click(e=>{
		var chatroomCode;
		let chatroomTitle;
		let selectedMember = $(".modal-memberList input:checked");
		if($("input[name=chatroomTitle]").val()==null ||$("input[name=chatroomTitle]").val()==""){
			console.log("제목없음 : ",selectedMember.next().text());
			chatroomTitle = selectedMember.next().text() + loginMemberName + " (" + (selectedMember.length + 1) + " )";
		}else{
			chatroomTitle = $("input[name=chatroomTitle]").val();
		}
		var newChatroom;
		if(selectedMember.length==1){
			chatMember = selectedMember.val();
			newChatroom = new Chatroom("", 'P', chatroomTitle, "", chatMember);
		}else{
			for(let i=0;i<selectedMember.length;i++){
				console.log(i,selectedMember[i].value);
				chatMember+=selectedMember[i].value+",";
			}
			chatMember = chatMember.slice(0, -1);
			newChatroom = new Chatroom("", 'G', chatroomTitle, "", chatMember);
		}
		if(chatMember==null || chatMember==""){
			swal("", "선택한 채팅 멤버가 없습니다 다시 선택해주세요", "warning");
		}else if(chatMember!=null && chatMember!=""){
			$.ajax({
				url: "${path}/chat/insert",
				type: "post",
				data:JSON.stringify(newChatroom),
				contentType:"application/json;charset=utf-8",
				success: data => {
					console.log("insert Data ",data);
					fn_closeChatModal();
					swal("새로운 채팅 생성 성공", "채팅 방이 생성 되었습니다.", "success");
					location.href = location.href;
				},
				error: function(xhr, status, error) {
			        console.error('AJAX Error:', error);
			    }
			});
		}
	});
	

	let sendDate = new Date();
	const timeElapsed = Date.now();
	const today = new Date(timeElapsed);
	
	// 채팅 방에서 채팅 멤버 추가
	$(".addPersonIcon").click(e => {
		chatroomMembers =  $(".chatroomMembers").val();
		chatroomMemberIds = $(".chatroomMemberIds").val();
		/* console.log("chatroomMembers : " , chatroomMembers);
		var cmember = $("<span>").text(chatroomMembers);
		$(".modal-updateChat .modal-content .currentChatMember").append(cmember); */
		
		if(chatroomMemberIds != null || chatroomMemberIds != ""){
			chatroomMemberIds = chatroomMemberIds.split(",");
		}
		
		$(".chat-room-nothing").attr("class","chatHidden");
		$(".modal-addChatMember").css("display","block");
		
		let input = $(".modal-memberList input[name=memberId]");
		let inputArr = Object.values(input);
		var cMember="";
		
		inputArr.forEach(a=>{
			if(chatroomMembers!=null){
				chatroomMemberIds.forEach(e=>{
					if((a.value)==e) {
						$(a).css("display","none");
						$(a).parent().css("display","none");
					} 
				})			
			}
		})
	})
	// 웹소켓 시작
	var websocket;
	const fn_startChat=()=>{
		$(".chatRoom-container .chat-header .chat-icon-container").css("display","flex");
		$(".chat-header .title-container .title").text(chatroomTitle);
		$(".chat-room-nothing").attr("class","chatHidden");
		$(".chat-input-container").css("display","flex");
		
		websocket= new WebSocket("ws://"+currentUrl+"chating/"+chatroomId);
		websocket.onopen=data=>{
			console.log(data);
		}
		// 메세지 받았을 때 
		websocket.onmessage=data=>{
			console.log(data);
			const receiveMsg=JSON.parse(data.data);
			fn_printChat(receiveMsg);
			$(".chat-msg-input").val("");
		}
		websocket.onclose=data=>{
			console.log(data);
			swal({
				title : '채팅 새로고침',
				text : "채팅 서버와 연결이 끊어졌습니다. 다시 연결 하시겠습니까?", 
				type : 	'warning',
				showCancelButton : true,
				confirmButtonClass : "btn-danger",
				confirmButtonText : "연결",
				cancelButtonText : "취소",
				closeOnConfirm : false,
				closeOnCancel : true
				},
				function(isConfirm) {
					if(isConfirm) location.href = location.href;
			});
		}
		// 받은 채팅 메세지 출력
	 	function fn_printChat(msg){
			
			const chatDiv = $(".chat-msgBox-container");
			const chatDate = new Date(msg.chatDate).toLocaleString('ko-KO');
			
	 		$.ajax({
				url: "${path}/chatroom/member",
				type: "post",
				data: {
					chatroomId: chatroomId
				},
				success: data => {
					console.log(data);
					if (msg.memberId == loginMember) {
						var chatMsg = $("<div>").attr("class", "chat-msg chat-send");
						chatMsg.append($("<span>").attr("class", "chat-date").text(chatDate));
						chatMsg.append($("<span>").attr("class", "chat-msgbx").text(msg.chatContent));
						chatMsg.append($("<input type='hidden'>").attr("value",msg.chatId).attr("class","chat-msg-Id"));
			
					} else {
						var chatMsg = $("<div>").attr("class", "chat-msg");
						data.forEach(m =>{
							console.log(m);
							if(m.member.memberId == msg.memberId){
								chatMsg.append($("<h5>").text(m.member.memberName));
							}
						})
						chatMsg.append($("<span>").attr("class", "chat-msgbx").text(msg.chatContent));
						chatMsg.append($("<span>").attr("class", "chat-date").text(chatDate));
						chatMsg.append($("<input type='hidden'>").attr("value",msg.chatId).attr("class","chat-msg-Id"));
					}
					chatMsg.append($("<input>").attr("type", "hidden").attr("value", msg.chatroomId).attr("class","roomId"));
					chatDiv.append(chatMsg);
				},
				error: function(xhr, status, error) {
			        console.error('AJAX Error:', error);
			    }
			});
	 		
		}
	}
	
	// 채팅 전송 	
	$(".sendChat").click(e=>{
		const chatContent=$(".chat-msg-input").val();
		websocket.send(JSON.stringify(new Chat(chatroomId, loginMember, chatContent, today)));
	});
	
	// 파일 아이콘 클릭
	$(".attachChatIcon").click(e=>{
		$(".modal-result-container").toggle("chatHidden");
		$(".chatroomFileContainer .modal-content").empty();
		$.ajax({
			url: "${path}/chatroom/file",
			type: "post",
			data: {
				chatroomId: chatroomId
			},
			success: data => {
				let chatfilebx;
				console.log(data.length);
				if(data.length>0){
					$(".chatroomFileContainer").css("display","block");
					chatfilebx = $("<div class='chatroom-file-container'>");
					chatfilebx.append($("<h2 class='title'>").text("현재 채팅 창 파일 목록").css("textAlign","center"));
					chatfilebx.append($("<span>").text("* 파일 제목을 선택하면 다운로드 됩니다.").css("textAlign","center"));
					let fileList = data[0].chatroomFile;
					fileList.forEach(e=>{
						const uploadDate = new Date(e.fileId.uploadDate).toLocaleString('ko-KO');
						console.log(e.fileId.originalFile);
						chatfileDiv = $("<div class='chatroom-file chat-msgbx'>");
						let clickTag = $("<a class='chatroomfileId'>").text(e.fileId.originalFile);
						chatfileDiv.append(clickTag);
						chatfileDiv.append($("<span>").text("업로드 날짜 : " + uploadDate));
						chatfileDiv.append($("<input type='hidden'>").attr("value",e.fileId.uploadFile));
						chatfilebx.append(chatfileDiv);
						$(".chatroomFileContainer .modal-content").append(chatfilebx);
					})
						$(".chatroomFileContainer .modal-content").append($("<button class='modal-close'>").text("닫기"));
				}else{
					swal("", "해당 채팅 창에 파일이 없습니다 =]", "warning");
					
				}
			},
			error: function(xhr, status, error) {
		        console.error('AJAX Error:', error);
		    }
		});
	})
	$(document).on("click", ".chatroomfileId", function (e) {
		let originalFile = $(e.target).text();
		let uploadFile = $(e.target).next().next().val();
		console.log(" originalFile : " + originalFile + " uploadFile : "+ uploadFile);
		$.ajax({
			url : "${path}/chatroom/download/"+ uploadFile,
			type : "get",
			xhrFields: {
	            responseType: "blob" // 응답 데이터 형식을 blob으로 설정
	        },
			success : data =>{
				var url = window.URL.createObjectURL(data);
	            var a = document.createElement("a");
	            a.style.display = "none";
	            a.href = url;
	            a.download = originalFile;
	            document.body.appendChild(a);
	            a.click();
	            window.URL.revokeObjectURL(url);
	            
			},
			error: function(xhr, status, error) {
		        console.error('AJAX Error:', error);
		    }
		})
	});
	
	$(".modalChatSearchIcon").click(e => {
		$(".modal-result-container").empty();
		let keyword = $(e.target).prev().val();
		if(keyword==null || keyword=="" || keyword=="null"){
			swal("", "검색어를 입력해주세요", "warning");
		}else{
			$.ajax({
				url : "${path}/chatroom/search",
				type : "post",
				data : {
					chatroomId : chatroomId,
					keyword : keyword
				},
				success : data =>{
					$(".modal-result-container").empty();
					fn_viewSearchResult(data);
				},
				error: function(xhr, status, error) {
				       console.error('AJAX Error:', error);
				   }
			})
		}
	});  
	
	let myChatList;
	let mychatFileList;
	let mychatroomList;
	
	const fn_viewSearchResult=(data)=>{
		if(data!=null || data!=""){
			$(".modal-result-container").css("display","block");
			myChatList = data.myChatList;
			mychatFileList = data.mychatFileList;
			mychatroomList = data.mychatroomList;
			$(".modal-result-container").append($("<h3 class='modalResult'>").text("검색 결과 : "));
			if(myChatList!=null || myChatList!="" && mychatFileList!=null || mychatFileList!="" && mychatroomList!=null || mychatroomList!="" ){
				var searchDiv;
				myChatList.forEach(m=>{
					const chatDate = new Date(m.chatDate).toLocaleDateString('ko-KO');
					console.log("m : ",m);
					searchDiv = $("<div class='chatroom-file chat-msgbx'>").text(m.chatContent);
					searchDiv.append($("<span>").text(chatDate));
					$(".modal-result-container").append(searchDiv);
				})
				mychatFileList.forEach(f=>{
					const uploadDate = new Date(f.fileId.uploadDate).toLocaleDateString('ko-KO');
					console.log("f : ", f);
					console.log(f.fileId.originalFile);
					searchDiv = $("<div class='chat-msgbx'>").text(f.fileId.originalFile);
					searchDiv.append($("<span>").text(uploadDate));
					$(".modal-result-container").append(searchDiv);
				})
				mychatroomList.forEach(c=>{
					console.log("c : ",c);
					searchDiv = $("<div class='chat-msgbx'>").text(c.chatroomTitle);
					$(".modal-result-container").append(searchDiv);
				})
			}
		}
	}

	
	$(document).on("click", ".searchResultclose", function(e) {
 		$(".searchResultContainer").css("display","none");
 	});
	
	$(document).on("click", ".chatMember", function(e) {
		$(".modal-view-chatMemberProfile .modal-content").empty();
		memberId = $(e.target).next().val();
		$(".modal-view-chatMemberProfile").css("display","block");
		$.ajax({
			url : "${path}/chatroom/profile",
			type : "POST",
			data : {
				memberId : memberId
			},
			success : data =>{
				console.log(data);
				if(data!=null){
					$(".modal-view-chatMemberProfile .modal-content").css("display","block");
					const hireDate = new Date(data.hireDate).toLocaleDateString('ko-KO');
					$(".modal-view-chatMemberProfile .modal-content").append($("<h2>").text("채팅 회원 정보 확인"));
					let modalchatmemberDiv = $("<div class='modal-chat-member'>");
					modalchatmemberDiv.append($("<img>").attr("src","${path}/resources/upload/profile/"+data.profileImg));
					let $table = $("<table class='modal-table'>");
					$table.append($("<tr>").append($("<th colspan='2'>").text(data.dept.deptName+" "+data.memberName+" "+data.job.jobName)));
					$table.append($("<tr>").append($("<th>").text("전화번호")).append($("<td>").text(data.phone)));
					$table.append($("<tr>").append($("<th>").text("주소")).append($("<td>").text(data.address)));
					$table.append($("<tr>").append($("<th>").text("이메일")).append($("<td>").text(data.email)));
					$table.append($("<tr>").append($("<th>").text("입사일")).append($("<td>").text(hireDate)));
					modalchatmemberDiv.append($table);
					$(".modal-view-chatMemberProfile .modal-content").append(modalchatmemberDiv);
					$(".modal-view-chatMemberProfile .modal-content").append($("<button class='modal-close'>").text("닫기"));
					
				}else swal("","없음","warning");
			},
			error: function(xhr, status, error) {
				console.error('AJAX Error:', error);
			}
		})
	});
	
	$(document).on("click", ".chat-msgbx", function(e) {
		
	})
</script>
</body>
</html>