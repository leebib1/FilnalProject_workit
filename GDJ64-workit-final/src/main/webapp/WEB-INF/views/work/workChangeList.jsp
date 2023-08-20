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
  /* 조회 월 선택 */
  .sec_cal { width: 100%; margin: 0 auto; font-family: "NotoSansR"; }
  .cal_tblDiv { display: flex; flex-direction: column; align-items: flex-start; }
  .cal_tbl { width: 95%; margin: 0px 20px; padding: 10px; border-collapse: collapse; }
  .cal_tbl td, .cal_tbl th { border-bottom: 1px solid #e0e0e0;padding: 8px; text-align: center; }

	/*Modal */
	.max100px{max-width: 100px;}
	.openReasonBtn{background-color: #fff;font-size: 16px;}
	.openReasonBtn:hover{background-color: #fff;border: none; color:var(--main-color-dk); }
	.modal-background {display: none;position: fixed;z-index: 1;left: 0;top: 0;width: 100%;height: 100%;overflow: auto;background-color: rgba(0,0,0,0.4);}
	.modal-content {background-color: #fefefe;margin:auto;padding: 30px;border: 1px solid #888;width: 80%;
   		max-width: 400px;box-shadow: 0 4px 8px rgba(0,0,0,0.1);border-radius: 8px;position: relative;transform: translateY(-50%);top: 50%;}
	.close {color: #aaaaaa; position: absolute;top: 10px;right: 10px;font-size: 28px;font-weight: bold;}
	.close:hover, .close:focus {color: #000;text-decoration: none;cursor: pointer;}
	.lableDiv{justify-content: space-around;align-items: center;margin: 5px;}
	#submitApprove{ margin: 20px 0; align-self: center;}

  	/* pagebar */
  	.pageBar li{width: 32px;height: 32px;text-align: center;}
  	.pageBar li:hover{color: #fff; font-weight: bolder; background-color:var(--main-color-dk); }
  	/* 버튼 */
  	.tdBtnContainer button{color: #fff;}
</style>
<section class="max1920px">
	<jsp:include page="/WEB-INF/views/common/side-nav.jsp" />
	<div class="main-section bgc-F8FCFF">		
	    <div class="section-shadow bgc-fff head-nav">
	      <ul class="row" style="margin-left: 30px">
	        <li>근태관리</li>
	        <li>|</li>
	        <li>출퇴근 시간 수정</li>
	      </ul>
	    </div>
	    <div class="column section-shadow bgc-fff" id="workChangeDiv">
		    <!-- 승인을 위한 시간 수정 Modal -->
		<div id="approveModal" class="modal-background">
		    <div class="modal-content">
		        <span class="close">&times;</span>
		        <div class="column">
			        <div class="row lableDiv">
				        <label>출근 시간:</label>
				        <input type="time" id="approveStartTime">
			        </div>
			        <div class="row lableDiv">
				        <label>퇴근 시간:</label>
				        <input type="time" id="approveEndTime">
			        </div>
			        <div class="row lableDiv">
				        <label>근무상태:</label>
				        <select id="workStatus">
				           <option value="normal">정상출근</option>
						   <option value="late">지각</option>
						   <option value="early_leave">조퇴</option>
				        </select>
			        </div>
			        <button id="submitApprove">확인</button>
		        </div>
		    </div>	
		</div>
	      <div class="sec_cal">
	        <div class="cal_tblDiv" style="padding: 10px;">
	         <table class="cal_tbl">
	         	<thead>
	         		<tr>
	         			<th>번호</th>
	         			<th>출근일자</th>
	         			<th>사원번호</th>
	         			<th>소속 팀</th>
	         			<th>직급</th>
	         			<th>사원명</th>
	         			<th>출근시간</th>
	         			<th>퇴근시간</th>
	         			<th>요청사유</th>
	         			<th>수정상태</th>
	         			<th></th>
	         		</tr>
	         	</thead>
	         	<tbody>
	         	<c:if test="${empty workChangeList }">
	         	<tr>
	         		<td colspan="10">조회된 출퇴근 수정 요청이 없습니다.</td>
	         	</tr>
	         	</c:if>
				<c:if test="${not empty workChangeList }">
					<c:forEach var="changeItem" items="${workChangeList }">
						 <tr class="work-change-row">
						 	<td>
							 	<c:out value="${changeItem.workChangeNo }"/>
							 	<input type="hidden" value="${changeItem.workChangeNo }" />
							 	<input type="hidden" value="${changeItem.work.workNo }" />
						 	</td>
			                <td> <fmt:formatDate value="${changeItem.work.workDate}" pattern="yy/MM/dd E" /></td>
			                <td><c:out value="${changeItem.work.member.memberId }"/></td>
			                <td><c:out value="${changeItem.work.member.dept.deptName }"/></td>
			                <td><c:out value="${changeItem.work.member.job.jobName }"/></td>
			                <td><c:out value="${changeItem.work.member.memberName }"/></td>
			                <td><fmt:formatDate value="${changeItem.work.workStart}" pattern="HH:mm:ss" /></td>
			                <td><fmt:formatDate value="${changeItem.work.workEnd}" pattern="HH:mm:ss" /></td>
			                <td class="short-reason max100px">
			                	<input type="hidden" value="${changeItem.reason }" />
			                	<button class="openReasonBtn">열기</button>
			                </td>
			                
			                <td><c:out value="${changeItem.changeStatus }"/></td>
			                <c:if test="${changeItem.changeStatus eq '수정 요청' }">
			                <td class="tdBtnContainer">
			                	<button name="requestApproveBtn">승인</button>
			                	<button name="requestDeleteBtn">삭제</button>
			                </td>
			                </c:if>
			                <c:if test="${changeItem.changeStatus eq '수정 완료' }"><td></td></c:if>
	          			  </tr>
					</c:forEach>
				</c:if>
	         	</tbody>
	         </table>
	        </div>
	      </div>
	      <div id="pageBarDiv" class="pageBar">
	      	${pageBar }
	      </div>
	    </div>
	</div>
	<!-- 요청사유 Modal -->
	<div id="reasonModal" class="modal-background">
	  <div class="modal-content">
		    <span class="close">&times;</span>
		    <p id="modalBodyContent"></p>
  		</div>	
	</div>
	
</section>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript">


$(document).ready(function(){
	//요청사유 전체 출력 모달창 열고 닫는 함수
    $(".openReasonBtn").css('cursor', 'pointer').on('click', function(){
        let reasonContent = $(this).prev().val();
        $("#modalBodyContent").text(reasonContent);

        let modal = $("#reasonModal");
        modal.show();

        modal.find('.close').on('click', function(){
            modal.hide();
        });

        $(window).on('click', function(event){
            if ($(event.target).is(modal)) {
                modal.hide();
            }
        });
    });
    
 // 승인 버튼 클릭 이벤트
    $("[name='requestApproveBtn']").on('click', function() {
        // Modal 창 표시
        $("#approveModal").show();
        $("#approveModal .close").on('click', function() {
            $("#approveModal").hide();
        });
        // 현재 클릭된 버튼을 전역 변수로 저장
        window.currentApproveButton = $(this);
    });

    // Modal 창의 확인 버튼 클릭 이벤트
    $("#submitApprove").on('click', function() {
    	const workChangeNo = window.currentApproveButton.closest('.work-change-row').find('td:first-child input:first-child').val();
    	const workNo = window.currentApproveButton.closest('.work-change-row').find('td:first-child input:nth-child(2)').val();
        const workStartTime = $("#approveStartTime").val();
        const workEndTime = $("#approveEndTime").val();
        const workStatus = $("#workStatus").val();
          if (confirm("수정 요청을 승인하시겠습니까?")) {
            $.ajax({
                url: "${path}/work/approveRequest",
                type: "POST",
                data: {
                	workChangeNo: workChangeNo,
                    workNo: workNo,
                    workStart: workStartTime,
                    workEnd: workEndTime,
                    workStatus:workStatus
                },
                success: function(response) {
                    alert("성공적으로 승인되었습니다.");
                    location.reload();
                },
                error: function() {
                    alert("오류가 발생했습니다. 다시 시도해주세요.");
                }
            });
        } 
        $("#approveModal").hide();
    });

    //삭제 버튼 클릭 이벤트
    $("[name='requestDeleteBtn']").on('click', function() {
    	const workChangeNo = $(this).closest('.work-change-row').find('td:first-child input:first-child').val();
        if (confirm("수정 요청을 삭제하시겠습니까?")) {
            $.ajax({
                url: "${path}/work/deleteRequest",
                type: "POST",
                data: {
                	workChangeNo: workChangeNo
                },
                success: function(response) {
                    alert("성공적으로 삭제되었습니다.");
                    location.reload();
                },
                error: function() {
                    alert("오류가 발생했습니다. 다시 시도해주세요.");
                }
            });
        }
    });
    
    
    
});
</script>

</body>
</html>