<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

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
  
  .title-container {
    padding: 20px 0;
    font-size: 24px;
    border-bottom: 1px solid #eee;
    margin-bottom: 20px;
}

 /* 공지사항 제목 */
#noticeTitle {width: 70%;padding: 10px;margin-bottom: 20px;border-radius:0px; border-style:none; border-bottom: 1px solid #eee;font-size: 32px;}
  /* 버튼스타일 */
  button{cursor: pointer; }
  .btnContainer{display: flex;justify-content: space-evenly;}
  .btnSimple{border: solid 1px #e0e0e0;background-color:#fff; }
  
  /* 첨부파일 스타일 */
  .file-upload { border: 1px solid #e0e0e0; padding: 10px; margin-bottom: 20px; border-radius: 4px; display: flex; align-items: center;}
  .file-upload input[type="file"] { display: none; }
  .file-upload label { cursor: pointer; background-color: #e0e0e0; padding: 8px 20px; border-radius: 4px;  font-size: 12px;}
  /* 첨부된 파일 목록 스타일 */
  .file-item {display: inline-block;background-color: #f2f2f2;padding: 5px;margin: 5px;border-radius: 4px;font-size: 8px;}
  /* 파일 제거 버튼 스타일 */
  .remove-file {margin-left: 5px;color: red;cursor: pointer;}
  
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
		<form action="" method="post" enctype="multipart/form-data">
			<div class="section-shadow bgc-fff" style="padding: 20px">
			    <input type="text" id="noticeTitle" placeholder="제목" required value="${notice.noticeTitle }"/>
				<div>
					<jsp:include page="/WEB-INF/views/smarteditor/newPost.jsp" />
				</div>
				<div class="file-upload">
				    <label for="file">첨부파일 선택</label>
				    <input type="file" id="file" name="file" multiple>
				    <div class="file-list" id="file-name">
				        <c:if test="${empty fileList }">
				            <p class="no-files-msg">첨부된 파일이 없습니다.</p>
				        </c:if>
				        <c:if test="${not empty fileList }">
				            <c:forEach items="${fileList}" var="f">
							    <div class="file-item">
							        ${f.originalFile}
							        <span class="remove-file">x</span>
							        <input type="hidden" name="fileId" value="${f.fileId}">
							    </div>
							    <c:set var="fileId" value="${f.fileId}" />
							</c:forEach>
				        </c:if>
				    </div>
				</div>

			    <div style="text-align: right;">
				    <button type="button" onclick="updateContent();">수정</button>
				    <button type="button" onclick="cancle();" class="btnSimple">취소</button>
			    </div>
			</div>
		</form>
	</div>
</section>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
var selectedFiles = [];

$(document).ready(function() {

 	// 기존 첨부된 파일 제거 버튼 기능
    $(".remove-file").click(function() {
    	var fileItem = $(this).closest(".file-item");
    	 var fileId = $(this).siblings("input[name='fileId']").val();
    	 //console.log(fileId);
        if(confirm('이 파일을 제거하시겠습니까?')) {
            $.ajax({
                url: "${path}/board/removeNoticeFile",
                type: "POST",
                data: {fileId: fileId},
                success: function(response) {
                	if(response.status === "success") {
                        alert("파일이 성공적으로 제거되었습니다.");
                        fileItem.remove(); // 해당 파일 아이템 제거
                    } else if(response.status === "notfound") {
                        alert("파일을 찾을 수 없습니다.");
                    } else {
                        alert("파일 제거에 실패하였습니다.");
                    }
                },
                error: function() {
                    alert("파일 제거 중 오류가 발생하였습니다.");
                }
            });
        }
    });
    $(".file-upload input[type='file']").change(function() {
        var fileList = $(".file-list");

        Array.from(this.files).forEach(function(file) {
            var fileName = file.name;
            var fileItem = $('<span class="file-item">' + fileName + ' <span class="remove-file-new">x</span></span>');
            
            // 새로 추가된 파일 제거 기능
            fileItem.find(".remove-file-new").click(function() {
            	var index = selectedFiles.indexOf(file);  
                if (index > -1) {
                    selectedFiles.splice(index, 1);  
                }
                $(this).parent().remove();
            });
            
            fileList.append(fileItem);
            selectedFiles.push(file);

            $(".no-files-msg").hide();
        });

        if (this.files.length === 0 && fileList.children().length === 0) {
            $(".no-files-msg").show();
        }
    });
    
    
});


function updateContent() {
    oEditors.getById["editorTxt"].exec("UPDATE_CONTENTS_FIELD", []);

    if (confirm('공지사항을 수정하시겠습니까?')) {
        var formData = new FormData();
        formData.append('no', ${notice.noticeNo});
        formData.append('content', $("#editorTxt").val());
        formData.append('title', $("#noticeTitle").val());

        $.each(selectedFiles, function(i, file) {
        	console.log(file);
            formData.append("files", file);
        });

        $.ajax({
            url: "${path}/board/updateNoticeEnd",
            type: "POST",
            data: formData,
            processData: false,
            contentType: false,
            success: function(response) {
                if (response.status === "success") {
                    alert("공지사항이 성공적으로 수정되었습니다.");
                    location.assign('${path}/board/noticeView?no=' + ${notice.noticeNo});
                } else {
                    alert("공지사항 수정에 실패하였습니다.");
                }
            }
        });
    }
}


	function cancle(){
		if(confirm('공지사항 작성을 취소하시겠습니까?')){
			location.href = "${path}/board/noticeList";
		}
	}

</script>

</body>
</html>