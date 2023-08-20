<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<section class="max1920px">
<link rel="stylesheet" href="${path}/resources/css/employee/employee.css">
<jsp:include page="/WEB-INF/views/common/side-nav.jsp"/>
	<div class="main-section section-shadow card">
      <div class="right-container">
         <h2>사원 등록</h2>
         <form action="${path }/employee/enroll" method="post" id="enroll-form">
         	<div>
         		<span>이름</span>
         		<input type="text" name="memberName" id="member-id">
         	</div>
         	<div>
         		<span>주민번호</span>
         		<input type="text" name="memberNo" id="member-no">
         	</div>
         	<div>
         		<span>전화번호</span>
         		<input type="text" name="phone" id="phone-no">
         		<p>* 전화번호 입력 시 하이픈(-) 제외하고 입력하세요.</p>
         	</div>
         	<div>
         		<span>주소 검색</span>
         		<input type="text" name="mainAddress" id="main-addr">
         		<input type="button" onclick="fn_searchAddr();" value="검색" class="emp-input">
         	</div>
         	<div>
         		<span>상세 주소</span>
         		<input type="text" name="detailAddress" id="detail-addr">
         	</div>
         	<div>
         		<span>부서</span>
	         	<select name="deptCode" id="dept">
	         		<option selected disabled>필수 선택</option>
	         		<c:if test="${depts!=null }">
		         		<c:forEach var="d" items="${depts }">
		         			<option value="${d.deptCode }">${d.deptName }</option>
	         			</c:forEach>
	         		</c:if>
	         	</select>
         	</div>
         	<div>
         		<span>직책</span>
	         	<select name="jobCode" id="job">
	         		<option selected disabled>필수 선택</option>
	         		<c:if test="${jobs!=null }">
		         		<c:forEach var="j" items="${jobs }">
		         			<option value="${j.jobCode }">${j.jobName }</option>
	         			</c:forEach>
	         		</c:if>
	         	</select>
         	</div>
         	<div>
         		<span>급여</span>
         		<input type="number" name="salary" id="pay">
         	</div>
         	<div>
         		<span>입사일</span>
         		<input type="date" name="enrollDate" id="hire-date">
         	</div>
         </form>
         <p>* 사원 초기 비밀번호는 1234로 생성됩니다.</p>
      </div>
	<div id="enroll-btns">
		<input type="button" onclick="fn_resetBtn();" value="취소" class="emp-btn">
		<button onclick="fn_empDataCk();">생성</button>
	</div>
   </div>
</section>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="${path }/resources/js/employee/enrollEmp.js"></script>
</body>
</html>