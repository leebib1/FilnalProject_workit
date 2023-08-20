<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<link rel="stylesheet" href="${path}/resources/css/employee/employee.css">
<section class="max1920px">
	<jsp:include page="/WEB-INF/views/common/side-nav.jsp" />
	<div class="main-section section-shadow card">
		<div class="right-container dept-div">
			<h2 class="title">부서 관리</h2>
			<div class="dept-container-first">
				<h4>부서 추가</h4>
				<div id="insert-grade">
					<span>부서명</span>
					<input type="text" id="dept-name">
					<button onclick="fn_insertDept();">생성</button>
				</div>
			</div>
			<h4>부서 삭제</h4>
			<p>* 해당 부서에 사원이 존재하면 삭제할 수 없습니다.</p>
			<div class="dept-container">
				<div id="delete-grade">
					<table>
						<tr>
							<th>부서</th>
							<th>총 인원</th>
							<th>삭제</th>
						</tr>
						<tr>
							<td colspan="4"><hr /></td>
						</tr>
						<!-- 반복문 처리될 구간 -->
						<c:if test="${depts!=null }">
							<c:forEach var="d" items="${depts }">
								<tr class="dept-tr">
									<td>
										${d.deptName}
									</td>
									<td>${d.deptCount }명</td>
									<td>
										<button onclick="fn_deleteDept('${d.deptCode }');">삭제</button>
									</td>
								</tr>
								<tr class="dept-tr">
									<td colspan="4"><hr /></td>
								</tr>
							</c:forEach>
						</c:if>
					</table>
				</div>
			</div>
			<h4>부서 수정</h4>
			<div class="dept-container">
				<div>
					<table>
						<tr>
							<th>부서</th>
							<th>총 인원</th>
							<th>변경할 부서명</th>
							<th>수정</th>
						</tr>
						<tr>
							<td colspan="4"><hr /></td>
						</tr>
						<!-- 반복문 처리될 구간 -->
						<c:if test="${depts!=null }">
							<c:forEach var="d" items="${depts }">
								<tr class="dept-tr">
									<td>${d.deptName}</td>
									<td>${d.deptCount }명</td>
									<td>
										<input type="text" id="${d.deptCode }-rename"></td>
									<td>
										<button onclick="fn_updateAuth('${d.deptCode }');">수정</button>
									</td>
								</tr>
								<tr class="dept-tr">
									<td colspan="4"><hr /></td>
								</tr>
							</c:forEach>
						</c:if>
					</table>
					<br>
					<div class="pageBar">${pageBar }</div>
				</div>
			</div>
		</div>
		<!-- right-container -->
	</div>
</section>
<script>
			const fn_insertDept=()=>{
					const deptName=$("#dept-name").val();
					$.ajax({
						method:"post",
						url:"${path}/employee/dept",
						data:"deptName="+deptName,
						dataType:"text"
					}).then(function (response){
						if(response>0){
							alert("추가 되었습니다.");
							location.reload();
						}else{
							alert("추가 실패하였습니다.");
						}
					});
				}
				function fn_deleteDept(deptCode){
					console.log(deptCode);
					$.ajax({
						method:"delete",
						url:"${path}/employee/dept",
						data:"deptCode="+deptCode,
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
						}
					});
				}
				function fn_updateAuth(deptCode){
					const rename=$("#"+deptCode+"-rename").val();
					$.ajax({
						method:"put",
						url:"${path}/employee/dept",
						data:JSON.stringify({
							"deptRename":rename,
							"deptCode":deptCode
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