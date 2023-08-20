<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />

<section class="max1920px">
	<jsp:include page="/WEB-INF/views/common/side-nav.jsp"/>

	
	<div id="waitingDocument" class="approve-section section-shadow">
		<span id="waitingDocumentFont">결재대기문서함</span>
		<div id="waitingDocumentDiv">
		<table class="table">
            <tr id="th">
                <th>번호</th>
                <th>결재양식</th>
                <th>제목</th>
                <th>작성자</th>
                <th>작성일</th>
            </tr>
            <c:if test="${not empty waitingApps}">
            	<c:forEach var="waitingApp" items="${waitingApps}">
	            		<tr id="tr" onclick="location.href='${path}/approve/detailApprove.do?approveNo=${waitingApp.approveNo}&approveKind=${waitingApp.approveKind }&approveState=${waitingApp.approveState}&name=결재대기문서';">
		            			<td>${waitingApp.approveNo }</td>
		            			<td>${waitingApp.approveKind }</td>
		            			<td>${waitingApp.approveTitle}</td>
		            			<td>${waitingApp.memberId.memberName}</td>
		            			<td>${waitingApp.currentDate }</td>
	            		</tr>	
            	</c:forEach>
            </c:if>
        </table>
       
		</div>
	</div>

</html>	

<style>
	#waitingDocumentFont{
		font-weight: bold;
		font-size: 25px;
		margin-left:25px;	
	}

	#waitingDocument{
		background-color:white;
		border: 1px solid #D9D9D9;
		width:1950px;
		height:900px;
		margin-left: 50px;
	}
	
	#waitingDocumentDiv{
		border: 1px solid #D9D9D9;
		margin-top : 20px;
		margin-left : 50px;
		width:1480px;
		height:770px;
	}

	#th>th{
		font-size:20px;	
		padding-top:50px;
		padding-bottom:20px;
		border-bottom: 1px solid #ddd;
		width:400px;
	}
		
	#tr:hover{
		background-color:  #BDDFFF;
	}	
		
	#tr>td{
		font-size:15px;
		padding-top:15px;
		padding-bottom:15px;
		border-bottom: 1px solid #ddd;
		text-align: center;
		width:400px;
			white-space: nowrap;
            text-overflow: ellipsis;
            overflow: hidden;
	}
	
	#saveColor{
		background-color :#F5F5DC;
	}
</style>