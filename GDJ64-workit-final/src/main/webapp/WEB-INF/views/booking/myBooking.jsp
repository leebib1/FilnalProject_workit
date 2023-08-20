<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<section class="max1920px">
	<jsp:include page="/WEB-INF/views/common/side-nav.jsp"/>
	<div class="main-section section-shadow card">
     	<div class="right-container">
			<h3>나의 예약 내역</h3>
		<!-- 더보기 버튼 눌러 디테일 모달창 구현, 회의이면 회의록 등록/상담이면 상담내역등록 -->
		<!-- 리스트(테이블)로 예약 내역 출력, 이용날짜가 과거이면 취소 버튼 없이 더보기버튼만. -->
			<div id="searchBar">
				<select>
					<option value="">날짜</option>
					<option value="">이용여부</option>
				</select>
				<input type="date">
				<select>
					<option value="">이용완료</option>
					<option value="">예약완료</option>
				</select>
			</div>
			<div id="selecttTable">
				<table>
					<tr>
						<th>사용목적</th>
						<th>신청인</th>
						<th>이용날짜</th>
						<th>이용시설</th>
						<th>이용시간</th>
						<th>예약취소</th>
						<th>더보기</th>
					</tr>
				</table>
			</div>
			<div id="pageBar">
			</div>
		</div>
	</div>
</section>


</body>
</html>