<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>                            
<c:set var="path" value="${pageContext.request.contextPath }"/>     
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<link rel="stylesheet" href="${path}/resources/css/chat/chat.css">
<section class="max100per">
	<jsp:include page="/WEB-INF/views/common/side-nav.jsp"/>
		<div class="main-section section-shadow">
			<jsp:include page="/WEB-INF/views/chat/chatList.jsp"/>
			<jsp:include page="/WEB-INF/views/chat/chating.jsp"/>
		</div>
</section>
<script src="${path}/resources/js/chat/chat.js"></script>
</body>
</html>
