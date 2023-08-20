<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<style>
  /* 정렬, 색상 클래스 */
  .row { display: flex; flex-direction: row; }
  .column { display: flex; flex-direction: column; }
  .center { display: flex; align-items: center; justify-content: center; text-align: center; }
  .bgc-fff { background-color: #fff; }
  .bgc-F8FCFF { background-color: #F8FCFF; }
  .margin10px label, .margin10px input, .margin10px textarea,.margin10px button{margin: 10px;}

  /* 근태관리 nav */
  .head-nav { height: 56px; display: flex; align-items: center; }
  .head-nav ul li { margin: 0px 5px; }
  /* pagebar */
  	.pageBar li{width: 32px;height: 32px;text-align: center;}
  	.pageBar li:hover{color: #fff; font-weight: bolder; background-color:var(--main-color-dk); }

	#meetListDiv{padding: 20px;}
  .tableStyle { width: 95%; margin: 0px 20px; padding: 10px; border-collapse: collapse; margin: 20px 0;}
  .tableStyle td, .cal_tbl th { border-bottom: 1px solid #e0e0e0;padding: 8px; text-align: center; }
  .tableStyle tr{height: 60px;}
</style>
<section class="max1920px">
	<jsp:include page="/WEB-INF/views/common/side-nav.jsp" />
	<div class="main-section bgc-F8FCFF">
		<div class="section-shadow bgc-fff head-nav">
			<ul class="row" style="margin-left: 30px">
				<li>회의실 예약</li>
				<li>|</li>
				<li>내 예약 목록</li>
			</ul>
		</div>
		<div class="column section-shadow bgc-fff" id="meetListDiv">
			<div><p align="right" style="color: #de1951">종료시간이 지나기 전 예약건에 한하여 삭제가 가능합니다.<p></div>
			<div>
				<table class="tableStyle">
				    <thead>
				        <tr>
				            <th>회의 제목</th>
				            <th>회의실</th>
				            <th>설명</th>
				            <th>회의 일자</th>
				            <th>시작 시간</th>
				            <th>종료 시간</th>
				            <th>삭제</th>
				        </tr>
				    </thead>
				    <tbody>
				        <c:forEach items="${meets}" var="meet">
				            <tr>
				                <td>${meet.title}</td>
				                <td>${meet.room.roomName}</td>
				                <td>${meet.description}</td>
				                 <td> <fmt:formatDate value="${meet.eventDate}" pattern="yy/MM/dd" /></td>
				                <td><fmt:formatDate value="${meet.startTime}" pattern="HH:mm" /></td>
				                <td><fmt:formatDate value="${meet.endTime}" pattern="HH:mm" /></td>
				                <td>
				                    <c:if test="${meet.endTime gt now}">
				                        <button onclick="confirmDelete(${meet.id})">삭제</button>
				                    </c:if>
				                </td>
				            </tr>
				        </c:forEach>
				    </tbody>
				</table>
			</div>
			<div id="pageBarDiv" class="pageBar">
				${pageBar }
			</div>
		</div>
	</div>
</section>
<script>
	function confirmDelete(meetId) {
	    var userConfirmed = confirm("정말로 이 회의를 삭제하시겠습니까?");
	    
	    if(userConfirmed) {
	        $.post("${path}/meet/deleteMeet", {id: meetId}, function(data) {
	            if(data.success) {
	                alert("회의가 삭제되었습니다.");
	                location.reload();
	            } else {
	                alert("회의 삭제에 실패하였습니다.");
	            }
	        })
	        .fail(function() {
	            alert("서버와의 통신 중 오류가 발생하였습니다.");
	        });
	    }
	}

</script>

</body>
</html>