<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<c:set var="mId" value="${loginMember.memberId}"/>
<link rel="stylesheet" href="${path}/resources/css/main/main.css">
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<section class="max100per">
	<jsp:include page="/WEB-INF/views/common/side-nav.jsp" />
	<div class="main-section section-shadow">
		<div class="right-container">

			<div id="mainFlex">
				<div id="section1" class="marginBottom mainMarginRight">
					<div id="approveFont">
						<span>&nbsp;&nbsp;미결재(${approveCnt})</span> <span id="showMoreApp"
							onclick="location.href='${path}/approve/waitingApprove.do?mId=${loginMember.memberId}';">더보기(+)</span>
					</div>
					<hr id="appHr">
					<table class="table">
						<tr id="mainTh">
							<th>작성자</th>
							<th>작성일</th>
						</tr>
						<c:if test="${empty approves}">
							<tr>
								<td colspan="2" id="noApp">결재할 문서가 없습니다</td>
							</tr>
						</c:if>
						<c:if test="${not empty approves}">
							<c:forEach var="approve" items="${approves}">
								<tr id="approveTr"
									onclick="location.href='${path}/approve/detailApprove.do?approveNo=${approve.approveNo}&approveKind=${approve.approveKind }&approveState=${approve.approveState}&name=결재대기문서';">
									<td>${approve.memberId.memberName}</td>
									<td>${approve.currentDate }</td>
								</tr>
							</c:forEach>
						</c:if>
					</table>
				</div>

				<div id="section1" class="marginBottom mainMarginRight">
					<p id="toDo">To Do</p>
					<input type="text" id="toDoText" placeholder="해야할 일 적기"> <input type="button" id="toDoButton" value="추가">
						
						<div id="toDiv">
						<hr>
					<c:if test="${not empty toDos}">
							<c:forEach var="toDo" items="${toDos}">
								<div class="toDoFlex" id="${toDo.toDoNo}">
									<p>${toDo.toDoContent}</p>
									<img src="${path}/resources/images/approve/xbutton.png" class="deleteImg">
								</div>
								
							</c:forEach>
					</c:if>
						</div>
				</div>
				<div id="section1" class="marginBottom mainMarginRight">
					<p id="bookFont">신청한 강의실</p>
					<hr id="appHr">
					<table>
						<c:if test="${empty books}">
							<c:forEach var="book" items="${books}">
								<tr id="tr"
									onclick="location.href='${path}/approve/detailApprove.do?approveNo=${waitingApp.approveNo}&approveKind=${waitingApp.approveKind }&approveState=${waitingApp.approveState}&name=결재대기문서';">
									<td>내용</td>
									<td>날짜</td>
								</tr>
							</c:forEach>
						</c:if>
					</table>
					<c:if test="${empty books}">
						<p id="noticeFont">예약한 강의실이 없습니다</p>
					</c:if>
				</div>
			</div>
			<div id="mainFlex">
				<div id="section2" class="marginBottom">
					<div>
						<div id="approveFont">
							<span>&nbsp;&nbsp;${boards[0].member.dept.deptName}게시판</span> <span id="showMoreBoard"
								onclick="location.href='${path}/board/boardList	';">더보기(+)</span>
						</div>

						<hr id="appHr">
						<table class="table">
							<tr id="mainTh">
								<th>내용</th>
								<th>작성일</th>
							</tr>
							<c:if test="${not empty boards}">
								<c:forEach var="board" items="${boards}">
									<tr id="boardTr"
										onclick="location.href='${path}/board/boardView?no=${board.boardNo}';">
										<td>${board.boardTitle}</td>
										<td>${board.boardDate}</td>
									</tr>
								</c:forEach>
							</c:if>
						</table>
						<c:if test="${empty boards}">
							<p id="noticeFont">조회할 게시글이 없습니다</p>
						</c:if>
					</div>
				</div>
				<div id="section2" class="marginBottom">
					<div>
						<div id="approveFont">
							<span>&nbsp;&nbsp;공지사항</span> <span id="showMoreNotice"
								onclick="location.href='${path}/board/noticeList';">더보기(+)</span>
						</div>
						<hr id="appHr">
						<table class="noticeTable">
							<tr id="mainTh">
								<th>제목</th>
								<th>작성일</th>
							</tr>
							<c:if test="${not empty notices}">
								<c:forEach var="notice" items="${notices}">
									<tr id="noticeTr"
										onclick="location.href='${path}/board/noticeView?no=${notice.noticeNo}';">
										<td>${notice.noticeTitle}</td>
										<td>${notice.noticeDate}</td>
									</tr>
								</c:forEach>
							</c:if>
						</table>
						<c:if test="${empty notices}">
							<p id="noticeFont">조회할 공지사항이 없습니다</p>
						</c:if>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>

</body>
</html>

<script>
	$("#toDoButton").click(function(){
		if(document.getElementsByClassName('toDoFlex').length >= 5){
			alert("최대 5개까지만 추가 가능합니다");
			$("#toDoText").val("");
			return false;
		}
	
		$.post("${path}/approve/insertToDo",
				{mId:${mId},content:$("#toDoText").val()},   // 데이터를 객체로(키,값) 전달
				data => {
					$("#toDiv").append($('<div/>', {class: 'toDoFlex', id:data.toDoNo}));
					$("#"+data.toDoNo).append($('<p/>'));
					$("#"+data.toDoNo).text(data.toDoContent);
					$("#"+data.toDoNo).append($('<img>',{src:"${path}/resources/images/approve/xbutton.png",width:'20px',height:'20px',class:"deleteImg"}));
					$("#toDoText").val("");
			});
	})
	
	$(".deleteImg").click(function(){
	$.post("${path}/approve/deleteToDo",
			{no:$(this).parent("div").attr("id")},   // 클릭한 태그의 부모 div의 id값을 데이터로넣음 => toDoNo 값임
			data => {

				$("#"+data).remove();
		});
});
	

	
</script>

