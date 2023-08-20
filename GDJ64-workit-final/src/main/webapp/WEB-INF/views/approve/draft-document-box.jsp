<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />

<section class="max1920px">
	<jsp:include page="/WEB-INF/views/common/side-nav.jsp"/>

<%-- 	<c:if test="${draftDocument.approveState eq '완료'}"> --%>
	<div id="draftDocument" class="approve-section section-shadow">
		<span id="draftDocumentFont">기안문서함</span>
<!-- 		<select>
		    <option value="americano">아메리카노</option>
		    <option value="caffe latte">카페라테</option>
		    <option value="cafe au lait" selected>카페오레</option>
		    <option value="espresso">에스프레소</option>
		</select>
		<select>
		    <option value="americano">아메리카노</option>
		    <option value="caffe latte">카페라테</option>
		    <option value="cafe au lait" selected>카페오레</option>
		    <option value="espresso">에스프레소</option>
		</select> -->
		<div id="draftDocumentDiv">
			<table class="table">
            <tr id="th">
                <th>번호</th>
                <th>결재양식</th>
                <th>제목</th>
                <th>작성자</th>
                <th>작성일</th>
                <th>상태</th>
            </tr>
            
            <c:if test="${not empty draftDocuments}">
            	<c:forEach var="draftDocument" items="${draftDocuments}">
	            		<tr id="tr" onclick="location.href='${path}/approve/detailApprove.do?approveNo=${draftDocument.approveNo}&approveKind=${draftDocument.approveKind}&approveState=${draftDocument.approveState}&name=기안문서함';">
		            			<td>${draftDocument.approveNo }</td>
		            			<td>${draftDocument.approveKind }</td>
		            			<td>${draftDocument.approveTitle }</td>
		            			<td>${draftDocument.memberId.memberName}</td>
		            			<td>${draftDocument.currentDate }</td>
		            			
		            			<c:if test="${draftDocument.approveState eq '완료'}">
		            				<td><p id="cColor">${draftDocument.approveState}</p></td>
		            			</c:if>
		            			<c:if test="${draftDocument.approveState eq '반려'}">
		            				<td><p id="rColor">${draftDocument.approveState}</p></td>
		            			</c:if>
		            			<c:if test="${draftDocument.approveState eq '결재처리중'}">
		            				<td><p id="pColor">${draftDocument.approveState}</p></td>
		            			</c:if>
		            			<c:if test="${draftDocument.approveState eq '결재대기'}">
		            				<td><p id="wColor">${draftDocument.approveState}</p></td>
		            			</c:if>
	            		</tr>
	            		
            	</c:forEach>
            </c:if>
        </table>
         <div id="pageBar">	
        	<c:out value="${pageBar }" escapeXml="false"/>
        </div>
       
		</div>
	</div>

</html>	

<style>
	#pageBar{
		margin-top:20px;
	}
	#pageBar>ul>li{
		width:50px;
	}	
	
	.disabled>a{
		color:#e9e9e9;
	}
	
	#draftDocumentFont{
		font-weight: bold;
		font-size: 25px;
		margin-left:25px;
	}

	#draftDocument{
		background-color:white;
		border: 1px solid #D9D9D9;
		width:1950px;
		height:900px;
		margin-left: 50px;
	}
	
	#draftDocumentDiv{
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
	
	#cColor,#rColor,#pColor,#wColor{
		font-size: 15px;
	background-color: white;
	}
	
	#cColor{
		color :green;
	}
	#rColor{
		color :red;
	}
	#pColor{
		color :aqua;
	}
	#wColor{
		color :var(--main-color-lt);
	}
	
</style>