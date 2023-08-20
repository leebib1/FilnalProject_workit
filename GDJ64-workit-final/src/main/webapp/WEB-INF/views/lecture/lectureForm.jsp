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
  .margin10px label, .margin10px input, .margin10px textarea,.margin10px button,.margin10px select{margin: 10px;}

  /* 근태관리 nav */
  .head-nav { height: 56px; display: flex; align-items: center; }
  .head-nav ul li { margin: 0px 5px; }

	.half {width: 50%; padding: 20px 100px;}
    .input-group {margin-bottom: 5px;display: flex; flex-direction: column;}
    .input-group label{font-weight: bolder;}
    .input-group input{width: 300px;}
      /* 버튼스타일 */
  button{cursor: pointer; }
  .btnContiner{display: flex;justify-content: center;}
  .btnSimple{border: solid 1px #e0e0e0;background-color:#fff; }
  .btnSimple:hover{color:var(--main-color-dk);background-color:#fff;}
</style>
<section class="max1920px">
	<jsp:include page="/WEB-INF/views/common/side-nav.jsp" />
	<div class="main-section bgc-F8FCFF">
	    <div class="section-shadow bgc-fff head-nav">
	      <ul class="row" style="margin-left: 30px">
	        <li>강의 관리</li>
	        <li>|</li>
	        <li>강의 개설 신청</li>
	      </ul>
	    </div>
		<div class="column section-shadow bgc-fff" id="lectureFormDiv">
		    <form action="${path}/lecture/insertLectureEnd" method="post">
		        <div class="row">
		            <!-- 왼쪽 부분 -->
		            <div class="column margin10px half" style="flex: 1; border-right: 1px dashed var(--border-color);">
			            <div class="row" style="justify-content: space-between;">
			            	<div class="input-group">
			                	<label>강의명</label>
			                	<input type="text" name="lectureName" required placeholder="내용을 입력해주세요">
							</div>
							<div class="input-group">   
				                <label>강사명</label>
				                <select name="memberId">
				                    <c:forEach var="teacher" items="${teacherList}">
				                        <option value="${teacher.memberId}">${teacher.memberName}</option>
				                    </c:forEach>
				                </select>
			                </div>
			            </div>
						<div class="input-group">
		    	            <label>강의목표</label>
			                <textarea name="lectureObjective" rows="10" required placeholder="내용을 입력해주세요"></textarea>
						</div>
						<div class="input-group">
		    	            <label>강의내용</label>
			                <textarea name="lectureContent" rows="10" required placeholder="내용을 입력해주세요"></textarea>
						</div>
		            </div>
		
		            <!-- 오른쪽 부분 -->
		            <div class="column margin10px half" style="flex: 1;">
		
						<div class="input-group">
		               		<label>과목</label>
			                <input type="text" name="subject" required placeholder="내용을 입력해주세요">
						</div>
						<div class="input-group">
		                	<label>대상</label>
		                	<input type="text" name="lectureTarget" required placeholder="내용을 입력해주세요">
						</div>
						<div class="input-group">
		                	<label>수강료 (단위 : 원) </label>
		                	<input type="number" name="fee" required>
		                </div>
		                <div class="input-group">
			                <label>강의 시작일</label>
			                <input type="date" name="startDate" class="minStartDate" required>
		                </div>
		                <div class="input-group">
		    	            <label>강의 종료일</label>
			                <input type="date" name="endDate" class="minEndDate" required>
		                </div>
		
		                <div class="row btnContiner">
		                    <button type="submit">등록</button>
		                    <button type="reset" class="btnSimple">취소</button>
		                </div>
		            </div>
		        </div>
		    </form>
		</div>
	</div>
</section>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
$(document).ready(function() {
	var today = new Date();
    today.setHours(today.getHours() + 9);
    today = today.toISOString().split('T')[0];

    $('.minStartDate').attr('min', today);
    
    $('.minStartDate').on('change', function(e) {
        var startDate = $(".minStartDate").val();
        $('.minEndDate').attr('min', startDate);
    });
	
    $('.btnSimple').on('click', function(e) {
        e.preventDefault();
        var isCancel = confirm("등록을 취소하시겠습니까?");
        if (isCancel) {
            window.location.href = "${path}/lecture/lectureList"; // 강의 목록 페이지로 리다이렉트
        }
    });
});


</script>


</body>
</html>