<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<link rel="stylesheet" href="${path}/resources/css/member/mypage.css">
<section class="max1920px">
<jsp:include page="/WEB-INF/views/common/side-nav.jsp"/>
<section class="mypage-section">
	<div class="main-section section-shadow card profile-info">
		<div class="right-container">
				<h2>프로필</h2>
				<img src="${path }/resources/upload/profile/${loginMember.profileImg}" id="mypage-profile" onclick="fn_updateProfile();">
				<form action="${path }/member/profile" method="post" enctype="multipart/form-data" id="profile-form">
					<input type="file" name="profileImg" id="profile-input" accept="image" required>
					<div>
						<input type="reset" value="취소" onclick="fn_resetProfile();">
						<button onclick="fn_profileSubmit();">수정</button>
					</div>
				</form>
				<p><span id="mypage-name">${loginMember.memberName }</span> 님</p>
				<div class="mypage-simple-info">
					<p>부서</p>
					<input type="text" value="${loginMember.dept.deptName }" disabled>
					<p>직책</p>
					<input type="text" value="${loginMember.job.jobName }" disabled>
					<p>급여</p>
					<input type="text" value="${loginMember.salary }" disabled>
					<p>입사일</p>
					<input type="date" id="hire-date" value="" disabled>
				</div>
			</div><!-- right-container -->
		</div><!-- profile-info -->
		<div class="mypage-update-div">
			<div class="main-section section-shadow card">
				<div class="right-container">
					<h2>개인 정보 수정</h2>
					<form action="${path }/member/info" method="post" id="member-update-form">
						<input type="hidden" name="memberId" value="${loginMember.memberId}">
						<div class="mypage-update">
							<span>전화번호</span>
							<input type="text" name="phone" value="${loginMember.phone }" required>
							<p>* 전화번호 입력 시 하이픈(-) 제외하고 입력하세요.</p>
						</div>
						<div class="mypage-update">
							<span>이메일</span>
							<input type="email" name="email" class="first-input" id="mail" value="${loginMember.email}">
			                <input type="button" onclick="fn_requestEmail();" value="전송">
			                <span ID="email-time">5:00</span>
						</div>
						<!-- 인증 요청 버튼을 누르면 보일 구간 -->
						<div class="mypage-update">
							<span>인증 번호</span>
							<input type="text" id="check-number" class="first-input">
                			<input type="button" onclick="fn_checkEmailNumber();" value="인증">
						</div>
						<div id="check-info"></div>
						<!--  -->
						<div class="mypage-update">
							<span>주소 검색</span>
							<input type="text" name="mainAddress" value="${loginMember.address }" required>
							<input type="button" onclick="fn_searchAddr();" value="검색">
						</div>
						<div class="mypage-update">
							<span>상세 주소</span>
							<input type="text" name="detailAddress" value="${loginMember.subAddress }" required>
						</div>
						<div class="mypage-update">
							<span>변경 사유</span> <input type="text" name="updateComment" required id="update-comment">
						</div>
						<div>
							<h4>수정 대기 현황</h4>
							<table class="update-result-tb">
								<tr>
									<th>신청자</th>
									<th>승인 담당자</th>
									<th class="tb-content">신청 사유</th>
									<th>신청 날짜</th>
									<th>처리 결과</th>
								</tr>
								<tr>
									<td colspan="5"><hr /></td>
								</tr>
								<c:if test="${not empty approv and approv.approvalFl=='N' }">
									<tr>
										<td>${approv.memberName }</td>
										<td>${approv.approvalMember }</td>
										<td>${approv.updateComment }</td>
										<td>${approv.requestDate }</td>
										<td>${approv.approvalFl=='N'?"미승인":"승인완료" }</td>
									</tr>
									<tr>
										<td colspan="5"><hr /></td>
									</tr>
								</c:if>
								<c:if test="${empty approv or approv.approvalFl=='Y'}">
									<tr>
										<td colspan="5">승인 대기 중인 요청 내역이 없습니다.</td>
									</tr>
									<tr>
										<td colspan="5"><hr /></td>
									</tr>
								</c:if>
							</table>
						</div>
					</form>
					<div class="mypage-update">
						<input type="reset" value="취소">
						<button onclick="fn_updateMember();">수정 요청</button>
					</div>
					<p>* 개인정보 수정 요청 시, 인사팀에서 승인 후 변경 사항이 적용됩니다.</p>
					</div>
				</div>
				<div class="main-section section-shadow card">
					<div class="right-container">
						<h2>비밀번호 수정</h2>
						<div class="mypage-update">
							<span>현재 비밀번호</span>
							<input type="password" name="oriPwd" id="ori-pwd">
						</div>
						<div class="mypage-update">
							<span>새 비밀번호</span>
							<input type="password" name="newPwd" id="new-pwd">
						</div>
						<div class="mypage-update">
							<span>비밀번호 확인</span>
							<input type="password" id="pwd-ck">
						</div>
						<div>
							<input type="reset" value="취소">
							<button onclick="fn_updatePwd();">수정</button>
						</div>
					</div>
			</div>
		</div>
	</section>
</section><!-- max1920px -->
<script>
	var emailFl=false;
	var time=300;
	var min=5;
	var sec=0;
	$(document).ready(function(){
		//입사일
		const strId="${loginMember.memberId}";
		var strDate=strId.substr(0,2);
		strDate="20"+strDate+"-";
		strDate+=strId.substr(2,2)+"-"+strId.substr(4,2);
		$("#hire-date").val(strDate);
		//이메일
		if($("#mail").val()!=""){
			emailFl=true;
		}
		$("#mail").change(function(){
			emailFl=false;
		});
	});
	
	//프로필 사진 변경
	function fn_updateProfile(){
		$("#profile-input").click();
		$("#profile-input").change(()=>{
			const fileName=$("#profile-input")[0].files[0].name;
			const fileSrc=URL.createObjectURL($("#profile-input")[0].files[0]);
			$("#mypage-profile").attr("src",fileSrc);
		});
	}
	
	//프로필 취소
	function fn_resetProfile(){
		$("#profile-input").val('');
		$("#mypage-profile").attr("src","${path }/resources/upload/profile/${loginMember.profileImg}");
	}
	
	//프로필 전송
	function fn_profileSubmit(){
		if($("#profile-input").val()!=''){
			$("#profile-form").submit();
		}else{
			alert("변경할 이미지를 업로드하세요.");
			fn_updateProfile();
		}
	}
	
	//개인 정보 수정
	function fn_updateMember(){
		if("${approv.approvalFl}"!=""){
			alert("미승인된 요청 정보가 있습니다.");
		}else if(!emailFl){
			alert("이메일 인증을 완료하세요.");
			$("#mail").focus();
		}else if($("#update-comment").val()==null||$("#update-comment").val()==""){
			alert("변경 사유를 입력하세요.");
			$("#update-comment").focus();
		}else{
			$("#member-update-form").submit();
		}
	}
	
	//비밀번호 수정
	function fn_updatePwd(){
		const newPwd=$("#new-pwd").val();
		const oriPwd=$("#ori-pwd").val();
		const pwdCk=$("#pwd-ck").val();
		const regPwd = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,15}$/;
		//프론트 입력 내용 체크
		if(oriPwd=='' || newPwd=='' || pwdCk==''){
			alert("내용을 전부 입력하세요.");
			$("#ori-pwd").focus();
			return;
		}else if(newPwd!=pwdCk){
			alert("비밀번호가 일치하지 않습니다.");
			$("#new-pwd").val('');
			$("#pwd-ck").val('');
			$("#new-pwd").focus();
			return;
		}else if(!regPwd.test(newPwd)){
			alert("비밀번호는 영문자, 숫자, 특수문자를 조합해 8글자 이상이여야합니다.");
			$("#new-pwd").val('');
			$("#pwd-ck").val('');
			$("#new-pwd").focus();
			return;
		}
		//확인한 데이터 전송
		$.ajax({
			method:"post",
			url:"${path}/member/password",
			data:JSON.stringify({
				"password":oriPwd,
				"newPwd":newPwd,
				"memberId":"${loginMember.memberId}"
			}),
			dataType:"json",
			contentType:"application/json;charset=UTF-8",
			async:false
		}).then(function (response){
			if(response>0){
				alert("비밀번호 변경이 완료되었습니다.");
				location.reload();
			}else if(response==-1){
				alert("현재 비밀번호가 틀립니다.");
				$("#ori-pwd").val('');
				$("#ori-pwd").focus();
			}else{
				alert("비밀번호 변경을 실패했습니다.");
				location.reload();
			}
		});
	}
	
	//인증 메일 전송
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
			}).then(function (response){
				alert("전송되었습니다. 이메일을 확인해주세요.");
				const emailNum=$("<input>").attr({
					"type":"hidden",
					"id":"email-number"
				});
				emailNum.val(response);
				$("#profile-form").append(emailNum);
				var fn_time=setInterval(function(){
					time--;
					console.log("time 실행");
					min=parseInt(time/60);
					sec=time%60;
					$("#email-time").text(min+" : "+sec);
					if(time<0){
						$("#email-time").text("0:00");
					}
				},1000);
			});
		}
	}
	
	//이메일 인증 번호 확인
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
</script>
</body>
</html>