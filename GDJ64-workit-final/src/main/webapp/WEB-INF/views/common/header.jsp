<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.workit.member.model.vo.MemberVO"  %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
<script>
const path = "${pageContext.request.contextPath}";
</script>	
<meta charset="UTF-8">
<link rel="stylesheet" href="${path}/resources/css/common/common.css">
<script src="${path}/resources/js/jquery-3.7.0.min.js"></script>
<title>Work IT</title>
</head>
<body>
<%
	MemberVO loginMember=(MemberVO)session.getAttribute("loginMember");
%>
<header class="max100per">
	<div class="header-container max90per">
		<div class="header-container-logo" onclick="toMainPage();">
			<img alt="logo_header" src="${path}/resources/images/common/workit.svg">
		</div>
		<div class="header-button-container">
			<div class="header-member">
				<a href="${path }/mypage">
					<img src="${path}/resources/upload/profile/${loginMember.profileImg}" alt="member-profile-img">
					<span>${loginMember.dept.deptName }</span>&nbsp;
					<span>${loginMember.memberName }</span>
				</a>
			</div>
			<div class="header_icon_container">
				<div class="nav-btn" id="chat-notification"><span class="chat-num"></span></div>
				<img alt="logout_header" src="${path}/resources/images/common/logout.svg" onclick="fn_logout();">
			</div>
		</div>
	</div>
</header>
<script>
	function toMainPage(){
		location.href="${path}/";
	}
	function fn_logout(){
		var logoutFl=confirm("로그아웃 하시겠습니까?");
		if(logoutFl){
			location.replace("${path}/logout");
		}
	}
	
	window.onload = function() {
		fn_updateChatNotify();
	};
	
	let unreadCount =  $(".chat-num");
	const fn_updateChatNotify=()=>{
		let memberId = '${loginMember.memberId}';
		console.log("member Id : " + memberId);
		$.ajax({
			url: "${path}/chat/notify",
			type: "post",
			data: {
				memberId: memberId
			},
			success: data => {
				console.log("open chat : " + data);
				 $(".chat-num").text(data);
				 if(data == 0){
					 $(".chat-num").addClass("hidden");	 
				 }
			},
			error : data =>{
				console.log("error");
			}
		});
	};
	
	$(".nav-btn").click(e=>{
		location.href="${path}/chat/";
	})
</script>