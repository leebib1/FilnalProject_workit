/* 	const extendsApply=()=>{
		$("#form-choice-result>img").attr("src", path+"/resources/images/approve/extends.png");
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
	
	 전자결재 클릭시 토글 on,off 
	$("#approve-menu").click(e=>{
     $("#div-approve>button").toggle();
	})

 여기부터는 모달창 작동하는 js 
const appopen = () => {
 document.querySelector(".approve").classList.remove("hidden-approve");
}

const appclose = () => {
 document.querySelector(".approve").classList.add("hidden-approve");
}

document.querySelector(".approval-request").addEventListener("click", appopen);
document.querySelector("#approval-close-button").addEventListener("click", appclose);
document.querySelector(".bg-approve").addEventListener("click", appclose);  */