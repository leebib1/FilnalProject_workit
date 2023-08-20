 <!-- 모든양식에서 공통으로 사용할 결재선 UI -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>	
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath }"/>	
<script>
const memberId = "${loginMember.memberId}"; // 본인아이디에서는 결재선과 참조선에 이름이 나오지 않기위해 전역변수로 설정
</script>

		<div class="approve-section1 section-shadow">
		<button type="button" onclick="openBtn();" id="regist-appline">결재선 설정</button>
		<!-- class="openBtn" -->
		<!-- <button type="button" id="regist-appline">결재선 설정</button> -->
		<div id="regist-app">
			<div id="appline-name">결재선</div>
		</div>

		<div id="regist-reference">
			<div id="reference-name">참조선</div>
		</div>
	</div>

</section>

  <div class="modal hidden">
  <div class="bg"></div>
  <div class="modalBox">
  	<div id="display-flex">
	    <div id="department-box">
		<c:if test="${not empty deps}">
			<c:forEach var="dep" items="${deps}">
				<button type="button" onclick="changeDep(event);" value="${dep.deptName}">${dep.deptName}</button><br>
			</c:forEach>
		</c:if>
	    </div>
	    
	    <div id="people-box">
			
	    	
	    </div>
	    
		<div id="add-remove">
			<span id="first-arrow">
			    <button type="button" style="width: 30px; height: 30px; background-color:white">
		  			<img src="${path}/resources/images/arrow/right.png" height="30px" width="30px" onclick="applyOn();" >
				</button>
			</span>
		
			<span id="second-arrow">
					<button type="button" style="width: 30px; height: 30px; background-color:white">
					    <img src="${path}/resources/images/arrow/left.png" height="30px" width="30px" onclick="applyOff();" >
					</button>
			</span>
		
			<span id="three-arrow">
				<button type="button"style="width: 30px; height: 30px; background-color:white">
				  <img src="${path}/resources/images/arrow/right.png" height="30px" width="30px" onclick="referOn();" >
				</button>
			</span>
			
			<span id="four-arrow">
				<button type="button"  style="width: 30px; height: 30px; background-color:white">
				  <img src="${path}/resources/images/arrow/left.png" height="30px" width="30px" onclick="referOff();" >
				</button>
			</span>	
		</div>
	    
	    <div id="line-refer-box">
	    		<div id="line-box">
	    			<p id="line-box-text">결재선</p>
	    		</div>
	    		
	    		<div id="refer-box">
	    			<p id="refer-box-text">참조선</p>

	    		</div>
	    </div>
	</div>

		<button type="button" id="close-button">닫기</button>
		<button type="button" onclick="registButton();" id="regist-button">등록</button> 
  </div>
</div>

<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/approve/approve.js"></script>


<!-- <script>



</script>	 -->

