<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.workit.member.model.vo.MemberVO"  %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="${path}/resources/css/common/common.css">
<link rel="stylesheet" href="${path}/resources/css/member/login.css">
<script src="${path}/resources/js/jquery-3.7.0.min.js"></script>
<title>Work IT</title>
<%
	MemberVO loginMember=(MemberVO)session.getAttribute("loginMember");
%>
</head>
<body>
	 <section class="login-container first">
        <div class="login-div">
        <form action="${path }/member/first" method="post" id="first-form">
        	<input type="hidden" name="memberId" value="${loginMember.memberId }">
        	<input type="hidden" name="password" value="1234">
            <div class="logo-container">
                <img src="${path }/resources/images/common/workit.svg">
            </div>
            <!-- logo -->
            <h3 class="page-title">초기 이메일 인증 및 비밀번호 변경</h3>
            <div class="input-container">
	            <p>이메일</p>
                <input type="email" name="email" class="first-input" id="mail">
                <input type="button" onclick="fn_requestEmail();" value="전송">
            	<p id="email-time">5:00</p>
            </div>
            <div class="input-container" id="check-container">
	            <p>인증 번호</p>
                <input type="text" id="check-number" class="first-input">
                <input type="button" onclick="fn_checkEmailNumber();" value="인증">
            </div>
            <div id="check-info"></div>
            <div class="input-container">
            	<p>비밀번호</p>
                <input type="password" name="newPwd" id="pwd" class="first-input" required>
            </div>
            <div class="input-container">
	            <p>비밀번호 확인</p>
                <input type="password" id="pwd-check" class="first-input">
                <p class="info-msg" id="pwd-info" style="color:red"></p>
            </div>
            <div class="pwd-msg"></div>
            <p class="info-msg">* 이메일 인증과 비밀번호 변경을 완료하셔야 로그인 가능합니다.</p>
            <div class="success-btn">
                <button onclick="fn_checkInfo();">완료</button>
            </div>
        </form>
    </div>
    </section>
<script>
	var emailFl=false;
	var time=300;
	var min=5;
	var sec=0;
	function fn_requestEmail(){
		const email=$("#mail").val();
		const regEmail = /^[\w\-\_]{4,}@[\w\-\_]+(\.\w+){1,3}$/;
		if(email==''||!regEmail.test(email)){
			alert("이메일 주소를 정확히 입력하세요.");
			$("#mail").focus();
		}else{
			$.ajax({
				method:"post",
				url:"${path}/email",
				data:"email="+email,
				dataType:"text",
				error: function() {
					alert("인증 메일 전송에 실패했습니다. 다시 시도해주세요.");
				},
				success: function (response){
					alert("전송되었습니다. 이메일을 확인해주세요."+response);
					const emailNum=$("<input>").attr({
						"type":"hidden",
						"id":"email-number"
					});
					emailNum.val(response);
					$("#first-form").append(emailNum);
					var fn_time=setInterval(function(){
						time--;
						min=parseInt(time/60);
						sec=time%60;
						$("#email-time").text(min+" : "+sec);
						if(time<0){
							$("#email-time").text("0:00");
						}
					},1000);
				}
			});
		}
	}
	
	function fn_checkEmailNumber(){
		if(time<0){
			alert("인증 시간이 초과되었습니다. 다시 인증하세요.");
			$("#email").focus();
		}
		$("#check-info").find("span").remove();
		const checkNum=$("#check-number").val();
		const emailNum=$("#email-number").val();
		if(checkNum==''||checkNum.length<8){
			$("#check-info").append($("<span>").text("인증 번호를 정확하게 입력하세요."));
			$("#check-number").focus();
			emailFl=false;
		}else if(checkNum==emailNum){
			$("#check-info").append($("<span>").text("인증되었습니다. :)"));
			emailFl=true;
		}else{
			$("#check-info").append($("<span>").text("인증 번호가 일치하지 않습니다."));
			$("#check-number").focus();
			emailFl=false;
		}
	}
	var pwdFl=false;
	$("#pwd").keyup(function(){
		const regPwd = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,15}$/;
		const pwd=$("#pwd").val();
		if(pwd==''||!regPwd.test(pwd)){
			$("#pwd-info").text("영문자, 숫자, 특수기호를 포함해 8글자 이상입력하세요.");
			$("pwd").focus();
			pwdFl=false;
		}else{
			$("#pwd-info").text("");
			pwdFl=true;
		}
	});
	var pwdCkFl=false;
	$("#pwd-check").keyup(function(){
		const pwd=$("#pwd").val();
		const pwdCk=$("#pwd-check").val();
		if(pwd!=pwdCk){
			$("#pwd-info").text("비밀번호가 일치하지 않습니다.");
			$("pwd").focus();
			pwdCkFl=false;
		}else{
			$("#pwd-info").text("");
			pwdCkFl=true;
		}
	});
</script>
</body>
</html>