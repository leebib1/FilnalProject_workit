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
			<h2>직책 관리</h2>
			<h4>직책 추가</h4>
			<div class="dept-container-first">
				<span>권한</span>
				<select id="job-auth">
					<option selected disabled>필수 선택</option>
					<option value="MASTER">대표 권한</option>
					<option value="SUBMASTER">부대표 권한</option>
					<option value="TEAMMASTER">팀장 권한</option>
					<option value="EMP">사원 권한</option>
				</select>
				<div id="insert-grade">
					<span>직책명</span>
					<input type="text" id="job-name">
					<button onclick="fn_insertAuth();">생성</button>
				</div>
			</div>
			<h4>직책 삭제</h4>
			<div class="dept-container">
				<div id="delete-grade">
					<table>
						<tr>
							<th>직책</th>
							<th>총 인원</th>
							<th>삭제</th>
						</tr>
						<tr>
							<td colspan="4"><hr /></td>
						</tr>
						<!-- 반복문 처리될 구간 -->
						<c:if test="${jobs!=null }">
							<c:forEach var="j" items="${jobs }">
								<tr class="dept-tr">
									<td>
										${j.jobName}
									</td>
									<td>${j.jobCount }명</td>
									<td>
										<button onclick="fn_deleteAuth('${j.jobCode }','${j.jobCount }');">삭제</button>
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
			<h4>직책명 수정</h4>
			<div class="dept-container">
				<div>
					<table>
						<tr>
							<th>직책</th>
							<th>권한</th>
							<th>총 인원</th>
							<th>변경할 직책명</th>
							<th>변경할 권한</th>
							<th>수정</th>
						</tr>
						<tr><td colspan="6"><hr/></td></tr>
						<c:if test="${jobs!=null }">
							<c:forEach var="j" items="${jobs }">
								<tr class="job-tr">
									<td>${j.jobName}</td>
									<td>
										${j.jobAuth=='MASTER'?"대표":""}
										${j.jobAuth=='SUBMASTER'?"부대표":""}
										${j.jobAuth=='TEAMMASTER'?"팀장":""}
										${j.jobAuth=='EMP'?"사원":""}
									</td>
									<td>${j.jobCount }명</td>
									<td>
										<input type="text" id="${j.jobCode }-name">
									</td>
									<td>
										<select id="${j.jobCode}-auth">
											<option selected disabled>필수 선택</option>
											<option value="MASTER">대표 권한</option>
											<option value="SUBMASTER">부대표 권한</option>
											<option value="TEAMMASTER">팀장 권한</option>
											<option value="EMP">사원 권한</option>
										</select>
									</td>
									<td>
										<button onclick="fn_updateAuth('${j.jobCode}');">수정</button>
									</td>
								</tr>
								<tr class="job-tr"><td colspan="6"><hr/></td></tr>
							</c:forEach>
						</c:if>
					</table>
				<div class="pageBar">${pageBar }</div>
				</div>
			</div>
		</div><!-- right-container -->
	</div>
</section>
<script>
	//직책 추가
	function fn_insertAuth(){
		const jobAuth=$("#job-auth").val();
		const jobName=$("#job-name").val();
		if(jobAuth==null||jobName==null){
			alert("변경할 이름과 권한을 모두 입력하세요.");
			return;
		}
		$.ajax({
			method:"post",
			url:"${path}/employee/job",
			data:JSON.stringify({
				"jobAuth":jobAuth,
				"jobName":jobName
			}),
			dataType:"json",
			contentType:"application/json;charset=UTF-8",
			async:false
		}).then(function (response){
			if(response>0){
				alert(jobName+" 직책이 추가되었습니다.");
				location.reload();
			}else if(response==-1){
				alert(jobName+"은 이미 존재합니다.");
				$("#job-name").focus();
			}else{
				alert("추가 실패했습니다. 다시 시도하세요.");
				$("#job-name").focus();
			}
		});
	}
	
	//직책 삭제
	function fn_deleteAuth(jobCode,jobCount){
		if(jobCount>0){
			alert("해당 직책에 존재하는 사원이 있습니다. 직책 이동 후 삭제하세요.");
			return;
		}
		$.ajax({
			method:"delete",
			url:"${path}/employee/job",
			data:"jobCode="+jobCode,
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
	
	//직책 수정
	function fn_updateAuth(code){
		const jobName=$("#"+code+"-name").val();
		const jobAuth=$("#"+code+"-auth").val();
		if(jobAuth==null||jobName==null){
			alert("변경할 이름과 권한을 모두 입력하세요.");
			return;
		}
		$.ajax({
			method:"put",
			url:"${path}/employee/job",
			data:JSON.stringify({
				"jobCode":code,
				"jobName":jobName,
				"jobAuth":jobAuth
			}),
			dataType:"json",
			contentType:"application/json;charset=UTF-8",
			async:false
		}).then(function (response){
			if(response>0){
				alert("수정 완료되었습니다.");
				location.reload();
			}else if(response==-1){
				alert("이미 사용 중인 직책명입니다.");
				$("#"+code+"-name").focus();
			}else{
				alert("수정 실패했습니다.");
			}
		});
	}
</script>
</body>
</html>