<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<section class="max1920px">
	<jsp:include page="/WEB-INF/views/common/side-nav.jsp"/>
	<div class="main-section section-shadow card">
      <div class="right-container">
		<h3>시설 예약하기</h3>
	<!-- 사용 목적 선탹에 따라 아래 디테일 약간의 변경 있음 -->
	<!-- 상담은 참여자 최대 2명(기본 1명), 회의는 최소 2명, 최대 7명/ 명수만큼 이름 입력창 나올 수 있도록 -->
	<!-- 상담은 한시간, 회의는 두시간으로 설정 -->
	<!--  -->
		<form id="bookingForm">
			<div>
				<span>예약자</span>
				<input type="text" name="memberId" value="" readonly>
			</div>
			<div>
				<span>사용목적</span>
				<label><input id="purpose" type="radio" name="purpose" value="0">상담</label>
				<label><input id="purpose" type="radio" name="purpose" value="1">회의</label>
			</div>
			<div>
				<span>이용시설</span>
	 			<label><input id="facility" type="radio" name="facNo" value="a1">제 1회의실</label>
				<label><input id="facility" type="radio" name="facNo" value="a2">제 2회의실</label>
				<label><input id="facility" type="radio" name="facNo" value="a3">제 3회의실</label>
				<label><input id="facility" type="radio" name="facNo" value="a4">제 4회의실</label>
			<%--  	<c:forEach var="f" items="facList">
					<label><input id="facility" type="radio" name="facNo" value="${f.facNo }">${f.facName }</label>
				</c:forEach> --%>
			</div>
			<div>
				<span>이용날짜</span>
				<input type="date">
			</div>
			<div>
				<span>이용시간</span>
				<input>
			</div>
			<button>예약하기</button>
		</form>
		</div>
	</div>
	
</section>


</body>
</html>