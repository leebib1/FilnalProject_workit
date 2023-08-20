	<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<c:set var="approveNo" value="${approveNo}"/>
<c:set var="approveState" value="${approveState}"/>
<c:set var="approveKind" value="${approveKind}"/>
<c:set var="oriFileName" value="${oriFileName}"/>
<c:set var="saveFileName" value="${saveFileName}"/>
<c:set var="writer" value="${saveExtends[0].memberId.memberId}"/>

<jsp:include page="/WEB-INF/views/common/header.jsp" />


<link rel="stylesheet"
	href="${path}/resources/css/approve/drafting_app.css">
<section class="max1920px">
	<jsp:include page="/WEB-INF/views/common/side-nav.jsp" />

	<form action="#" id="appForm" method="post"
		enctype="multipart/form-data">

		<div class="approve-section2 section-shadow">
				<div id="approve_name">
					결재대기문서
						
		
						<img id="pencil" onclick="fullPayment();" src="${path}/resources/images/approve/pencil.png">
						<span id="pencilFont">전결</span>
				</div>
				<div id="one-width">
					<div id="kind">지출결의서</div>
					<div id="app-line" class="answer"></div>
				</div>

				<div id="one-width">
						<div id="department" class="question">부서</div>
						<div id="department-answer" class="answer">${saveExtends[0].memberId.dept.deptName}</div>
						<div id="writer" class="question">기안자</div>
						<div id="writer-answer" class="answer">${saveExtends[0].memberId.memberName}</div>
						<div id="position" class="question">직책</div>
						<div id="position-answer" class="answer">${saveExtends[0].memberId.job.jobName}</div>
				</div>

				<div id="one-width">
					<div id="extendWorkWriteDate" class="question">작성일</div>
					<div id="extendWorkWriteDate-answer" class="answer">${time}</div>
				</div>

				<div id="one-width">
					<div id="expenditureTimeTitle" class="question">제목</div>
					<div id="expenditureTitle-answer" class="answer">
							<input type="text" id="title-input" name="title" value="${saveExtends[0].approveTitle}">
					</div>
				</div>

				<input type="hidden" name="memberId" value="${loginMember.memberId}">
				<input type="hidden" name="approveKind" value="지출결의서">

				<div id="one-width">
					<div id="account" class="question">거래처</div>
					<div id="use-history" class="question">사용내역 및 용도</div>
					<div id="price" class="question">금액</div>
				</div>
				<div id="one-width">
					<input type="text" id="account0" name="account" class="answer" readonly>
					<input type="text" id="use-history0" name="useHistory" class="answer" readonly> 
					<input type="text" id="price0" name="price" class="answer" readonly>
				</div>
				<div id="one-width">
					<input type="text" id="account1" name="account" class="answer" readonly>
					<input type="text" id="use-history1" name="useHistory" class="answer" readonly> 
					<input type="text" id="price1" name="price" class="answer" readonly>
				</div>
				<div id="one-width">
					<input type="text" id="account2" name="account" class="answer" readonly>
					<input type="text" id="use-history2" name="useHistory" class="answer" readonly> 
					<input type="text" id="price2" name="price" class="answer" readonly>
				</div>
				<div id="one-width">
					<input type="text" id="account3" name="account" class="answer" readonly>
					<input type="text" id="use-history3" name="useHistory" class="answer" readonly> 
					<input type="text" id="price3" name="price" class="answer" readonly>
				</div>
				<div id="one-width">
					<input type="text" id="account4" name="account" class="answer" readonly>
					<input type="text" id="use-history4" name="useHistory" class="answer" readonly> 
					<input type="text" id="price4" name="price" class="answer" readonly>
				</div>
				<div id="one-width">
					<input type="text" id="account5" name="account" class="answer" readonly>
					<input type="text" id="use-history5" name="useHistory" class="answer" readonly> 
					<input type="text" id="price5" name="price" class="answer" readonly>
				</div>

				<div id="one-width">
					<div id="appAttachment" class="question">첨부파일</div>
					<div id="appAttachment-answer" class="answer">
					<input type="file" id="appAttachment-input" name="upFile" style="display:none;">
					<button type="button" id="fileClickId" onclick="fn_fileDownload('${oriFileName}','${saveFileName}')">파일을 선택하세요</button>
					</div>
				</div>

				<div id="one-width">
						<button type="button" onclick="backs();" id="back">돌아가기</button>
						<button type="button" onclick="rejectApp();" id="reject">결재반려</button>
						<button type="button" onclick="assign();" id="approveAssign">결재승인</button>
				</div>

			</div>
		</div>
<jsp:include page="/WEB-INF/views/approve/reject-view.jsp"/>
	</form>
	</html>

<script>
	const fullPayment=()=>{
		location.assign("${path}/approve/fullPayment.do?approveNo=${approveNo}&mId=${loginMember.memberId}&writer=${writer}&approveKind=${approveKind}");
	}


	function fn_fileDownload(oriName,reName){
		if(oriName==""){
			return false;
		}else{
			location.assign("${path}/approve/filedownload?oriname="+oriName+"&rename="+reName);			
		}
	};
	
	$(function() {	
		const approveLines=JSON.parse('${approveLines}'); // 자바스크립트에서 해당 JSON.parse 구문을통해 해당 값을 객체로 반환
		const referLines=JSON.parse('${referLines}'); 
		const expenditures=JSON.parse('${expenditures}'); 
	
		console.log(expenditures);
		
		for(let i=0; i<expenditures.length; i++){
			$("#account"+i).val(expenditures[i].account);
			$("#use-history"+i).val(expenditures[i].useHistory);
			$("#price"+i).val(expenditures[i].price);
		}

		if("${oriFileName}"==""){
			$("#fileClickId").text("파일을 선택하세요"); 
		}else{
			$("#fileClickId").text("${oriFileName}"); 
		}
		
		for(let i=0; i<approveLines.length; i++){
			const di = $("<div>").css("border", "1px solid black").height("98px").width("120px");
			$("#app-line").append(di);
			di.append($("<div>").css("border-bottom", "1px solid black").height("30px").width("120px").text(approveLines[i].memberId.memberName + " " + approveLines[i].memberId.job.jobName).css("text-align","center"));
			const stateCheck = $("<div>").height("40px").width("120px");
			di.append(stateCheck);
			if(approveLines[i].approveStatus == "완료"){
				stateCheck.html("<img src='${path}/resources/images/approve/stamp.png' width='40px' height='40px'/>").css("text-align","center");
			}
			di.append($("<div>").css("border-top", "1px solid black").height("28px").width("120px").text(i+1).css("align-items","center"));
		}
		
	});
	
	
	const backs = () => {
	    location.assign("${path}/");
	}

	
	const rejectApp=()=>{
		$("#rejectContentInput").val("");
 		document.querySelector(".reject").classList.remove("hidden-reject");
 
		const appclose = () => { // 모달창 사람지는 함수
		 	document.querySelector(".reject").classList.add("hidden-reject");
		}
		
		const rejectWrite=()=>{
			appclose();
			const message = $("#rejectContentInput").val();
			location.assign("${path}/approve/rejectMessage.do?approveNo=${approveNo}&mId=${loginMember.memberId}&message="+message);		
		}
		
		document.querySelector("#reject-close-button").addEventListener("click", appclose); // 모달창에서 닫기버튼 눌렀을 때 appclose함수 호출
		document.querySelector(".bg-reject").addEventListener("click", appclose);  // 모달창에서 바깥배경 눌렀을 때 appclose함수 호출
		document.querySelector("#reject-write-button").addEventListener("click", rejectWrite);  // 모달창에서 반려버튼 눌렀을 때 rejectWrite함수 호출
	} 
	
	const assign=()=>{
		location.assign("${path}/approve/approveAssign.do?approveNo=${approveNo}&mId=${loginMember.memberId}&writer=${writer}&approveKind=${approveKind}");
	}
	

	
</script>