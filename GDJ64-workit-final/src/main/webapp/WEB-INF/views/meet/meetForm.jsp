<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<style>
  /* 기본 스타일링 */
  .row { display: flex; flex-direction: row; }
  .column { display: flex; flex-direction: column; }
  .center { display: flex; align-items: center; justify-content: center; text-align: center; }

  /* 색상 설정 */
  .bgc-fff { background-color: #fff; }
  .bgc-F8FCFF { background-color: #F8FCFF; }

  /* 게시판 헤더 */
  .head-nav { height: 56px; display: flex; align-items: center; padding-left: 30px; }
  .head-nav ul li { margin: 0px 5px; }
  
 	/* 컨테이너 */
 	.container{height: auto;}
 	#addEventForm{display: flex;text-align: center; flex-direction: column;align-items: center;justify-content: space-between; padding: 30px; width: 100%;}
  .form-group{width: 100%;display: flex; justify-content: flex-start; margin: 20px;}
  .form-group label {width: 10%; }
.form-group textarea, .form-group input {width: 50%;}
  </style>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<section class="max1920px">
	<jsp:include page="/WEB-INF/views/common/side-nav.jsp" />
    <div class="main-section bgc-F8FCFF">        
        <div class="section-shadow bgc-fff head-nav">
            <ul class="row">
                <li>회의실 예약</li>
                <li>|</li>
                <li>예약 신청</li>
            </ul>
        </div>
        <div class="section-shadow bgc-fff">
	        <div class="container mt-5">
		        <form id="addEventForm" method="post" action="${path }/meet/insertMeet">
		        	<div class="form-group">
					    <label for="roomSelector">회의실:</label>
			        	<select id="roomSelector" name="roomId" style="margin-bottom: 20px;">
			                <option value="1">회의실 A</option>
			                <option value="2">회의실 B</option>
			                <option value="3">회의실 C</option>
			          	</select>
					</div>
					<div class="form-group">
		                <label for="eventUser">신청자 : </label>
		                <input type="text" id="eventUser" required readonly value="${loginMember.memberName }" style="background-color: var(--main-disabled);">
		            </div>
		            <div class="form-group">
		                <label for="eventTitle">제목 : </label>
		                <input type="text" name="title" id="eventTitle" required>
		            </div>
		            <div class="form-group">
		                <label for="eventDescription">내용 : </label>
		                <textarea id="eventDescription" name="description" required></textarea>
		            </div>
		            <div class="form-group">
		                <label for="eventDate">날짜 : </label>
		                <input type="date" name="eventDate" id="eventDate" required>
		            </div>
		            <div class="form-group">
		                <label for="eventStart">시작 시간 : </label>
		                <input type="time" name="startTime" id="eventStart" required>
		            </div>
		            <div class="form-group">
		                <label for="eventEnd">종료 시간 : </label>
		                <input type="time" name="endTime" id="eventEnd" required>
		            </div>
		            <button type="submit">추가하기</button>
		        </form>
	    	</div>
	
        </div>
	</div>
</section>
<script>
$(document).ready(function() {
    // eventDate input 필드의 min 속성 설정
    var today = new Date();
    today.setHours(today.getHours() + 9);
    today = today.toISOString().split('T')[0];

    $('#eventDate').attr('min', today);
	
    // 시작시간을 변경하면 종료시간의 min 속성을 변경
    $('#eventStart').change(function() {
        var startTime = $(this).val();
        $('#eventEnd').attr('min', startTime);
    });

    // 종료시간을 변경하면 시작시간의 max 속성을 변경
    $('#eventEnd').change(function() {
        var endTime = $(this).val();
        $('#eventStart').attr('max', endTime);
    });
});
$("#addEventForm").submit(function(event) {
    event.preventDefault();

    var roomId = $("#roomSelector").val();
    var eventDate = $("#eventDate").val();
    var startTime = $("#eventStart").val();
    var endTime = $("#eventEnd").val();

    $.ajax({
        url: "${path}/meet/checkOverlap",
        method: "POST",
        data: {
            roomId: roomId,
            eventDate: eventDate,
            startTime: startTime,
            endTime: endTime
        },
        success: function(isAvailable) {
            if (isAvailable) {
            	/* alert("중복없음!"); */
               $("#addEventForm")[0].submit();
            } else {
                alert("선택한 시간에 이미 예약된 회의가 있습니다.");
            }
        }
    });
});

</script>


</body>
</html>