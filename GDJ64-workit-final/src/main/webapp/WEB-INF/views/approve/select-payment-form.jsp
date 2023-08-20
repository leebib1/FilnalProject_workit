<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
  <section>
	<div class="approve hidden-approve">
	  <div class="bg-approve"></div>
	  <div class="modalBox-approve">
	  		<span id="form-choice-name">결재양식 선택</span>
	  		<div id="form-flex">
	  			<div id="form-choice">
	  				<div id="form-column">
		  				<a onclick="extendsApply();">연장근무신청</a>
		  				<a onclick="attendanceApply();">근태신청</a>
		  				<a onclick="expenditureApply();">지출결의서신청</a>
	  				</div>
	  			</div>
	  			<div id="form-choice-result">
	  				<img src="${path}/resources/images/approve/default.png" id="approve-img-id" height="400px" width="250px"> 
	  			</div>
	  		</div>
	  		
			<button type="button" id="approval-close-button">닫기</button>
			<button type="button" id="approval-write-button" onclick="approvalWrite();">작성</button>
	  </div>
	</div>
</section>  
<%-- <link rel="stylesheet" href="${path}/resources/css/approve/select-payment-form.css"> 
<script src="${path}/resources/js/approve/select-payment-form.js"></script>
 --%>
 <style>
 #form-choice-name{ /* 결재양식선택 문구  */
		font-weight: bold;
		margin:10px;
		font-size: 25px;
	}

	#form-flex{ 
		display:flex;
	}
	
	#form-column{
		display:flex;
		flex-direction: column;
	}
	
	#form-column>a{
		font-size: 20px;
		font-weight: bold;
		margin: 20px;
	}

	#form-column>a:hover{
		color: #BDDFFF;
	}	

	#form-choice{  /* 결재서 양식 선택하는 곳 */
		border: 1px solid #D9D9D9;
		width: 200px;
		height:200px;
		margin-right: 20px;
		margin-top:20px;
	}
	
	#form-choice-result{ /* 결재서 양식 이미지 나오는 곳 */
		border: 1px solid #D9D9D9;
		width: 250px;
		height:400px;
		margin-top:20px;
	}
	
	
	#div-approve>button{ /* 전자결재 버튼 밑에 세부 항목들 꾸미기 */
		display: none;
		margin-left : 50px;
		background: white;
	}
	
	#div-approve>button:hover{ /* 전자결재 버튼 밑에 세부 항목들 호버 효과 */
		background: #BDDFFF;
	}
	
/* 여기부터 결재서양식 선택하는 모달창 style */	
	.approve {
          position: fixed;
          top: 0;
          left: 0;
          width: 100%;
          height: 100%;
          display: flex;
          justify-content: center;
          align-items: center;
        }

    .approve .bg-approve {
          width: 100%;
          height: 100%;
          background-color: rgba(0, 0, 0, 0.6);
        }

    .modalBox-approve {
          position: absolute;
          background-color: #fff;
          width: 500px;
          height: 500px;
          padding: 15px;
        }

    .hidden-approve {
          display: none;
        } 
        
     #approval-close-button{  
		margin-top:10px;
		margin-left:285px;
	}   
 </style>
 
<script>
 	const extendsApply=()=>{
		$("#form-choice-result>img").attr("src",path+"/resources/images/approve/extends.png");
	}
	// 근태신청서 양식 선택했을 때 이미지
	const attendanceApply=()=>{
		$("#form-choice-result>img").attr("src", path+"/resources/images/approve/attendance.png");
	}
	// 지출결의서 양식 선택했을 때 이미지
	const expenditureApply=()=>{
		$("#form-choice-result>img").attr("src", path+"/resources/images/approve/expenditure.png");
	}
	
	// 작성버튼 눌렀을때 분기처리
	const approvalWrite=()=>{
		src = $("#form-choice-result>img")[0].currentSrc; // 결재서양식 이미지 주소
		
		src = src.substring(src.lastIndexOf("/")+1);
	
		if(src == "default.png"){ // 기본이미지인 상태
			alert("결재서 양식을 선택해주세요");
		}else if(src == "extends.png"){ // 연장근무서 이미지 상태
			location.assign(path+"/approve/extendsView.do");
		}else if(src == "attendance.png"){ // 근태서 이미지 상태
			location.assign(path+"/approve/attendanceView.do");
		}else if(src == "expenditure.png"){ // 지출결의서 이미지 상태
			location.assign(path+"/approve/expenditureView.do");
		} 
	}
	
	/* 전자결재 클릭시 토글 on,off */
	$("#approve-menu").click(e=>{
     $("#div-approve>button").toggle();
	})

/* 여기부터는 모달창 작동하는 js */
const appopen = () => {
 document.querySelector(".approve").classList.remove("hidden-approve");
}

const appclose = () => {
 document.querySelector(".approve").classList.add("hidden-approve");
}

document.querySelector(".approval-request").addEventListener("click", appopen);
document.querySelector("#approval-close-button").addEventListener("click", appclose);
document.querySelector(".bg-approve").addEventListener("click", appclose);  
</script>


  