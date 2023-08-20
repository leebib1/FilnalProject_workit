<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<style>
  /* 정렬, 색상 클래스 */
  .row { display: flex; flex-direction: row; }
  .column { display: flex; flex-direction: column; }
  .center { display: flex; align-items: center; justify-content: center; text-align: center; }
  .bgc-fff { background-color: #fff; }
  .bgc-F8FCFF { background-color: #F8FCFF; }
  .margin10px label, .margin10px input, .margin10px textarea,.margin10px button{margin: 10px;}

  /* 근태관리 nav */
  .head-nav { height: 56px; display: flex; align-items: center; }
  .head-nav ul li { margin: 0px 5px; }
  /* pagebar */
  	.pageBar li{width: 32px;height: 32px;text-align: center;}
  	.pageBar li:hover{color: #fff; font-weight: bolder; background-color:var(--main-color-dk); }

	#lectureListDiv{padding: 20px;}
  .tableStyle { width: 95%; margin: 0px 20px; padding: 10px; border-collapse: collapse; margin: 20px 0;}
  .tableStyle td, .tableStyle th { border-bottom: 1px solid #e0e0e0;padding: 8px; text-align: center; }
  .tableStyle tr{height: 60px;}
  .hoverStyle:hover{font-weight: bolder;}
	button{cursor: pointer;}
</style>
<section class="max1920px">
	<jsp:include page="/WEB-INF/views/common/side-nav.jsp" />
	<div class="main-section bgc-F8FCFF">		
	    <div class="section-shadow bgc-fff head-nav">
	      <ul class="row" style="margin-left: 30px">
	        <li>강의 관리</li>
	        <li>|</li>
	        <li>강의 목록</li>
	      </ul>
	    </div>
	    <div class="column section-shadow bgc-fff" id="lectureListDiv">
	    	<div class="row" style="justify-content: space-between;">
	    		<div>
	    			<button id="insertLectureBtn">등록</button>
	    		</div>
	    		<div>
	    			<div id="searchDiv">
	                    <select id="searchType">
	                        <option value="lectureName" ${searchType == 'lectureName' ? 'selected' : ''}>강의명</option>
	                        <option value="memberName" ${searchType == 'memberName' ? 'selected' : ''}>강사명</option>
	                    </select>
	                    <input type="text" id="searchKeyword" placeholder="search..." style="height: 20px;" value="${searchKeyword}"/>
	                    <button id="searchBtn">검색</button>
	                </div>
	    		</div>
	    	</div>
	    	<div>
	    		<table class="tableStyle" id="lectureTable">
	    			<thead>
	    				<tr>
	    					<th>번호</th>
	    					<th>상태</th>
	    					<th>과정명</th>
	    					<th>강사명</th>
	    					<th>과정기간</th>
	    					<th>신청일</th>
	    				</tr>
	    			</thead>
		    		<tbody>
			            <c:forEach items="${lectureList}" var="lecture">
			                <tr>
			                    <td>${lecture.lectureNo}</td>
			                    <td>${lecture.registrationStatus}</td>
			                    <td class="hoverStyle"><a href="${path}/lecture/detail?no=${lecture.lectureNo}">${lecture.lectureName}</a></td>
			                    <td>${lecture.member.memberName}</td>
			                    <td>
			                        <fmt:formatDate value="${lecture.startDate}" pattern="yyyy-MM-dd"/>/
			                        <fmt:formatDate value="${lecture.endDate}" pattern="yyyy-MM-dd"/>
			                    </td>
			                    <td><fmt:formatDate value="${lecture.registrationDate}" pattern="yyyy-MM-dd"/></td>
			                </tr>
			            </c:forEach>
			        </tbody>
	    		</table>
	    	</div>		
			<div id="pageBarDiv" class="pageBar">
	             ${pageBar }
	         </div>
		</div>
	</div>
</section>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    $(document).ready(function() {
        // 검색 버튼에 클릭 이벤트
        $('#searchBtn').click(function() {
            searchLectures();
        });

    });
     // 등록 버튼에 클릭 이벤트
        $(document).on('click', '#insertLectureBtn', function() {
            location.assign('${path}/lecture/insertLecture');
        });

    function searchLectures() {
        var searchType = $('#searchType').val();
        var searchKeyword = $('#searchKeyword').val().trim();

        if (searchKeyword === "") {
            alert('검색어를 입력하세요.');
            return;
        }

        $.get('${path}/lecture/lectureList',
        		{ searchType: searchType, searchKeyword: searchKeyword },
        		function(response) {
        			
        			$('#lectureListDiv').html($(response).find('#lectureListDiv').html());
        });
    }
</script>


</body>
</html>