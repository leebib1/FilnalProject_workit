
const close = () => {
	document.querySelector(".modal").classList.add("hidden");
	$("#people-box").empty();
	/*    $("#line-box>div").remove(); // empty() -> 선택한요소의 자식요소들을 모두 삭제
		$("#refer-box>div").remove();*/
	// remove() -> 선택한 요소자체를삭제 (자식까지 다 삭제)
}

const openBtn = () => {
	document.querySelector(".modal").classList.remove("hidden");
	$("#line-box>div").remove();
	$("#refer-box>div").remove();

	$(".appClass").each(function() {  // 결재선 설정 버튼 눌렀을 때 (바깥에 있는 결재선 값들을 기준으로 안에있는 결재선에 값이 불러와짐 )
		/*		  console.log(this.innerText);
				  console.log(this.innerText.length);*/

		const str = this.innerText.split(" ");

		$("#line-box").append($('<div/>', { class: str[0] })); // 결재선 만들어질때, div로 묶고 만들어짐 클래스값 = 사원번호
		$("." + str[0]).append($('<input/>', { type: 'checkbox', name: 'appBox', value: str[0], width: '30px', margin: "10px" }));
		$("." + str[0]).append($('<img/>',{src:path+'/resources/images/approve/circle_people.png',width:'20px',height:'20px'}));
		$("." + str[0]).append(str[0] + " " + str[1] + " " + str[2] + " " + str[3], '<br>');
	});


	$(".appId").each(function() {   // 결재선 설정 버튼 눌렀을 때 (바깥에 있는 참조선 값들을 기준으로 안에있는 참조선에 값이 불러와짐 )
		console.log(this.innerText);
		console.log(this.innerText.length);

		const str = this.innerText.split(" ");

		var obj = $('<div>');
		obj.attr('id', str[0]);

		$("#refer-box").append(obj); // 결재선 만들어질때, div로 묶고 만들어짐 클래스값 = 사원번호
		$(obj).append($('<input/>', { type: 'checkbox', name: 'referBox', value: str[0], width: '30px', margin: "10px" }));
		$(obj).append($('<img/>',{src:path+'/resources/images/approve/circle_people.png',width:'20px',height:'20px'}));
		$(obj).append(str[0], '&nbsp;', str[1], '&nbsp;', str[2], '&nbsp;', str[3], '<br>')
	});

}

/*  document.querySelector(".openBtn").addEventListener("click", open);*/
document.querySelector("#close-button").addEventListener("click", close);
document.querySelector(".bg").addEventListener("click", close);



const changeDep = (e) => {  // 결재선 선택창에서 부서 눌렀을 때
	const value = e.target.value;

	$.post(path + "/approve/changeDep.do",
		{ deptName: value },
		data => {  // 데이터를 객체로(키,값) 전달
			$("#people-box").empty(); // #people-box 밑에 자식요소들 모두삭제
			for (let i = 0; i < data.length; i++) {
				var a = [data[i].memberId, data[i].memberName, data[i].job.jobName, data[i].dept.deptName];
				if(memberId != data[i].memberId){ // 본인아이디에서는 결재선과 참조선에 이름이 나오지 않는 로직처리
					$("#people-box").append($('<input/>', { type: 'checkbox', name: 'peopleBox', value: a, width: '30px'}));
					$("#people-box").append($('<img/>',{src:path+'/resources/images/approve/circle_people.png',width:'20px',height:'20px'}));
					$("#people-box").append(data[i].memberId, '&nbsp;', data[i].memberName, '&nbsp;', data[i].job.jobName, '&nbsp;', data[i].dept.deptName, '<br>')
				}
			}
		});
}

const applyOn = () => { // 결재선 목록에 -> 화살표눌렀을 때

	if ($('input:checkbox[name="peopleBox"]:checked').length == 0) { //결재선에 추가할 체크박스에 체크된개수가 0개이면
		alert("사원을 선택해주세요");
	} else { // 그외 체크된개수가 1개이상이면
		$('input:checkbox[name="peopleBox"]:checked').each(function() { // 체크된것들을 foreach문으로 비교
			var flag = false;
			const str = this.value.split(",");

			$('input:checkbox[name="appBox"]').each(function() {  // 결재선에 추가되있는 사람을 중복확인하기위한 로직
				const app = this.value.split(",");
				if (str[0] == app[0]) {
					flag = true; // 추가되있는 명단과, 추가할 사람의 사원번호가 동일하면 그 사람은 flag값을 true로
				}
			})

			if (flag == false) {
				if ($('input:checkbox[name="appBox"]').length >= 3) { //추가할 명단이 중복되지않았을때, 최대인원이 3명으로 제한
					alert("최대 3명까지만 결재신청 가능합니다");
					return false;
				} else { // 그외에는 추가함
					$("#line-box").append($('<div/>', { class: str[0] })); // 결재선 만들어질때, div로 묶고 만들어짐 클래스값 = 사원번호
					$("." + str[0]).append($('<input/>', { type: 'checkbox', name: 'appBox', value: str[0], width: '30px', margin: "10px" }));
					$("." + str[0]).append($('<img/>',{src:path+'/resources/images/approve/circle_people.png',width:'20px',height:'20px'}));
					$("." + str[0]).append(str[0] + " " + str[1] + " " + str[2] + " " + str[3], '<br>')
				}

			} else { // flag값이 true일 경우에는 추가하지않음
				alert("이미 등록된 사원입니다");
				return false;
			}
		})
		$("input:checkbox[name=peopleBox]").prop("checked", false); // 다 추가하고나서 선택창의 체크박스 초기화
	}
}


const applyOff = () => {  // 결재선 목록에 <- 버튼 눌렀을때

	if ($('input:checkbox[name="appBox"]:checked').length == 0) { //name="peopleBox"인 체크박스에 체크된개수가 0개이면
		alert("결재선 취소할 사원을 선택해주세요");
	} else {
		$('input:checkbox[name="appBox"]:checked').each(function() {
			$('.' + this.value).remove();
			console.log(this.value); // value 값기준으로 태그삭제			 
		})
	}
}


const referOn = () => { // 참조선 목록에 -> 버튼 눌렀을 때
	if ($('input:checkbox[name="peopleBox"]:checked').length == 0) { //결재선에 추가할 체크박스에 체크된개수가 0개이면
		alert("사원을 선택해주세요");
	} else { // 그외 체크된개수가 1개이상이면
		$('input:checkbox[name="peopleBox"]:checked').each(function() { // 체크된것들을 foreach문으로 비교
			var flag = false;
			const str = this.value.split(",");

			$('input:checkbox[name="referBox"]').each(function() {  // 결재선에 추가되있는 사람을 중복확인하기위한 로직
				const app = this.value.split(",");
				if (str[0] == app[0]) {
					flag = true; // 추가되있는 명단과, 추가할 사람의 사원번호가 동일하면 그 사람은 flag값을 true로
				}
			})

			if (flag == false) {
				if ($('input:checkbox[name="referBox"]').length >= 3) { //추가할 명단이 중복되지않았을때, 최대인원이 3명으로 제한
					alert("최대 3명까지만 결재신청 가능합니다");
					return false;
				} else { // 그외에는 추가함
					var obj = $('<div>');
					obj.attr('id', str[0]);
					console.log(obj);
					$("#refer-box").append(obj); // 결재선 만들어질때, div로 묶고 만들어짐 클래스값 = 사원번호
					$(obj).append($('<input/>', { type: 'checkbox', name: 'referBox', value: str[0], width: '30px', margin: "10px" }));
					$(obj).append($('<img/>',{src:path+'/resources/images/approve/circle_people.png',width:'20px',height:'20px'}));
					$(obj).append(str[0], '&nbsp;', str[1], '&nbsp;', str[2], '&nbsp;', str[3], '<br>')
				}

			} else { // flag값이 true일 경우에는 추가하지않음
				alert("이미 등록된 사원입니다");
				return false;
			}
		})
		$("input:checkbox[name=peopleBox]").prop("checked", false); // 다 추가하고나서 선택창의 체크박스 초기화
	}
}


const referOff = () => {  // 참조선 목록에 <- 버튼 눌렀을때
	if ($('input:checkbox[name="referBox"]:checked').length == 0) { //name="peopleBox"인 체크박스에 체크된개수가 0개이면
		alert("결재선 취소할 사원을 선택해주세요");
	} else {
		$('input:checkbox[name="referBox"]:checked').each(function() {
			$('#' + this.value).remove();
			console.log(this.value); // value 값기준으로 태그삭제			 
		})
	}
}


const registButton = () => {  // 결재선 등록버튼 눌렀을 때
	const appLength = $('input:checkbox[name="appBox"]').length;
	const referLength = $('input:checkbox[name="referBox"]').length;

	if (appLength < 1 || referLength < 1) {
		alert("결재선과 참조선 명단에 최소 한명씩 등록해주세요");

	} else { // 결재선과 참조선에 동일한 사람이 있을 경우 등록안되도록 예외처리
		var flag = false;
		$('input:checkbox[name="appBox"]').each(function() {
			const str = this.value.split(",");

			$('input:checkbox[name="referBox"]').each(function() {
				const app = this.value.split(",");
				if (str[0] == app[0]) {
					flag = true; //
				}
			})
		})

		if (flag == true) { // 결재선과 참조선에 동일한 사람이 있을경우의 플래그 = true
			alert("결재선과 참조선에 동일한 사원이 존재합니다");
			return false;
		} else {
			const ListData = [];
			const referListData = [];
			$("#regist-app>span").remove();
			$("#regist-reference>span").remove();
			$("#app-line>div").remove();
			$('input:checkbox[name="appBox"]').each(function() {  // 결재선에 선택된 값들의 ID값 리스트에 넣음
				ListData.push(this.value);
			})

			$.post(path + "/approve/printMember.do",
				{ memberId: ListData },   // 데이터를 객체로(키,값) 전달
				data => {
					for (let i = 0; i < data.length; i++) {
						const span = $("<span>");
						span.attr("class", "appClass");
						$("#regist-app").append(span);
						span.append($('<img/>',{src:path+'/resources/images/approve/circle_people.png',width:'20px',height:'20px'}));
						span.append(data[i].memberId + " " + data[i].memberName + " " + data[i].job.jobName + " " + data[i].dept.deptName, '<br>');
						span.append($("<input/>", { type: 'hidden', name: 'paraApp', value: data[i].memberId })); // 파라미터로 넘길 결재선 값들
						const di = $("<div>").css("border", "1px solid black").height("98px").width("120px");
						$("#app-line").append(di);
						di.append($("<div>").css("border-bottom", "1px solid black").height("30px").width("120px").text(data[i].memberName + " " + data[i].job.jobName).css("text-align","center"));
						di.append($("<div>").height("40px").width("120px"));
						di.append($("<div>").css("border-top", "1px solid black").height("28px").width("120px").text(i+1).css("text-align","center"));
						
					}
				});



			$('input:checkbox[name="referBox"]').each(function() {  // 참조선에 선택된 값들의 ID값 리스트에 넣음
				referListData.push(this.value);
			})
			$.post(path + "/approve/printMember.do",
				{ memberId: referListData },   // 데이터를 객체로(키,값) 전달
				data => {

					for (let j = 0; j < data.length; j++) {
						const span = $("<span>");
						span.attr("class", "appId");
						$("#regist-reference").append(span);
						span.append($('<img/>',{src:path+'/resources/images/approve/circle_people.png',width:'20px',height:'20px'}));
						span.append(data[j].memberId + " " + data[j].memberName + " " + data[j].job.jobName + " " + data[j].dept.deptName, '<br>');
						span.append($("<input/>", { type: 'hidden', name: 'paraRefer', value: data[j].memberId })); // 파라미터로넘길 참조선값들		
					}

				});

			close();
		}
	}
}