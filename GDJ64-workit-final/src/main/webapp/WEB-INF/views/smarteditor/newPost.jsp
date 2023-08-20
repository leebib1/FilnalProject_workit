<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath }" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- 스마트 에디터 스크립트 로드 -->
<script type="text/javascript" src="${path }/resources/smarteditor/js/HuskyEZCreator.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
    <div id="smarteditor">
        <textarea id="editorTxt" name="editorTxt" rows="20" cols="10" style="width: 90%"></textarea>
    </div>


<script>
var oEditors = [];

function smartEditor() {
	nhn.husky.EZCreator.createInIFrame({
	    oAppRef: oEditors,
	    elPlaceHolder: "editorTxt",
	    sSkinURI: "${path }/resources/smarteditor/SmartEditor2Skin.html",
	    fCreator: "createSEditor2",
	    htParams : { 
	        bUseToolbar : true,
			bUseVerticalResizer : false,
			bUseModeChanger : false 
	    },
	    fOnAppLoad: function() {
            var noticeContent = '${notice.noticeContent}';  // escape 처리 제거
            var boardContent = '${board.boardContent}'; 
            if (noticeContent && typeof oEditors !== 'undefined' && oEditors.getById["editorTxt"]) {
                oEditors.getById["editorTxt"].exec("SET_CONTENTS", [noticeContent]);
            }else if (boardContent && typeof oEditors !== 'undefined' && oEditors.getById["editorTxt"]) {
                oEditors.getById["editorTxt"].exec("SET_CONTENTS", [boardContent]);
            }
        }
	});	
}

$(document).ready(function() {
	smartEditor();
});

</script>


</body>
</html>
