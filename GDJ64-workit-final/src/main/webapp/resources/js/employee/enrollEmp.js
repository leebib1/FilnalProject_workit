//주소 검색 메소드
function fn_searchAddr() {
	//주소 API 사용
	new daum.Postcode({
		oncomplete: function(data) {
			$("#main-addr").val(data.address);
			$("#detail-addr").focus();
		}
	}).open();
}

//데이터 입력 확인 후 넘기는 메소드
function fn_empDataCk() {
	var textFl=false;
	const textArr=$("input[type=text]");
	for(var i=0; i<textArr.length;i++){
		if(textArr[i].value==""){
			textFl=false;
			break;
		}else{
			textFl=true;
		}
	};
	var selectFl=false;
	const selectArr=$("select");
	for(var i=0; i<selectArr.length;i++){
		if(selectArr[i].value==""){
			selectFl=false;
			break;
		}else{
			selectFl=true;
		}
	}
	const salary=$("#pay").val();
	const date=$("#hire-date").val();
	if(textFl&&selectFl&&salary!=""&&date!=""){
		$("#enroll-form").submit();
	}else{
		alert("사원 정보를 전부 입력하세요.");
	}
}

//취소 버튼 클릭 시
function fn_resetBtn(){
	for(var i=0;i<$("input[type=text]").length;i++){
		$("input[type=text]")[i].value='';
	}
	$("#dept option:eq(0)").prop("selected",true);
	$("#job option:eq(0)").prop("selected",true);
	$("#pay").val("");
	$("#hire-date").val("");
}