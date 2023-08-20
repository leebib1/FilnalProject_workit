<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<link rel="stylesheet" href="${path}/resources/css/employee/employee.css">
<section class="max1920px">
	<jsp:include page="/WEB-INF/views/common/side-nav.jsp" />
	<div class="main-section section-shadow card">
		<div class="right-container">
			<h2>사원 정보 수정 신청 목록</h2>
			<table id="emp-table">
				<tr>
					<th>사번</th>
					<th>이름</th>
					<th>신청 사유</th>
					<th>신청 날짜</th>
					<th>승인 담당자</th>
					<th>처리 결과</th>
					<th>삭제</th>
					<th>승인</th>
				</tr>
				<tr><td colspan="8"><hr/></td></tr>
				<!-- 반복문 처리될 구간 -->
				<c:if test="${not empty approvList }">
					<c:forEach var="a" items="${approvList }">
					<tr onclick="fn_approvContent(${a.memberUpdateNo},${a.memberId });">
						<td>${a.memberId }</td>
						<td>${a.memberName }</td>
						<td>${a.updateComment }</td>
						<td>${a.requestDate }</td>
						<td>${a.approvalMember }</td>
						<td>${a.approvalFl=='Y'?"승인 완료":"승인 대기" }</td>
						<td><button onclick="fn_requestDel(${a.memberUpdateNo});">삭제</button></td>
						<td><button onclick="fn_ApprovInfo(${a.memberUpdateNo});">승인</button></td>
					</tr>
					<tr><td colspan="8"><hr/></td></tr>
					</c:forEach>
				</c:if>
			</table>
			<div class="pageBar">${pageBar }</div>
			<div id="info-container">
				<h3>신청 내역</h3>
				<h4>현재 사원 정보</h4>
				<table class="info-table">
					<tr>
						<th>사번</th>
						<th>이름</th>
						<th>전화번호</th>
						<th>주소</th>
						<th>상세주소</th>
						<th>이메일</th>
					</tr>
					<tr><td colspan="6"><hr/></td></tr>
					<tr id="member-tr"></tr>
				</table>
				<br>
				<h4>수정 신청 내역</h4>
				<table class="info-table">
					<tr>
						<th>전화번호</th>
						<th>주소</th>
						<th>상세주소</th>
						<th>이메일</th>
						<th>신청 사유</th>
						<th>신청일</th>
					</tr>
					<tr><td colspan="6"><hr/></td></tr>
					<tr id="info-tr"></tr>
				</table>
			</div>
		</div>
		<!-- right-container -->
	</div>
</section>
<script>
	function fn_approvContent(updateNo,memberId){
		$.get("${path}/employee/approv/info?no="+updateNo,data=>{
			const tr=$("#info-tr");
			tr.children().remove();
			tr.append($("<td>").text(data.phone))
				.append($("<td>").text(data.address))
				.append($("<td>").text(data.subAddress))
				.append($("<td>").text(data.email))
				.append($("<td>").text(data.updateComment))
				.append($("<td>").text(data.requestDate));
		});
		$.get("${path}/employee/approv/member?no="+memberId,data=>{
			console.log(data);
			const tr=$("#member-tr");
			tr.children().remove();
			tr.append($("<td>").text(data.memberId))
				.append($("<td>").text(data.memberName))
				.append($("<td>").text(data.phone))
				.append($("<td>").text(data.address))
				.append($("<td>").text(data.subAddress))
				.append($("<td>").text(data.email));
		});
	}
	
	function fn_requestDel(updateNo){
		$.ajax({
			method:"delete",
			url:"${path}/employee/approv",
			data:"no="+updateNo,
			dataType:"text"
		}).then(function (response){
			if(response>0){
				alert("삭제 되었습니다.");
				location.reload();
			}else{
				alert("삭제 실패하였습니다.");
			}
		}).then(function (error){
			if(error!=null){
				alert(error);
				location.replace("${path}/employee/approv");
			}
		});
	}
	
	function fn_ApprovInfo(updateNo){
		console.log(${loginMember.memberId});
		$.ajax({
			method:"put",
			url:"${path}/employee/approv",
			data:JSON.stringify({
				"approvalMember":"${loginMember.memberId}",
				"no":updateNo
			}),
			dataType:"json",
			contentType:"application/json;charset=UTF-8",
			async:false
		}).then(function (response){
			if(response>0){
				alert("수정 되었습니다.");
				location.reload();
			}
		});
	}
</script>
</body>
</html>