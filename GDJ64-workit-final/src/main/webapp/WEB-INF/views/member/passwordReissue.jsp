<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
</head>
<body>
	<section class="section-shadow login-container">
        <div class="login-div">
                <div class="logo-container"  onclick="fn_loginPage();">
                	<img src="${path }/resources/images/common/workit.svg">
            	</div>
                <h2 class="page-title">비밀번호 재발급</h2>
                <span>사원 번호</span>
                <div class="input-container">
                    <input type="text" id="memberId" class="first-input">
                </div>
                <span>이메일</span>
                <div class="input-container">
                    <input type="email" id="email" class="first-input">
                    <button onclick="fn_requestEmail()">인증 요청</button>
                    <div id="check-info"></div>
                	<span id="email-time">5:00</span>
                </div>
                <span>인증 번호</span>
                <div class="input-container">
                    <input type="text" id="check-number" class="first-input">
                    <button onclick="fn_checkEmailNumber();">인증</button>
                    <p class="info-msg">* 임시 비밀번호 발급 후, 로그인 해서 비밀번호를 재설정하세요.</p>
                </div>
                <p id="pwd-info"></p>
                <div class="success-btn">
                    <button onclick="fn_loginPage();">Log in</button>
                </div>
        </div>
	</section>
<script>
	var emailFl=false;
	var time=300;
	var min=5;
	var sec=0;
	function fn_requestEmail(){
		const email=$("#email").val();
		const regEmail = /^[\w\-\_]{4,}@[\w\-\_]+(\.\w+){1,3}$/;
		if(email==''||!regEmail.test(email)){
			alert("이메일 주소를 정확히 입력하세요.");
			$("#email").focus();
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
					time=300;
					alert("전송되었습니다. 이메일을 확인해주세요.");
					const emailNum=$("<input>").attr({
						"type":"hidden",
						"id":"email-number"
					});
					emailNum.val(response);
					$(".login-div").append(emailNum);
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
		const memberId=$("#memberId").val();
		const email=$("#email").val();
		if(checkNum==''||checkNum.length<8){
			$("#check-info").append($("<span>").text("인증 번호를 정확하게 입력하세요."));
			$("#check-number").focus();
			emailFl=false;
		}else if(checkNum==emailNum){
			$("#check-info").append($("<span>").text("인증되었습니다. :)"));
			$.ajax({
				method:"put",
				url:"${path}/email/password",
				data:JSON.stringify({
					"memberId":memberId,
					"email":email
				}),
				dataType:"json",
				contentType:"application/json;charset=UTF-8",
				async:false,
				success:function(result){
					if(result>0){
						$("#pwd-info").text("임시 비밀번호가 발송되었습니다. \n임시 번호로 로그인하세요.");						
					}
				}
			});
		}else{
			$("#check-info").append($("<span>").text("인증 번호가 일치하지 않습니다."));
			$("#check-number").focus();
		}
	}
	
	function fn_loginPage(){
		location.href="${path}/loginpage";
	}
</script>
</body>
</html>