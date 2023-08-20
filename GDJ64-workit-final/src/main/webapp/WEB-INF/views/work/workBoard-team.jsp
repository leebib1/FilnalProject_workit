<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.Calendar" %>
<c:set var="path" value="${pageContext.request.contextPath }" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<%!
public int getLastDay(int year, int month) {
  Calendar cal = Calendar.getInstance();
  cal.set(year, month - 1, 1);
  return cal.getActualMaximum(Calendar.DAY_OF_MONTH);
}
%>

<% 
int year = Calendar.getInstance().get(Calendar.YEAR); // 현재 년도
int month = Calendar.getInstance().get(Calendar.MONTH) + 1; // 현재 월
int lastDay = getLastDay(year, month); // 해당 월의 마지막 날짜
%>
<style>
  /* 정렬, 색상 클래스 */
  .row { display: flex; flex-direction: row; }
  .column { display: flex; flex-direction: column; }
  .center { display: flex; align-items: center; justify-content: center; text-align: center; }
  .bgc-fff { background-color: #fff; }
  .bgc-F8FCFF { background-color: #F8FCFF; }
  .margin10px label, .margin10px input, .margin10px textarea,.margin10px button{margin: 10px;}

  /* 출근부 nav */
  .head-nav { height: 56px; display: flex; align-items: center; }
  .head-nav ul li { margin: 0px 5px; }

  /* 근태조회 div */
  /* 조회 월 선택 */
  .year-month { font-size: 24px; font-weight: bolder; text-align: center; color: black; }
  .sec_cal { width: 100%; margin: 0 auto; font-family: "NotoSansR"; }
  .sec_cal .cal_nav { display: flex; justify-content: center; align-items: center; font-weight: 700; font-size: 48px; line-height: 72px; }
  .sec_cal .cal_nav .year-month { width: 300px; text-align: center; line-height: 1; }
  .sec_cal .cal_nav .nav { display: flex; border: 1px solid #333333; border-radius: 5px; }
  .sec_cal .cal_nav .go-prev, .sec_cal .cal_nav .go-next { display: block; width: 50px; height: 78px; font-size: 0; display: flex; justify-content: center; align-items: center; }
  .sec_cal .cal_nav .go-prev::before, .sec_cal .cal_nav .go-next::before { content: ""; display: block; width: 20px; height: 20px; border: 3px solid #000; border-width: 3px 3px 0 0; transition: border 0.1s; }
  .sec_cal .cal_nav .go-prev:hover::before, .sec_cal .cal_nav .go-next:hover::before { border-color: var(--main-color-dk); }
  .sec_cal .cal_nav .go-prev::before { transform: rotate(-135deg); }
  .sec_cal .cal_nav .go-next::before { transform: rotate(45deg); }
  .cal_tblDiv { display: flex; flex-direction: column; align-items: flex-start; }
  .go-up>a::before, .go-down>a::before { content: ""; display: block; width: 10px; height: 10px; border: 2px solid #000; border-width: 3px 3px 0 0; transition: border 0.1s; margin-top: 5px;}
  .weekDiv { font-size: 24px; font-weight: bolder; width: 80px; justify-content: space-between; }
  .go-up>a:hover::before, .go-down>a:hover::before { border-color: var(--main-color-dk); }
  .go-down>a::before { transform: rotate(135deg); }
  .go-up>a::before { transform: rotate(-45deg);}
  .cal_tbl { width: 95%; margin: 0px 20px; padding: 10px; border-collapse: collapse; }
  .cal_tbl td, .cal_tbl th {border-bottom: 1px solid #e0e0e0; padding: 8px; text-align: center; }
  .highlight-color>p,  .highlight-color>a {color: var(--main-color-dk);}
</style>

<section class="max1920px">
  <jsp:include page="/WEB-INF/views/common/side-nav.jsp" />

  <div class="main-section bgc-F8FCFF">
    <div class="section-shadow bgc-fff head-nav">
      <ul class="row" style="margin-left: 30px">
        <li>근태관리</li>
        <li>|</li>
        <li>${loginMember.dept.deptName} 출근부</li>
      </ul>
    </div>
    <div class="section-shadow bgc-fff">
      <div class="sec_cal">
	      <div style="margin: 20px;">
		    <input type="text" id="searchEmployeeName" placeholder="사원명 검색" style="height: 20px; margin: 20px 5px;"/>
		    <button id="searchBtn">검색</button>
		  </div>
        <div class="cal_nav">
          <a href="#" class="go-prev">prev</a>
          <div class="year-month"></div>
          <a href="#" class="go-next">next</a>
        </div>
        <div class="cal_tblDiv">
         <table class="cal_tbl">
         	<thead>
         		<tr>
         			<th>일자</th>
         			<th>사원명</th>
         			<th>직급</th>
         			<th>근무상태</th>
         			<th>출근시간</th>
         			<th>퇴근시간</th>
         			<th>근무시간</th>
         			<th>초과시간</th>
         		</tr>
         	</thead>
         	<tbody>
         	<c:if test="${empty workList }">
         	<tr>
         		<td colspan="8">조회된 근무정보가 없습니다.</td>
         	</tr>
         	</c:if>
			<c:if test="${not empty workList }">
				<c:forEach var="workItem" items="${workList }">
					 <tr class="work-time-row">
		                <td class="dateCell"> <fmt:formatDate value="${workItem.workDate}" pattern="d E" /></td>
		                <td>${workItem.member.memberName}</td>
		                <td>${workItem.member.job.jobName}</td>
		                <td>${workItem.workStatus}</td>
		                <td><fmt:formatDate value="${workItem.workStart}" pattern="HH:mm:ss" /></td>
		                <td><fmt:formatDate value="${workItem.workEnd}" pattern="HH:mm:ss" /></td>
		                <td>${workItem.totalWorkTime}</td>
		                <td>${workItem.overtime}</td>
          			  </tr>
				</c:forEach>
			</c:if>
         	</tbody>
         </table>
        </div>
      </div>
    </div>
  </div>
</section>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	$('.dateCell').each(function() {
        let text = $(this).text();
        text = text.replace("Mon", "월");
        text = text.replace("Tue", "화");
        text = text.replace("Wed", "수");
        text = text.replace("Thu", "목");
        text = text.replace("Fri", "금");
        text = text.replace("Sat", "토");
        text = text.replace("Sun", "일");
        $(this).text(text);
    });
    // 현재의 년도와 월
    var currentYear = new Date().getFullYear();
    var currentMonth = new Date().getMonth() + 1;
    $(".year-month").text(currentYear + "년 " + currentMonth + "월");

    $(".go-prev").on("click", function(e) {
        e.preventDefault();
        navigateMonth(-1);
    });

    $(".go-next").on("click", function(e) {
        e.preventDefault();
        navigateMonth(1);
    });

    $("#searchBtn").on("click", function() {
        var searchName = $("#searchEmployeeName").val();
        if(searchName.trim() === "") {
            alert("사원명을 입력해주세요.");
            return;
        }
        navigateMonth(0, searchName);
    });
 	

});

function navigateMonth(offset, searchName) {
    var dateParts = $(".year-month").text().split('년 ');
    var year = parseInt(dateParts[0].trim());
    var month = parseInt(dateParts[1].replace('월', '').trim());
    month += offset;
    if (month === 0) {
        month = 12;
        year--;
    } else if (month === 13) {
        month = 1;
        year++;
    }
    $(".year-month").text(year + "년 " + month + "월");

    $.get("${path}/work/workTimeByTeam", {
        currentYear: year,
        currentMonth: month,
        memberName: searchName
    }, function (data) {
        $(".cal_tbl tbody").empty();
        if (!data || data.length == 0) {
            $(".cal_tbl tbody").append('<tr><td colspan="8">조회된 근무정보가 없습니다.</td></tr>');
        } else {
            $.each(data, function (index, workItem) {
            	console.log(data);
                var rowHtml = '<tr class="work-time-row">';
                rowHtml += '<td>' + formatDateAndDay(workItem.workDate) + '</td>';
                rowHtml += '<td>' + workItem.member.memberName + '</td>';
                rowHtml += '<td>' + workItem.member.job.jobName + '</td>';
                rowHtml += '<td>' + workItem.workStatus + '</td>';
                rowHtml += '<td>' + formatTime(workItem.workStart) + '</td>';
                rowHtml += '<td>' + formatTime(workItem.workEnd) + '</td>';
                rowHtml += '<td>' + workItem.totalWorkTime + '</td>';
                rowHtml += '<td>' + workItem.overtime + '</td>';
                rowHtml += '</tr>';
                $(".cal_tbl tbody").append(rowHtml);
            });
        }
    });
}
//시간 포맷 함수
function formatTime(time) {
    var date = new Date(time);
    var hours = date.getHours();
    var minutes = date.getMinutes();
    var seconds = date.getSeconds();
    return (hours < 10 ? "0" + hours : hours) + ":" 
        + (minutes < 10 ? "0" + minutes : minutes) + ":" 
        + (seconds < 10 ? "0" + seconds : seconds);
}
//요일 구하는 함수
function getDayString(day) {
    var days = ['일', '월', '화', '수', '목', '금', '토'];
    return days[day];
}
//일자와 요일을 리턴하는 함수
function formatDateAndDay(dateString) {
    var dateArray = dateString.split(" ");
    console.log(dateArray);
    var month = dateArray[0].replace("월", "");
    var day = dateArray[1].replace(",", ""); 
    var year = dateArray[2];

    var date = new Date(year + "/" + month + "/" + day);
    console.log(date);

    var dayString = getDayString(date.getDay());
    return date.getDate() + ' ' + dayString;
}

</script>


