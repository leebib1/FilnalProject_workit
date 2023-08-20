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
<!-- jQuery library -->
<script src="${path}/resources/js/jquery-3.7.0.min.js"></script>
<title>Work IT</title>
</head>
<body>
	<section class="login-container">
        <div class="login-div">
            <form action="${path }/login" method="post" id="login-form">
            	<div class="logo-container" onclick="fn_loginPage();">
                	<img src="${path }/resources/images/common/workit.svg">
            	</div>
                <!-- logo -->
                <h4>workit에 오신 것을 환영합니다 :)</h4>
                <span>사원 번호</span>
                <div class="input-container">
                    <input type="text" name="memberId" class="login-input" id="id" value="${cookie.userid.value }">
                </div>
                <span>비밀번호</span>
                <div class="input-container">
                    <input type="password" name="password" class="login-input" id="member-pwd">
                </div>
            </form>
			<div class="btn-container">
				<div>
					<input type="checkbox" id="remember-id"><span>remember me</span>
				</div>
				<button onclick="fn_login();">Log in</button>
			</div>
			<a href="${path }/login/password">forgot your password?</a>
        </div>
	</section>
<script>
	$(document).ready(function(){
		//저장된 아이디
		var id=getCookie("rememberId");
		$("#id").val(id);
		if($("#id").val()!=""){
			$("#remember-id").attr("checked",true);
		}
		
		//아이디 저장 체크박스
		$("#remember-id").change(function(){
			if($("#remember-id").is(":checked")){
				setCookie("rememberId",$("#id").val(),7);
			}else{
				deleteCookie("rememberId");
			}
		});
		
		//아이디 저장이 선택된 상태로 아이디 입력시
		$("#id").keyup(function(){
			if($("#remember-id").is(":checked")){
				setCookie("rememberId",$("#id").val());
			}
		});
		
		//쿠키 저장
		function setCookie(cookieName, value, day){
		    var date = new Date();
		    date.setDate(date.getDate() + day); //오늘부터 7일
		    var cookieValue = escape(value) + ((day==null) ? "" : "; expires=" + date.toGMTString()); //날짜 포함한 값 지정
		    document.cookie = cookieName + "=" + cookieValue; //쿠키 생성
		}
		
		//쿠키 값 불러오기
		function getCookie(cookieName) {
		    cookieName = cookieName + '=';
		    var cookieData = document.cookie; //쿠키 값
		    var start = cookieData.indexOf(cookieName); //아이디의 시작 인덱스
		    var cookieValue = '';
		    if(start != -1){ //값이 존재하는 경우
		        start += cookieName.length;
		        var end = cookieData.indexOf(';', start); //아이디 값 끊어낼 기준
		        if(end == -1)end = cookieData.length; //-1 나오면 데이터 길이를 기준으로 함
		        cookieValue = cookieData.substring(start, end);
		    }
		    return unescape(cookieValue); //아이디 반환
		}
		
		//쿠키 삭제
		function deleteCookie(cookieName){
		    var expireDate = new Date();
		    expireDate.setDate(expireDate.getDate() - 1); //지정된 날짜에서 -1
		    document.cookie = cookieName + "= " + "; expires=" + expireDate.toGMTString(); //해당 쿠키 기간 만료로 삭제
		}
	});
	
	//값 확인 후 로그인 실행
	function fn_login(){
		console.log($("#id").val());
		if($("#id").val()!=""&&$("#member-pwd").val()!=""){
			$("#login-form").submit();
		}
	}

	//로고 클릭 시 로그인 페이지
	function fn_loginPage(){
		location.href="${path}/loginpage";
	}
</script>
</body>
</html>