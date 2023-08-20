<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<link rel="stylesheet" href="${path}/resources/css/employee/employee.css">
<section class="max1920px">
	<jsp:include page="/WEB-INF/views/common/side-nav.jsp"/>
	<div class="main-section section-shadow card">
      <div class="right-container">
      	<div class="emp-header">
	        <h2>사원 정보 수정</h2>
	        <input type="button" onclick="location.href='${path}/employee/list'" value="뒤로가기" id="back-btn">
		</div>
         <form action="${path }/employee/memberId" id="update-emp-form" method="post" enctype="multipart/form-data">
         	<input type="hidden" name="memberId" value="${member.memberId }">
         	<div>
         		<span>이름</span>
         		<input type="text" name="memberName" value="${member.memberName }">
         	</div>
         	<div>
         		<span>전화번호</span>
         		<input type="text" name="phone" value="${member.phone }">
         	</div>
         	<div>
         		<span>주소 검색</span>
         		<input type="text" name="mainAddress" id="main-addr" value="${member.address }">
         		<input type="button" onclick="fn_searchAddr();" value="검색" class="emp-input">
         	</div>
         	<div>
         		<span>상세 주소</span>
         		<input type="text" name="detailAddress" id="detail-addr" value="${member.subAddress }">
         	</div>
         	<div>
         		<span>부서</span>
	         	<select name="deptCode">
	         		<option selected value="${member.dept.deptCode }">${member.dept.deptName }</option>
	         		<c:if test="${depts!=null }">
	         			<c:forEach var="d" items="${depts }">
	         				<c:if test="${d.deptCode!=member.dept.deptCode }">
		         				<option value="${d.deptCode }">${d.deptName }</option>
		         			</c:if>
		         		</c:forEach>
	         		</c:if>
	         	</select>
         	</div>
         	<div>
         		<span>직책</span>
	         	<select name="jobCode">
	         		<option selected value="${member.job.jobCode }">${member.job.jobName }</option>
	         		<c:if test="${jobs!=null }">
	         			<c:forEach var="j" items="${jobs }">
	         				<c:if test="${j.jobCode!=member.job.jobCode }">
	         					<option value="${j.jobCode }">${j.jobName }</option>
	         				</c:if>
	         			</c:forEach>
	         		</c:if>
	         	</select>
         	</div>
         	<div>
         		<span>급여</span>
         		<input type="number" name="salary" value="${member.salary }">
         	</div>
         	<span>프로필</span>
         	<input type="file" name="upFile" id="input-file">
         	<div>
         		<img src="${path }/resources/upload/profile/${member.profileImg}" id="mypage-profile">
         		<input type="hidden" name="profile" value="${member.profileImg }">
         	</div>
         	<p>* 프로필 사진이 존재하는 경우 파일 첨부해주세요. 용량 제한 100MB</p>
         	<div>
         		<span>연차</span>
         		<input type="number" name="leave" value="${member.leave }">
         	</div>
         	<div>
         		<span>입사일</span>
         		<input type="date" name="enrollDate" value="${member.hireDate }" disabled>
         	</div>
         	<div>
         		<span>퇴사일</span>
         		<input type="date" name="entDate" value="${member.entDate!=''?member.entDate:''}" id="ent-date">
         	</div>
         	<p>* 퇴사일 이후로는 해당 사원 번호로 로그인 불가능합니다.</p>
         </form>
		<div id="enroll-btns">
			<input type="button" value="취소" onclick="fn_resetBtn();">
			<button onclick="fn_empDataCk();">수정</button>
		</div>
      </div>
   </div>
</section>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
//취소 버튼 클릭 시 reload
function fn_resetBtn(){
	location.reload();
}
//데이터 입력 확인 후 넘기는 메소드
function fn_empDataCk(){
	
	$("#update-emp-form").submit();
}
console.log($("#ent-date").val());
	//주소 검색 메소드
	function fn_searchAddr(){
		//주소 API 사용
		 new daum.Postcode({
		        oncomplete: function(data) {
		        	$("#main-addr").val(data.address);
		        	$("#detail-addr").focus();
		        }
		    }).open();
	}
	$(document).on("change","#input-file",function(){
		let maxSize = 1024 * 1024 * 100;  // 파일 최대 크기 100MB
		const file = this.file; // 첨부된 파일 목록
		if(file.size > maxSize){ // 크기 체크
			alert('100MB 이하의 파일만 첨부할 수 있습니다.');
			$(this).val('');  // 첨부된 파일을 모두 없애줌
			return;
		}
	});
</script>
</body>
</html>