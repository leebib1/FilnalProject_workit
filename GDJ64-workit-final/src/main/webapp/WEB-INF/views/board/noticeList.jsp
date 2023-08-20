<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />

<style>
  /* 기본 스타일링 */
  .row { display: flex; flex-direction: row; }
  .column { display: flex; flex-direction: column; }
  .center { display: flex; align-items: center; justify-content: center; text-align: center; }

  /* 색상 설정 */
  .bgc-fff { background-color: #fff; }
  .bgc-F8FCFF { background-color: #F8FCFF; }

  /* 게시판 헤더 */
  .head-nav { height: 56px; display: flex; align-items: center; padding-left: 30px; }
  .head-nav ul li { margin: 0px 5px; }
  
  /* 버튼 컨테이너 */
  .btnContainer{display: flex; align-items: center;justify-content: space-between;}
  #writeNoticeDiv{margin-left: 20px;}

  /* 검색 박스 */
  #searchDiv { padding: 15px; display: flex; align-items: center; width: 30%;}
   #searchKeyword, select, #searchBtn { height: 36px;}
  #searchKeyword {  flex: 2; margin-left: 10px;width: 60%; }
  select { width: 20%; }
  #searchBtn {margin-left: 10px;}
  
  /* 테이블 */
  table { width: 90%; margin: 20px auto; border-collapse: collapse; }
  th, td { padding: 15px; border-bottom: 1px solid #e0e0e0; text-align: left; }
  th:nth-child(1), th:nth-child(3), th:nth-child(4), 
  td:nth-child(1), td:nth-child(3), td:nth-child(4) { width: 10%; }
  th:nth-child(2), td:nth-child(2) { width: 70%; }
  td:nth-child(2):hover {color: #595959; font-weight:bolder; text-decoration: underline;cursor: pointer;}
</style>

<section class="max1920px">
    <jsp:include page="/WEB-INF/views/common/side-nav.jsp" />
    <div class="main-section bgc-F8FCFF">        
        <div class="section-shadow bgc-fff head-nav">
            <ul class="row">
                <li>게시판</li>
                <li>|</li>
                <li>공지사항</li>
            </ul>
        </div>
        <div class="section-shadow bgc-fff">
            <div class="column">
		        <div class="btnContainer">
		        <!-- 글쓰기버튼 -->
		            <div id="writeNoticeDiv">
		            	<button id="writeBtn">글쓰기</button>
		            </div>
	            <!-- 검색창 -->
	                <div id="searchDiv">
					    <select id="searchType">
					        <option value="title" ${searchType == 'title' ? 'selected' : ''}>제목</option>
					        <option value="writer" ${searchType == 'writer' ? 'selected' : ''}>작성자</option>
					        <option value="content" ${searchType == 'content' ? 'selected' : ''}>내용</option>
					    </select>
					    <input type="text" id="searchKeyword" value="${searchKeyword}" placeholder="search..." style="height: 20px;" />
					    <button id="searchBtn">검색</button>
					</div>
		        </div>
                <!-- 공지사항 테이블 -->
                <div id="noticeTblDiv" class="center">
                    <table>
                        <thead>
                            <tr>
                                <th>번호</th>
                                <th>제목</th>
                                <th>작성자</th>
                                <th>작성일</th>
                            </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${noticeList }" var="n">
                            <tr>
                                <td class="noticeNo">${n.noticeNo }</td>
                                <td class="noticeTitle">
									${n.noticeTitle } (${n.commentCount })
                                </td>
                                <td>${n.member.memberName }</td>
                                <td>${n.noticeDate }</td>
                            </tr>
                         </c:forEach>
                        </tbody>
                    </table>
                </div>
                <!-- 페이징처리 공간 -->
                <div id="pageBarDiv">
                    ${pageBar }
                </div>
            </div>
        </div>
    </div>
</section>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    $(document).ready(function() {
        // 공지사항 제목 클릭 이벤트
    	 $(".noticeTitle").click(function() {
    		 let noticeNo = $(this).closest('tr').find('.noticeNo').text().trim();
             location.assign('${path}/board/noticeView?no='+noticeNo);
         });
    	// 글쓰기 버튼 클릭 이벤트
    	 $("#writeBtn").click(function() {
             location.assign('${path}/board/insertNotice');
         });
    });
    
    //검색 버튼 클릭 이벤트
    $("#searchBtn").click(function() {
        const type = $("#searchType").val();
        const keyword = $("#searchKeyword").val();
		console.log(type);
		console.log(keyword);
        location.assign('${path}/board/noticeList?type='+type+'&keyword='+keyword);
    });

</script>

</body>
</html>
