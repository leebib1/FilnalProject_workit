<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
  <section>
	<div class="reject hidden-reject">
	  <div class="bg-reject"></div>
	  <div class="modalBox-reject">
			<div id="rejectTitle">반려 메시지를 입력해주세요</div>
	  		<div id="rejectContent">
	  			<input type="text" id="rejectContentInput">
	  		</div>
			<button type="button" id="reject-write-button">반려</button>
			<button type="button" id="reject-close-button">취소</button>
			
	  </div>
	</div>
</section>  
<link rel="stylesheet" href="${path}/resources/css/approve/reject.css">
<%-- <script src="${path}/resources/js/approve/select-payment-form.js"></script> --%>


  