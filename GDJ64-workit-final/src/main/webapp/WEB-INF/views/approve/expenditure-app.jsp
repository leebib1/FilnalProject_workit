<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<c:set var="approveNo" value="${approveNo}"/>
<c:set var="approveState" value="${approveState}"/>
<c:set var="approveKind" value="${approveKind}"/>
<c:set var="fileName" value="${fileName}"/>

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
					<div id="kind">지출결의서</div>
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
					<input type="text" id="account0" name="account" class="answer">
					<input type="text" id="use-history0" name="useHistory" class="answer"> 
					<input type="text" id="price0" name="price" class="answer">
				</div>
				<div id="one-width">
					<input type="text" id="account1" name="account" class="answer">
					<input type="text" id="use-history1" name="useHistory" class="answer"> 
					<input type="text" id="price1" name="price" class="answer">
				</div>
				<div id="one-width">
					<input type="text" id="account2" name="account" class="answer">
					<input type="text" id="use-history2" name="useHistory"
						class="answer"> <input type="text" id="price2"
						name="price" class="answer">
				</div>
				<div id="one-width">
					<input type="text" id="account3" name="account" class="answer">
					<input type="text" id="use-history3" name="useHistory"
						class="answer"> <input type="text" id="price3"
						name="price" class="answer">
				</div>
				<div id="one-width">
					<input type="text" id="account4" name="account" class="answer">
					<input type="text" id="use-history4" name="useHistory"
						class="answer"> <input type="text" id="price4"
						name="price" class="answer">
				</div>
				<div id="one-width">
					<input type="text" id="account5" name="account" class="answer">
					<input type="text" id="use-history5" name="useHistory"
						class="answer"> <input type="text" id="price5"
						name="price" class="answer">
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
							<button type="button" onclick="reSaveExpenditure();" id="save">임시저장</button>
							<button type="button" onclick="signs();" id="sign">결재상신</button>
							`
						</div>
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
	$(function() {	
	
		const approveLines='${approveLines}'==""?'':JSON.parse('${approveLines}'); // 자바스크립트에서 해당 JSON.parse 구문을통해 해당 값을 객체로 반환
		const referLines='${referLines}'==""?'':JSON.parse('${referLines}'); 
		const expenditures='${expenditures}'==""?'':JSON.parse('${expenditures}'); 
		
		
		console.log(expenditures);
		
		for(let i=0; i<expenditures.length; i++){
			$("#account"+i).val(expenditures[i].account);
			$("#use-history"+i).val(expenditures[i].useHistory);
			$("#price"+i).val(expenditures[i].price);
		}

		if("${fileName}"==""){
			$("#fileClickId").text("파일을 선택하세요"); 
		}else{
			$("#fileClickId").text("${fileName}"); 
		}
		
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
	
	
	const backs = () => {
	    location.assign("${path}/");
	}

	
	const remove=()=>{  // 임시저장된 기안서 삭제할때
		location.assign("${path}/approve/removeSave.do?deleteApproveNo=${approveNo}&mId=${loginMember.memberId}"); 
	}
	
	const reSaveExpenditure=()=> { // 임시저장된 기안서 다시 임시저장할 때
	    $("#appForm").attr("action", "${path}/approve/reSaveExpenditure.do?deleteApproveNo=${approveNo}");
	    $("#appForm").submit();
	}

	const fileClick=()=>{
		$("#appAttachment-input").click();
	}
	
	$("#appAttachment-input").change(function(e){
	     $("#fileClickId").text($('input[type=file]')[0].files[0].name); 
	});
	
	const saves = () => {
	    // 아래의 3개의 배열들역할 -> 각 칸들의 값들의 index 값을 넣어서, 해당 칸들의 개수가 일치해야 하는 조건을 추가할 수 있고
	    // 칸들의 개수는 일치하지만, 각 칸들의 위치가 다를 수 있으므로, 배열의 인덱스번호를 추가함
	    let arrayAccount = [];
	    let arrayUseHistory = [];
	    let arrayPrice = [];
	    $("input[name='account']").each(function(i) { // i로 인덱스번호 체크
	        if (this.value != "") arrayAccount.push(i);
	    })
	    $("input[name='useHistory']").each(function(i) {
	        if (this.value != "") arrayUseHistory.push(i);
	    })
	    $("input[name='price']").each(function(i) {
	        if (this.value != "") arrayPrice.push(i);
	    })

	    // equals1, equals2 -> 배열은 == 비교가 불가능함(주소이기때문에) -> JSON.stringify를 통해서 비교 -> 3개의 배열을 비교
	    const equals1 = (arrayAccount, arrayUseHistory) => JSON.stringify(arrayAccount) == JSON.stringify(arrayUseHistory)
	    const equals2 = (arrayUseHistory, arrayPrice) => JSON.stringify(arrayUseHistory) == JSON.stringify(arrayPrice);
	    const result = equals1(arrayAccount, arrayUseHistory) && equals2(arrayUseHistory, arrayPrice);

	    if (arrayAccount.length <= 0 || arrayUseHistory.length <= 0 || arrayPrice.length <= 0) {
	        alert("각 목록마다 한칸이상씩 입력");
	        return false;
	    } else {
	        if (result == false) {
	            alert("각 줄의 목록을 다 입력");
	            return false;
	        }
	    }

	    $("#appForm").attr("action", "${path}/approve/saveExpenditure.do");
	    $("#appForm").submit();
	}

	const signs = () => {

	    if ($(".appClass").length < 1) {
	        alert("결재선에 최소 한명이상 선택하세요");
	        return false;
	    }

	    if ($(".appId").length < 1) {
	        alert("참조선에 최소 한명이상 선택하세요");
	        return false;
	    }


	    // 아래의 3개의 배열들역할 -> 각 칸들의 값들의 index 값을 넣어서, 해당 칸들의 개수가 일치해야 하는 조건을 추가할 수 있고
	    // 칸들의 개수는 일치하지만, 각 칸들의 위치가 다를 수 있으므로, 배열의 인덱스번호를 추가함
	    let arrayAccount = [];
	    let arrayUseHistory = [];
	    let arrayPrice = [];
	    $("input[name='account']").each(function(i) { // i로 인덱스번호 체크
	        if (this.value != "") arrayAccount.push(i);
	    })
	    $("input[name='useHistory']").each(function(i) {
	        if (this.value != "") arrayUseHistory.push(i);
	    })
	    $("input[name='price']").each(function(i) {
	        if (this.value != "") arrayPrice.push(i);
	    })

	    // equals1, equals2 -> 배열은 == 비교가 불가능함(주소이기때문에) -> JSON.stringify를 통해서 비교 -> 3개의 배열을 비교
	    const equals1 = (arrayAccount, arrayUseHistory) => JSON.stringify(arrayAccount) == JSON.stringify(arrayUseHistory)
	    const equals2 = (arrayUseHistory, arrayPrice) => JSON.stringify(arrayUseHistory) == JSON.stringify(arrayPrice);
	    const result = equals1(arrayAccount, arrayUseHistory) && equals2(arrayUseHistory, arrayPrice);

	    if (arrayAccount.length <= 0 || arrayUseHistory.length <= 0 || arrayPrice.length <= 0) {
	        alert("각 목록마다 한칸이상씩 입력");
	        return false;
	    } else {
	        if (result == false) {
	            alert("각 줄의 목록을 다 입력");
	            return false;
	        }
	    }

		if("${approveState}" == "임시저장"){
	 		$("#appForm").attr("action","${path}/approve/reSaveExpenditure.do?deleteApproveNo=${approveNo}&approveState=${approveState}"); 
			$("#appForm").submit();			
		}else{
	 		$("#appForm").attr("action","${path}/approve/insertDraft.do"); 
			$("#appForm").submit(); 			
		}
	    
	}
	
</script>