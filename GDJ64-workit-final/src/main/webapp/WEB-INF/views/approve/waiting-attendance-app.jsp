<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<c:set var="approveNo" value="${approveNo}"/>
<c:set var="approveState" value="${approveState}"/>
<c:set var="approveKind" value="${approveKind}"/>
<c:set var="stime" value="${stime}"/>
<c:set var="etime" value="${etime}"/>
<c:set var="sdate" value="${sdate}"/>
<c:set var="edate" value="${edate}"/>
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
					<div id="kind">근태신청서</div>
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

				<input type="hidden" name="memberId" value="${loginMember.memberId}">

				<div id="one-width">
					<div id="attendance-kind" class="question">종류</div>
					<div id="div-annual" class="answer">
						연차<input type="radio" id="annual" name="geuntae" value="연차">
					</div>
					<div id="div-halfAnuual" class="answer">
						반차<input type="radio" id="halfAnuual" name="geuntae" value="반차">
					</div>
					<div id="div-health" class="answer">
						보건<input type="radio" id="health" name="geuntae" value="보건">
					</div>
					<div id="div-condolences" class="answer">
						경조<input type="radio" id="condolences" name="geuntae" value="경조">
					</div>
					<div id="div-outing" class="answer">
						외출<input type="radio" id="outing" name="geuntae" value="외출">
					</div>
				</div>


				<div id="one-width">
					<div id="extendWorkWriteDate" class="question">작성일</div>
					<div id="extendWorkWriteDate-answer" class="answer" name="writeTime">${time}</div>
				</div>


				<div id="one-width">
					<div id="applicationDate" class="question">신청일</div>
					<div id="applicationDate-answer" class="answer">

					</div>
				</div>

				<div id="one-width">
					<div id="extendTimeTitle" class="question">제목</div>
					<div id="extendTimeTitle-answer" class="answer">
						<input type="text" id="title-input" name="title" readonly value="${saveExtends[0].approveTitle}">
					</div>
				</div>

				<div id="one-width">
					<div id="content" class="question">신청사유</div>
					<div id="content-answer" class="answer">
						<textarea id="content-textarea" readonly name="content">${saveExtends[0].approveContent}</textarea>
					</div>
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
	function fn_fileDownload(oriName,reName){
		if(oriName==""){
			return false;
		}else{
			location.assign("${path}/approve/filedownload?oriname="+oriName+"&rename="+reName);			
		}
	};

	$(function() {  // 레디함수
		console.log("${approveNo}");
		console.log("${approveState}");
		console.log("${approveKind}");	
		
	    $("input:radio[name=geuntae]").click(function(){  // 연차, 보건, 경조는 날짜로만 선택
	    	if(this.id=="annual" || this.id=="health" || this.id=="condolences"){
	    		$("#applicationDate-answer").empty();
	    		$("#applicationDate-answer").append($('<input/>',{type:'date', name: 'startDate', id:'gStartDate'}));
	    		$("#applicationDate-answer").append($('<span/>',{id:'gBetweenTime'}));
	    		$("#gBetweenTime").text("~");
	    		$("#applicationDate-answer").append($('<input/>',{type:'date', name: 'endDate', id:'gEndDate'}));
	    	}
	    	
	    	if(this.id=="halfAnuual" || this.id=="outing"){ // 반차, 외출일경우 해당 날의 시간선택
	    		$("#applicationDate-answer").empty();
	    		$("#applicationDate-answer").append($('<input/>',{type:'date', name: 'startDate', id:'hStartDate'}));
	    		$("#applicationDate-answer").append($('<input/>',{type:'time', name: 'startTime', id:'hStartTime'}));
	    		$("#applicationDate-answer").append($('<span/>',{id:'hBetweenTime'}));
	    		$("#hBetweenTime").text("~");
	    		$("#applicationDate-answer").append($('<input/>',{type:'time', name: 'endTime', id:'hEndTime'}));
	    	}	
	   	})
	   	
	   	
	   	if("${approveKind}"=='연차'){
	   		$("#annual").trigger("click"); // 트리거로 해당 기안서의 종류에 따라서 라디오버튼을 강제로 체크
	   		$("#gStartDate").val("${sdate}").attr("readonly",true);;
	   		$("#gEndDate").val("${edate}").attr("readonly",true);;
	   	}
	   	if("${approveKind}"=='반차'){
	   		$("#halfAnuual").trigger("click"); // 트리거로 해당 기안서의 종류에 따라서 라디오버튼을 강제로 체크  
	   		$("#hStartDate").val("${sdate}").attr("readonly",true);;
	   		$("#hStartTime").val("${stime}").attr("readonly",true);;
	   		$("#hEndTime").val("${etime}").attr("readonly",true);;  		
	   	}
	   	
	   	if("${approveKind}"=='보건'){
	   		$("#health").trigger("click"); // 트리거로 해당 기안서의 종류에 따라서 라디오버튼을 강제로 체크
	   		$("#gStartDate").val("${sdate}").attr("readonly",true);;
	   		$("#gEndDate").val("${edate}").attr("readonly",true);;
	   	}
	   	
	   	if("${approveKind}"=='경조'){
	   		$("#condolences").trigger("click"); // 트리거로 해당 기안서의 종류에 따라서 라디오버튼을 강제로 체크
	   		$("#gStartDate").val("${sdate}").attr("readonly",true);;
	   		$("#gEndDate").val("${edate}").attr("readonly",true);;
	   		
	   	}
	   	if("${approveKind}"=='외출'){
	   		$("#outing").trigger("click"); // 트리거로 해당 기안서의 종류에 따라서 라디오버튼을 강제로 체크
	   		$("#halfAnuual").trigger("click"); // 트리거로 해당 기안서의 종류에 따라서 라디오버튼을 강제로 체크  
	   		$("#hStartDate").val("${sdate}").attr("readonly",true);;
	   		$("#hStartTime").val("${stime}").attr("readonly",true);;
	   		$("#hEndTime").val("${etime}").attr("readonly",true);;
	   		
	   	}
	   	
		if("${oriFileName}"==""){
			$("#fileClickId").text("파일을 선택하세요"); 
		}else{
			$("#fileClickId").text("${oriFileName}"); 
		}
	   	
	   	
	   	const approveLines=JSON.parse('${approveLines}'); // 자바스크립트에서 해당 JSON.parse 구문을통해 해당 값을 객체로 반환
		const referLines=JSON.parse('${referLines}'); 
		console.log(approveLines);
		
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

	const fullPayment=()=>{
		location.assign("${path}/approve/fullPayment.do?approveNo=${approveNo}&mId=${loginMember.memberId}&writer=${writer}&approveKind=${approveKind}");
	}	
	
	const backs=()=>{
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