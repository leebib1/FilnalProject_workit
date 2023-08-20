<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.workit.member.model.vo.MemberVO"  %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>        

 <%
   MemberVO loginMember=(MemberVO)session.getAttribute("loginMember");
  %>                  

 <c:set var="path" value="${pageContext.request.contextPath }"/>     
   <div class="side-nav-container max90per section-shadow">
      <div class="side-nav">
         <h2 class="title">메뉴</h2>
      </div>
   <div class="side-menu-container">
      <div>
         <a class="side-menu" id="employee"><img src="${path}/resources/images/common/member.svg" class="menu-icon">인사 관리</a>
         <ul class="menu-toggle" style="display:none">
            <li><a href="${path }/employee/enroll">사원 생성</a></li>
            <li><a href="${path }/employee/list">사원 조회</a></li>
            <li><a href="${path }/employee/dept">부서 관리</a></li>
            <li><a href="${path }/employee/job">직책 관리</a></li>
            <li><a href="${path }/employee/approv">사원정보 수정 요청 조회</a></li>
         </ul>
      </div>
      <div>
         <a class="side-menu"><img src="${path}/resources/images/common/work.svg">근태 관리</a>
         <ul class="menu-toggle" style="display:none">
            <li><a href="${path }/work/workTime">내 출근부</a></li>
            <c:if test="${loginMember.dept.deptName eq '인사팀'}">
	            <li><a href="${path }/work/workChange">출퇴근 시간 수정</a></li>
            </c:if>
            <c:if test="${loginMember.job.jobName eq '팀장'}">
	            <li><a href="${path }/work/workTimeByTeam">${loginMember.dept.deptName} 출근부</a></li>
            </c:if>
         </ul>
      </div>
      <div>
         <a class="side-menu"><img src="${path}/resources/images/common/lecture.svg">강의 관리</a>
         <ul class="menu-toggle" style="display:none">
            <li><a href="${path }/lecture/lectureList">강의 목록</a></li>
         </ul>
      </div>
      <div>
         <a class="side-menu"><img src="${path}/resources/images/common/booking.svg">회의실 예약</a>
         <ul class="menu-toggle" style="display:none">
            <li><a href="${path }/meet/meetList">예약 목록</a></li>
            <li><a href="${path }/meet/meetForm">예약 신청</a></li>
            <li><a href="${path }/meet/myMeetList">내 예약 목록</a></li>
         </ul>
      </div>
      <div>
         <a class="side-menu"><img src="${path}/resources/images/common/board.svg">게시판</a>
         <ul class="menu-toggle" style="display:none">
            <li><a href="${path }/board/noticeList">공지사항</a></li>
            <li><a href="${path }/board/boardList">${loginMember.dept.deptName} 게시판</a></li>
         </ul>
      </div>
      <div>
         <a id="approve-menu"><img src="${path}/resources/images/common/approve.svg">전자결재</a>
         <div id="div-approve">
            <button class="approval-request">결재신청</button>
            <button onclick="location.href='${path}/approve/waitingApprove.do?mId=${loginMember.memberId}';">결재대기문서함</button>
            <button onclick="location.href='${path}/approve/draftDocumentBox.do?mId=${loginMember.memberId}';">기안문서함</button>
            <button onclick="location.href='${path}/approve/referenceDocumentBox.do?mId=${loginMember.memberId}';">참조문서함</button>
            <button onclick="location.href='${path}/approve/saveDocument.do?mId=${loginMember.memberId}';">임시저장함</button>
         </div>
      </div>
      <div>
         <a class="side-menu" href="${path}/chat/"><img src="${path}/resources/images/common/chat.svg">메신저</a>
      </div>
   </div>
</div>
<script>
	$(".menu-icon").click(e=>{
		fn_openMenu(e);
	})
	const fn_openMenu=(e)=>{
		console.log($(e.target));
		$(e.target).parent().next().toggle();
	}
	
	$(".side-menu").click(function (e){
		$(e.target).next().toggle();
	});
</script>
<jsp:include page="/WEB-INF/views/approve/select-payment-form.jsp" />