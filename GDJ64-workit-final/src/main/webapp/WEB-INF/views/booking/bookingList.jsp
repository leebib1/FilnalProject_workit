<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>    
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<section class="max1920px">
<jsp:include page="/WEB-INF/views/common/side-nav.jsp"/>
<c:set var="path" value="${pageContext.request.contextPath }"/>
	<div class="main-section section-shadow card">
      	<div class="right-container">
			<h3>시설 예약 내역</h3>
	<!-- 전체 예약(사용 전/후 모두 포함)에 대한 내역조회 -->
	<!-- 신청자/날짜로 조회 가능 -->
			<button type="button" onclick="location.assign('${path}/booking/showCalendar.do')">캘린더</button>
			
			<div id="search-container">
			<select name="type" id="searchType">
				<option value="" selected disabled>날짜/예약자로 검색</option>
				<option value="bookingDate">날짜</option>
				<option value="memberId">예약자</option>
			</select>
				<!-- <input type="date" name="bookingDate">
				<input type="text" name="memberId" placeholder="예약자 이름을 입력하세요">
				<button>검색</button> -->
			<div id="search-bookingDate">
				<form action="${path }/booking/searchDate.do">
					<input type="hidden" name="searchType" value="bookingDate">
					<input type="text" name="searchKeyword" size="25" placeholder="예)2023년 8월 1일=>20230801">
					<button type="submit">검색</button>
				</form>
			</div>
			<div id="search-memberId">
				<form action="${path }/booking/searchMemberId.do">
					<input type="hidden" name="searchType" value="memberId">
					<input type="text" name="searchKeyword" placeholder="예약자 이름을 입력하세요">
					<button type="submit">검색</button>
				</form>
			</div>
			</div>
			
			<button type="button" onclick="location.assign('${path}/booking/addBooking.do')">예약하기</button>
 			
 			<table id="bookingListTbl">
				<tr>
					<th>목적</th>
					<th>예약자</th>
					<th>이용날짜</th>
					<th>이용시설</th>
					<th>이용시간</th>
					<th>비고</th>
				</tr>
				<c:if test="${empty list }">
					<tr>
						<td colspan="7">예약 내역이 없습니다</td>
					</tr>
				</c:if>
				<c:forEach var="b" items="${list }">
					<tr>
						<td><c:if test="${b.purpose } equals '0'">상담</c:if></td>
						<td>${b.memberId }</td>
						<td>${b.bookingDate }</td>
						<td>${b.facNo }</td>
						<td>${b.startTime }~${b.endTime }</td>
						<%-- <td><a href="${path }/booking/bookingDetail.do?bookingNo=${b.bookingNo}">더보기</a></td> --%>
						<td><button type="button" id="detailBookingModal" data-toggle="modal" data-target="#detailBookingModal" data-title="data">더보기</button></td>
					</tr>
				</c:forEach>
			</table>
			
			<div>
				<%-- <c:out value="${pageBar }" escapeXml="false"/> --%>
				${pageBar }
			</div>			
		</div>
	</div>
	
	<div class="modal fade" id="detailBookingModal" tabindex="-1" role="dialog" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<!-- 예약 디테일 모달에 포함될 내용 작성 -->
				<button type="button" class="btn" id="" onclick="">수정</button>
				<button type="button" class="btn" id="" onclick="">삭제</button>
			</div>
		</div>
	
	</div>
</section>
<!-- <script>
/* select 바뀌는것에 따라 뒤의 인풋 종류 바뀌게] */
	${"#searchType"}.change(e=>{
		const type=${e.target}.val();
		${e.target}.parent().find("div").css("display","none");
		${"#search-"+type}.css("display","inline-block");
	})
/*display:none으로 먼저 두고 앞의 셀렉트 타입에 맞게 선택되면 그 인풋 보이도록 */
/*부모창에서 모달로 데이터 넘기기 */
    $('#exampleModal').on('show.bs.modal', function (event) {
  		var button = $(event.relatedTarget) // Button that triggered the modal
 		var recipient = button.data('whatever') // Extract info from data-* attributes
  		// If necessary, you could initiate an AJAX request here (and then do the updating in a callback).
  		// Update the modal's content. We'll use jQuery here, but you could use a data binding library or other methods instead.
  		var modal = $(this)
  		modal.find('.modal-title').text('New message to ' + recipient)
 		modal.find('.modal-body input').val(recipient)
	});
</script> -->
<style>
	#search-memberId{display:none}
	#search-bookingDate{display:none}
</style>

</body>
</html>