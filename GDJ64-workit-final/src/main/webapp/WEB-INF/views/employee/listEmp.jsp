<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<link rel="stylesheet" href="${path}/resources/css/employee/employee.css">
<section class="max1920px">
	<jsp:include page="/WEB-INF/views/common/side-nav.jsp" />
	<div class="main-section section-shadow card">
		<div class="right-container emp-div">
			<h2 class="title">사원 조회</h2>
			<select id="ent-flag">
				<option ${entFl==""?"selected":"" } value="">전체</option>
				<option ${entFl=="N"?"selected":"" } value="N">재직</option>
				<option ${entFl=="Y"?"selected":"" } value="Y">퇴사</option>
			</select>
			<select id="search-category">
				<option ${category==""?"selected":"" } disabled>검색 카테고리</option>
				<option ${category=="no"?"selected":"" } value="no">사번</option>
				<option ${category=="name"?"selected":"" } value="name">이름</option>
				<option ${category=="dept"?"selected":"" } value="dept">부서</option>
				<option ${category=="job"?"selected":"" } value="job">직책</option>
			</select>
			<input type="text" id="keyword" value="${keyword }">
			<button onclick="fn_serchKeyword();">검색</button>
			<table id="emp-table">
				<tr>
					<th>사번</th>
					<th>이름</th>
					<th>부서</th>
					<th>직책</th>
					<th>연봉</th>
					<th>주소</th>
					<th>입사일</th>
					<th>퇴사일</th>
				</tr>
				<tr><td colspan="8"><hr/></td></tr>
				<!-- 반복문 처리될 구간 -->
				<c:if test="${not empty members }">
					<c:forEach var="m" items="${members }">
					<tr onclick="location.href='${path}/employee/memberId?id=${m.memberId}'">
						<td>${m.memberId }</td>
						<td>${m.memberName }</td>
						<td>${m.dept.deptName }</td>
						<td>${m.job.jobName }</td>
						<td>${m.salary }</td>
						<td>${m.address }</td>
						<td>${m.hireDate }</td>
						<td>${m.entDate!=null?m.entDate:"" }</td>
					</tr>
					<tr><td colspan="8"><hr/></td></tr>
					</c:forEach>
				</c:if>
				<c:if test="${empty members }">
					<tr><td colspan="8">조회 결과가 없습니다.</tr>
				</c:if>
			</table>
			<div class="pageBar">${pageBar }</div>
		</div>
		<!-- right-container -->
	</div>
</section>
<script>
//퇴사 여부
$(document).ready(function() {
	$("#ent-flag").change(function(){
		console.log($("#ent-flag").val());
		const entFl=$("#ent-flag").val();
		location.assign("${path}/employee/list?entFl="+entFl);
	});
});

//페이징 함수 덮어쓰기
function fn_paging(no){
	console.log("paging");
	location.assign('${path}/employee/list?cPage='+no+'&entFl='+'${entFl==null?"":entFl }'
			+"&category="+'${category==null?"":category }'+"&keyword="+'${keyword==null?"":keyword}');
}

//검색어
function fn_serchKeyword(){
	const category=$("#search-category").val();
	const keyword=$("#keyword").val();
	const entFl=$("#ent-flag").val();
	if(category==''||category==null){
		alert("검색 카테고리를 선택하세요.");
		$("#keyword").focus();
	}else{
		location.assign("${path}/employee/list?entFl="+entFl+"&category="+category+"&keyword="+keyword);
	}
}
</script>
</body>
</html>