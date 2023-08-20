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
	        <li>강의 등록 내역</li>
	      </ul>
	    </div>
		<div class="column section-shadow bgc-fff" id="lectureDiv">
		<!-- 운영팀 팀장 || 부사장 || 대표 만 볼 수 있는 div -->
			<c:if test="${loginMember.dept.deptCode eq 'D1' && loginMember.job.jobCode eq 'J3' || loginMember.job.jobCode eq 'J2'||loginMember.job.jobCode eq 'J1' }">
				<div class="row" style="justify-content: space-between; padding:10px 100px;">
			    	<div class="row"> 
		                <select name="registrationStatus">
						    <option value="waiting">대기중</option>
						    <option value="approved">승인</option>
						    <option value="rejected">반려</option>
						</select>
						<button style="margin-left: 10px;" id="statusUpdateBtn" class="btnSimple">변경</button>
	                </div>
	                <div>
	                	<button id="goToUpdateView">수정</button>
	                	<button id="deleteBtn" class="btnSimple">삭제</button>
	                </div>
				</div>
				</c:if>
		        <div class="row">
		            <!-- 왼쪽 부분 -->
		            <div class="column margin10px half" style="flex: 1; border-right: 1px dashed var(--border-color);">
		            	<div>
			                <button id="listBtn" class=" btnSimple">목록</button>
		            	</div>
			            <div class="row" style="justify-content: space-between;">
			            	<div class="input-group">
			                	<label>강의명</label>
			                	<input type="text" name="lectureName" value="${lecture.lectureName }" readonly>
							</div>
							<div class="input-group">   
				                <label>강사명</label>
				                <select name="memberId">
				                       <option value="${lecture.member.memberId}">${lecture.member.memberName}</option>
				                </select>
			                </div>
			            </div>
						<div class="input-group">
		    	            <label>강의목표</label>
			                <textarea name="lectureObjective" rows="10" readonly>${lecture.lectureObjective }</textarea>
						</div>
						<div class="input-group">
		    	            <label>강의내용</label>
			                <textarea name="lectureContent" rows="10" readonly>${lecture.lectureContent }</textarea>
						</div>
		            </div>
		
		            <!-- 오른쪽 부분 -->
		            <div class="column margin10px half" style="flex: 1;">
		
						<div class="input-group">
		               		<label>과목</label>
			                <input type="text" name="subject" value="${lecture.subject}" readonly>
						</div>
						<div class="input-group">
		                	<label>대상</label>
		                	<input type="text" name="lectureTarget" value="${lecture.lectureTarget }" readonly>
						</div>
						<div class="input-group">
		                	<label>수강료 (단위 : 원) </label>
		                	<input type="number" name="fee" value="${lecture.fee }" readonly>
		                </div>
		                <div class="input-group">
			                <label>강의 시작일</label>
			                <input type="date" name="startDate" value="${lecture.startDate }" readonly>
		                </div>
		                <div class="input-group">
		    	            <label>강의 종료일</label>
			                <input type="date" name="endDate" value="${lecture.endDate }" readonly>
		                </div>
		            </div>
		        </div>
		</div>
	</div>
</section>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    $(document).ready(function() {
    	$('#listBtn').on('click', function() {
            location.href = "${path}/lecture/lectureList";
        });
    	
        // 상태 변경 이벤트
        $("#statusUpdateBtn").click(function() {
            var selectedStatus = $("select[name='registrationStatus']").val();
            if(selectedStatus) {
                $.ajax({
                    type: "POST",
                    url: "${path}/lecture/updatStatus",
                    data: {
                        status: selectedStatus,
                        lectureNo: ${lecture.lectureNo}
                    },
                    success: function(response) {
                        alert("상태가 업데이트 되었습니다.");
                        location.href = "${path}/lecture/lectureList"; // 강의 목록 페이지로 리다이렉트
                    },
                    error: function(error) {
                        alert("상태 업데이트에 실패하였습니다.");
                    }
                });
            }
        });

        // 수정 이벤트
        $("#goToUpdateView").click(function() {
            window.location.href = "${path}/lecture/updateLecture?no=" + ${lecture.lectureNo};
        });

        // 삭제 이벤트
        $("#deleteBtn").click(function() {
            var confirmDelete = confirm("강의를 삭제하시겠습니까?");
            if(confirmDelete) {
                $.ajax({
                    type: "POST",
                    url: "${path}/lecture/deleteLecture", 
                    data: {
                    	no: ${lecture.lectureNo}
                    },
                    success: function(response) {
                        alert("강의가 삭제되었습니다.");
                        location.href = "${path}/lecture/lectureList"; // 강의 목록 페이지로 리다이렉트
                    },
                    error: function(error) {
                        alert("강의 삭제에 실패하였습니다.");
                    }
                });
            }
        });
    });
</script>



</body>
</html>