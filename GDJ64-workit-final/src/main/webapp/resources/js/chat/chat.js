// 채팅 목록에서 검색
$(".searchIcon").click(e => {
	$(".modal-searchContainer").toggle("chatHidden");
	$(".modal-result-container").toggle("chatHidden");
	$(".modalSearchInput").val("");
	$(".modal-result-container").empty();
})

// 채팅 창에서 검색
$(".searchChatroomIcon").click(e => {
	$(".modal-searchRoomContainer").toggle("chatHidden");
	$(".modal-result-container").toggle("chatHidden");
	$(".modal-searchRoomInput").val("");
	$(".chatroom-file-container").css('display', 'none');
	$(".modalResult").text("");
	$(".modal-result-container").empty();
})

// 채팅 목록에서 검색 닫기
$(".search-close").click(e => {
	$(".modal-searchContainer").css('display', 'none');
	
})

class Chat {
	constructor(chatroomId = "", memberId = "", chatContent = "", chatDate = "") {
		this.chatroomId = chatroomId;
		this.memberId = memberId;
		this.chatContent = chatContent;
		this.chatDate = chatDate;
	}
}

class Chatroom {
	constructor(chatroomId = "", chatroomCode = "", chatroomTitle = "", chatroomDate = "", memberId = "") {
		this.chatroomId = chatroomId;
		this.chatroomCode = chatroomCode;
		this.chatroomTitle = chatroomTitle;
		this.chatroomDate = chatroomDate;
		this.memberId = memberId;
	}
}
// 부서 이름 선택하면 사원 토글
$(".dept-title").click(e => {
	console.log($(e.target));
	$(e.target).next().toggle();
})
// 채팅 창에서 회원 프로필 확인
$(document).on("click", ".modal-view-chatMemberProfile .modal-close", function(e) {
	$(".modal-view-chatMemberProfile").css("display","none");
});


// 채팅 생성 모달 열기
$(".addChatIcon").click(e => {
	$(".modal-addChatMember").css("display", "block");
})

// 채팅방에서 채팅 멤버 업데이트
$(".addPersonIcon").click(e => {
	$(".modal-updateChat").css("display", "block");
	$(".modal-addChatMember").css("display", "none");
	$(document).attr("overflow", "hidden");
	$(".currentChatMember").text("현재 채팅 참여 멤버 : " + chatroomMemberName);
})

//모달 닫는 공용 메소드 2
$(document).on("click", ".modal-close-up", function (e) {
	let containerDiv = $(e.target).parent().parent().parent();
	containerDiv.css("display","none");
});
//모달 닫는 공용 메소드 1
$(document).on("click", ".modal-close", function (e) {
	let containerDiv = $(e.target).parent().parent();
	containerDiv.css("display","none");
});
// null 체크하는 메소드
const fn_checkStrNull = (data) => {
	var checkResult;
	if (data == null || data == "" || data == "null") {
		checkResult = "null";
		return checkResult;
	} else {
		checkResult = data;
		return checkResult;
	}
}
function fn_closeChatModal(){
	$(".modal-addChatMember").css("display", "none");
}










