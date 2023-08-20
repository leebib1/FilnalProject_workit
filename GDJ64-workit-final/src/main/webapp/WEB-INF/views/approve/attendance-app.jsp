<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<c:set var="approveNo" value="${approveNo}"/>
<c:set var="approveState" value="${approveState}"/>
<c:set var="approveKind" value="${approveKind}"/>
<c:set var="fileName" value="${fileName}"/>
<c:set var="stime" value="${stime}"/>
<c:set var="etime" value="${etime}"/>
<c:set var="sdate" value="${sdate}"/>
<c:set var="edate" value="${edate}"/>


<jsp:include page="/WEB-INF/views/common/header.jsp" />


<link rel="stylesheet"
	href="${path}/resources/css/approve/drafting_app.css">
<section class="max1920px">
	<jsp:include page="/WEB-INF/views/common/side-nav.jsp" />

	<form action="#" id="appForm" method="post"
		enctype="multipart/form-data">

		<div class="approve-section section-shadow">
		<c:choose>
			<c:when test="${approveState eq '임시저장' }">
				<div id="approve_name">임시저장문서</div>
			</c:when>
			<c:otherwise>
				<div id="approve_name">기안서신청</div>
			</c:otherwise>
		</c:choose>
				<div id="one-width">
					<div id="kind">근태신청서</div>
					<div id="app-line" class="answer"></div>
				</div>

				<div id="one-width">
					<div id="department" class="question">부서</div>
					<div id="department-answer" class="answer">${loginMember.dept.deptName}</div>
					<div id="writer" class="question">기안자</div>
					<div id="writer-answer" class="answer">${loginMember.memberName}</div>
					<div id="position" class="question">직책</div>
					<div id="position-answer" class="answer">${loginMember.job.jobName}</div>
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
						<input type="text" id="title-input" name="title" value="${saveExtends[0].approveTitle}">
					</div>
				</div>

				<div id="one-width">
					<div id="content" class="question">신청사유</div>
					<div id="content-answer" class="answer">
						<textarea id="content-textarea" name="content">${saveExtends[0].approveContent}</textarea>
					</div>
				</div>

				<div id="one-width">
					<div id="appAttachment" class="question">첨부파일</div>
					<div id="appAttachment-answer" class="answer">
						<input type="file" id="appAttachment-input" name="upFile" style="display:none;">
						<button type="button" id="fileClickId" onclick="fileClick();">파일을 선택하세요</button>
					</div>
				</div>

			<c:choose>
				<c:when test="${saveExtends[0].approveState eq '임시저장'}">
					<div id="one-width">
						<button type="button" onclick="remove();" id="remove">삭제하기</button>
						<button type="button" onclick="reSaves();" id="save">임시저장</button>
						<button type="button" onclick="signs();" id="sign">결재상신</button>
`					</div>
				</c:when>
				<c:otherwise>
					<div id="one-width">
						<button type="button" onclick="backs();" id="back">돌아가기</button>
						<button type="button" onclick="saves();" id="save">임시저장</button>
						<button type="button" onclick="signs();" id="sign">결재상신</button>
					</div>
				</c:otherwise>
			</c:choose>

			</div>
		</div>

<jsp:include page="/WEB-INF/views/approve/approval-ref.jsp" />
</form> 
</html>

<script>


	$(function() {  // 레디함수
		
				
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
	   		$("#gStartDate").val("${sdate}");
	   		$("#gEndDate").val("${edate}");
	   	}
	   	if("${approveKind}"=='반차'){
	   		$("#halfAnuual").trigger("click"); // 트리거로 해당 기안서의 종류에 따라서 라디오버튼을 강제로 체크  
	   		$("#hStartDate").val("${sdate}");
	   		$("#hStartTime").val("${stime}");
	   		$("#hEndTime").val("${etime}");  		
	   	}
	   	
	   	if("${approveKind}"=='보건'){
	   		$("#health").trigger("click"); // 트리거로 해당 기안서의 종류에 따라서 라디오버튼을 강제로 체크
	   		$("#gStartDate").val("${sdate}");
	   		$("#gEndDate").val("${edate}");
	   	}
	   	
	   	if("${approveKind}"=='경조'){
	   		$("#condolences").trigger("click"); // 트리거로 해당 기안서의 종류에 따라서 라디오버튼을 강제로 체크
	   		$("#gStartDate").val("${sdate}");
	   		$("#gEndDate").val("${edate}");
	   		
	   	}
	   	if("${approveKind}"=='외출'){
	   		$("#outing").trigger("click"); // 트리거로 해당 기안서의 종류에 따라서 라디오버튼을 강제로 체크
	   		$("#halfAnuual").trigger("click"); // 트리거로 해당 기안서의 종류에 따라서 라디오버튼을 강제로 체크  
	   		$("#hStartDate").val("${sdate}");
	   		$("#hStartTime").val("${stime}");
	   		$("#hEndTime").val("${etime}");
	   		
	   	}
	   	
		if("${fileName}"==""){
			$("#fileClickId").text("파일을 선택하세요"); 
		}else{
			$("#fileClickId").text("${fileName}"); 
		}
		
		
		/* 오늘 날짜 기준으로 이전에는 선택못하도록 구현 */
/* 		var today = new Date();
		today.setHours(today.getHours()+9);
		today = today.toISOString().split('T')[0];
		$("#gStartDate").attr('min',today);
		
		$("#gStartDate").change(function(){
			var startDate = $("#gStartDate").val();
			$("#gStartDate").attr("min",startDate);
		}); */
		
		
/* 		$("#gStartDate	").change(function(){
			console.log("Ee");
			if(document.getElementById("hEndTime").value != ""){
				if($("#hStartTime").val() >= $("#hEndTime").val()){
					alert("시작시간보다 더 크게 설정");
					$("#hEndTime").val("");
				}
			}
		});
		
		$("#hEndTime").change(function(){
			console.log("Ee");
				if($("#hStartTime").val() >= $("#hEndTime").val()){
					alert("시작시간보다 더 크게 설정");
					$("#hEndTime").val("");
				}				
		}); */		
	   	
	   	const approveLines='${approveLines}'==""?'':JSON.parse('${approveLines}'); // 자바스크립트에서 해당 JSON.parse 구문을통해 해당 값을 객체로 반환
		const referLines='${referLines}'==""?'':JSON.parse('${referLines}'); 
				
		for(let i=0; i<approveLines.length; i++){
			const span = $("<span>");
			span.attr("class", "appClass");
			$("#regist-app").append(span);
			span.append($('<img/>',{src:path+'/resources/images/approve/circle_people.png',width:'20px',height:'20px'}));
			span.append(approveLines[i].memberId.memberId + " " + approveLines[i].memberId.memberName + " " + approveLines[i].memberId.job.jobName + " " + approveLines[i].memberId.dept.deptName, '<br>');
			span.append($("<input/>", { type: 'hidden', name: 'paraApp', value: approveLines[i].memberId.memberId }));
			const di = $("<div>").css("border", "1px solid black").height("98px").width("120px");
			$("#app-line").append(di);
			di.append($("<div>").css("border-bottom", "1px solid black").height("30px").width("120px").text(approveLines[i].memberId.memberName + " " + approveLines[i].memberId.job.jobName).css("text-align","center"));
			di.append($("<div>").height("40px").width("120px"));
			di.append($("<div>").css("border-top", "1px solid black").height("28px").width("120px").text(i+1).css("text-align","center"));
		}
		
		for(let i=0; i<referLines.length; i++){
			const span = $("<span>");
			span.attr("class", "appId");
			$("#regist-reference").append(span);
			span.append($('<img/>',{src:path+'/resources/images/approve/circle_people.png',width:'20px',height:'20px'}));
			span.append(referLines[i].memberId.memberId + " " + referLines[i].memberId.memberName + " " + referLines[i].memberId.job.jobName + " " + referLines[i].memberId.dept.deptName, '<br>');
			span.append($("<input/>", { type: 'hidden', name: 'paraRefer', value: referLines[i].memberId.memberId })); // 파라미터로넘길 참조선값들		
		} 	
				
	});

	
	

	
	const remove=()=>{  // 임시저장된 기안서 삭제할때
		location.assign("${path}/approve/removeSave.do?deleteApproveNo=${approveNo}&mId=${loginMember.memberId}"); 
	}
	
	const reSaves=()=>{ // 임시저장된 기안서 다시 임시저장할 때
		const kind = $("input:radio[name='geuntae']:checked").val();
				
 		if($("input[name='startDate']").length == 0){
			alert("시간을선택해주세요");
			return false;
		} 
		
		if(kind == "반차" || kind == "외출"){
			if(document.getElementById("hStartDate").value == "" || document.getElementById("hStartTime").value == "" ||
					document.getElementById("hEndTime").value == ""){
				
/* 				if(document.getElementById("hStartDate").value == "" && document.getElementById("hStartTime").value == "" 
					&& document.getElementById("hEndTime").value == ""){
				}else{
					alert("시간입력");
					return false;				
				}	 */	
				alert("시간입력");
				return false;	
			}
		}else{  // 연차, 보건, 경조 경우
			if(document.getElementById("gStartDate").value == "" || document.getElementById("gEndDate").value == ""){
								
				alert("시간입력");
				return false;	
			}
		}
	
 		$("#appForm").attr("action","${path}/approve/reSaves.do?deleteApproveNo=${approveNo}&approveKind="+kind); 
		$("#appForm").submit(); 
	}
	
	const fileClick=()=>{
		$("#appAttachment-input").click();
	}
	
	$("#appAttachment-input").change(function(e){
	     $("#fileClickId").text($('input[type=file]')[0].files[0].name); 
	});
	
	const backs=()=>{
		location.assign("${path}/");
	}
	
	const saves=()=>{
		const kind = $("input:radio[name='geuntae']:checked").val();
		
 		if($("input[name='startDate']").length == 0){
			alert("시간을선택해주세요");
			return false;
		} 
		
		if(kind == "반차" || kind == "외출"){
			if(document.getElementById("hStartDate").value == "" || document.getElementById("hStartTime").value == "" ||
					document.getElementById("hEndTime").value == ""){
				
/* 				if(document.getElementById("hStartDate").value == "" && document.getElementById("hStartTime").value == "" 
					&& document.getElementById("hEndTime").value == ""){
				}else{
					alert("시간입력");
					return false;				
				}	 */	
				alert("시간입력");
				return false;	
			}
		}else{  // 연차, 보건, 경조 경우
			if(document.getElementById("gStartDate").value == "" || document.getElementById("gEndDate").value == ""){
/* 				if(document.getElementById("gStartDate").value == "" && document.getElementById("gEndDate").value == ""){
				}else{
					alert("시간입력");
					return false;				
				}	 */	
				alert("시간입력");
				return false;	
			}
		}
		
 		$("#appForm").attr("action","${path}/approve/saveAttendance.do"); 
		$("#appForm").submit(); 		
	}
	
	const signs=()=>{

		if($(".appClass").length < 1){
			alert("결재선에 최소 한명이상 선택하세요");
			return false;
		}
		
		if($(".appId").length < 1){
			alert("참조선에 최소 한명이상 선택하세요");
			return false;
		}
				
		if( $("input:radio[name='geuntae']:checked").length == 0){
			alert("종류를 선택하세요");
			return false;
		}
				
				
		if(document.getElementById("title-input").value == "" || document.getElementById("content-textarea").value == ""){
			alert("제목 내용 입력");
			return false;
		}
		
		const kind = $("input:radio[name='geuntae']:checked").val();
		
		if(kind == "반차" || kind == "외출"){
			if(document.getElementById("hStartDate").value == "" || document.getElementById("hStartTime").value == "" ||
					document.getElementById("hEndTime").value == ""){
				alert("시간입력");
				return false;
			}
		}else{  // 연차, 보건, 경조 경우
			if(document.getElementById("gStartDate").value == "" || document.getElementById("gEndDate").value == ""){
				alert("시간입력");
				return false;
			}
		}

		if("${approveState}" == "임시저장"){
 			$("#appForm").attr("action","${path}/approve/reSaves.do?deleteApproveNo=${approveNo}&approveState=${approveState}&approveKind="+kind); 
			$("#appForm").submit();		
		}else{

			$("#appForm").attr("action","${path}/approve/insertDraft.do"); 
			$("#appForm").submit();	
		}
		
	}
	
</script>