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
  .padding10px{padding: 10px;}
  .margin10px{margin: 10px;}
  .flexSpace{display:flex;align-items: center;justify-content: space-between; }

  /* 색상 설정 */
  .bgc-fff { background-color: #fff; }
  .bgc-F8FCFF { background-color: #F8FCFF; }
  .hrstyle{border-bottom:solid 1px #e0e0e0;}

  /* 게시판 헤더 */
  .head-nav { height: 56px; display: flex; align-items: center; padding-left: 30px; }
  .head-nav ul li { margin: 0px 5px; }

  /* 상세화면 스타일 */
  #noticeDetailDiv { margin: 60px 20px; padding: 20px; border-radius: 5px; }
  #noticeTitle { font-size: 24px; font-weight: bold; margin-bottom: 20px; }
  #noticeContent { white-space: pre-line; margin-top: 20px; }
  #noticeWriter, #noticeDate,#noticeViewCount { font-size: 14px; color: #888888; }
  
  /* 댓글 영역 스타일 */
  #commentSection { margin-top: 30px; border-top: 1px solid #e0e0e0; padding-top: 20px; }
  #commentList { margin-top: 20px; }
  .commentItem { border-bottom: 1px dashed #e0e0e0; padding: 10px 0; }
  .recommentItem {padding: 10px 0; }
  .commentWriter, .commentDate, .recommentWriter, .recommentDate { font-size: 14px; color: #888888; }
  .commentContent,.recommentContent { margin-top: 10px; }
  .replySection{margin:10px; display: flex;}
  .replySection button{margin-left: 10px; }
  
  /* 버튼스타일 */
  button{cursor: pointer; }
  .prevAndNext{display: flex;justify-content: space-evenly;}
  .btnSimple{border: solid 1px #e0e0e0;background-color:#fff; }
  .btnSimple:hover{color:var(--main-color-dk);background-color:#fff;}
  #submitCommentBtn{margin: 010px; height: 50px;}
  .listAndUpdateAndDelete{display: flex;justify-content: space-between;margin: 0 10px;}
  
    /* 첨부파일 스타일 */
  .file-download { border: 1px solid #e0e0e0; padding: 10px; margin-bottom: 20px; border-radius: 4px; display: flex; align-items: center;}
  .file-download button { cursor: pointer; background-color: #e0e0e0; padding: 8px 20px; border-radius: 4px;  font-size: 12px;}
  /* 첨부된 파일 목록 스타일 */
  .file-item {display: inline-block;background-color: #f2f2f2;padding: 5px;margin: 5px;border-radius: 4px;font-size: 8px;}
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
        <div class="section-shadow bgc-fff padding10px">
            <div id="noticeDetailDiv" class="column hrstyle">
	            <div>
	                <div id="noticeTitle">${n.noticeTitle }</div>
	            </div>
	            <div class="row hrstyle">
	                <div id="noticeWriter" class="margin10px">${n.member.memberName }</div>
	                <div id="noticeDate" class="margin10px">${n.noticeDate }</div>
	                <div id="noticeViewCount" class="margin10px">조회수 ${n.viewCount }</div>
	            </div>
                <div id="noticeContent">
					${n.noticeContent }
                </div>
				<div class="file-download">
				    <c:if test="${empty fileList }">
				        <p>첨부된 파일이 없습니다.</p>
				    </c:if>
				    <c:if test="${not empty fileList }">
				        <c:forEach items="${fileList }" var="f">
				            <div class="file-item">
				               <a href="${path}/board/downloadFile?fileId=${f.fileId}" class="file-item">
				               		${f.originalFile}
				               </a>
				            </div>
				        </c:forEach>
				    </c:if>
				</div>
            </div>
            <div class="btnContainer">
	            <div class="prevAndNext">
	            <c:set var="prevNo" value="${empty prevNotice.noticeNo ? 0 : prevNotice.noticeNo}"/>
				<c:set var="nextNo" value="${empty nextNotice.noticeNo ? 0 : nextNotice.noticeNo}"/>
	            	<div class="margin10px">
	                	<c:if test="${empty prevNotice}">
	                		<span>이전글이 없습니다.</span>
	                	</c:if>
	                	<c:if test="${not empty prevNotice}">
		                	<button id="prevBtn" class="btnSimple">이전글</button>
	                		<span>${prevNotice.noticeTitle }</span>
	                	</c:if>
	            	</div>
	            	<hr>
	            	<div class="margin10px">
	            		<c:if test="${empty nextNotice}">
	                		<span>다음글이 없습니다.</span>
	                	</c:if>
	                	<c:if test="${not empty nextNotice}">
	                		<span>${nextNotice.noticeTitle }</span>
		                	<button id="nextBtn" class="btnSimple">다음글</button>
	                	</c:if>
	            	</div>
	            </div>
	            <div class="listAndUpdateAndDelete">
	            	<div>
		                <button id="listBtn" class=" btnSimple">목록</button>
	            	</div>
	                <div>
	                	<c:if test="${loginMember.memberId eq n.member.memberId }">
		                <button id="updateBtn" class="margin10px btnSimple">수정</button>
		                <button id="deleteBtn" class=" btnSimple">삭제</button>
		                </c:if>
	                </div>
	            </div>
            </div>
        </div>
        <div id="commentSection" class="section-shadow bgc-fff padding10px">
		    <div class="center">
		        <textarea id="commentInput" placeholder="댓글을 작성하세요..." rows="3" cols="80"></textarea>
		        <button id="submitCommentBtn">등록</button>
		    </div>
			     <!-- 댓글 리스트 출력 -->
				<div id="commentList">
				    <c:set var="nonDeletedCommentsExist" value="false"/>
				    <c:forEach items="${commentList}" var="comment">
				         <!-- 삭제되지 않은 댓글이 있는지 확인 -->
				        <c:if test="${comment.status ne 'DELETED'}">
				            <c:set var="nonDeletedCommentsExist" value="true"/>
				        </c:if>
				    </c:forEach>
				    <c:if test="${empty commentList or not nonDeletedCommentsExist}">
				        <p style="text-align: center;">작성된 댓글이 없습니다. 첫번째 댓글을 작성해주세요!</p>
				    </c:if>
				    <c:if test="${not empty commentList and nonDeletedCommentsExist}">
				        <c:forEach items="${commentList}" var="comment">
				            <c:if test="${comment.refCommentNo==0}">
				                <c:set var="hasReplies" value="false"/>
				                 <!-- 해당 댓글에 대댓글이 있는지 확인 -->
				                <c:forEach items="${commentList}" var="reply">
				                    <c:if test="${reply.refCommentNo eq comment.commentNo and reply.status ne 'DELETED'}">
				                        <c:set var="hasReplies" value="true"/>
				                    </c:if>
				                </c:forEach>
				                <!-- 댓글이 삭제되지 않았거나 대댓글이 있다면 출력 -->
				                <c:if test="${comment.status ne 'DELETED' or hasReplies}">
				                    <div class="commentItem" id="comment${comment.commentNo}">
				                        <div class="flexSpace">
				                            <div>
				                             <!-- 댓글이 삭제되지 않은 경우 정보와 내용 출력 -->
				                                <c:if test="${comment.status ne 'DELETED'}">
				                                    <span class="commentWriter">${comment.member.memberName }</span>
				                                    <span class="commentDate">${comment.commentDate }</span>
				                                    <div class="commentContent">${comment.commentContent }</div>
				                                </c:if>
				                                <c:if test="${comment.status eq 'DELETED'}">
				                                    <div class="commentContent">삭제된 댓글입니다.</div>
				                                </c:if>
				                            </div>
				                            <div>
				                           		 <!-- 댓글이 삭제되지 않은 경우 버튼 출력 -->
				                                <c:if test="${comment.status ne 'DELETED'}">
				                                    <button class="replyBtn btnSimple">답글</button>
				                                    <c:if test="${ comment.member.memberId eq loginMember.memberId}">
				                                        <button class="replyUpdateBtn btnSimple">수정</button>
				                                        <button class="replyDeleteBtn btnSimple">삭제</button>
				                                    </c:if>
				                                </c:if>
				                            </div>
				                        </div>
				                        <!-- 대댓글 작성 영역 -->
				                        <c:if test="${comment.status ne 'DELETED'}">
				                            <div class="replySection" style="margin-left: 20px; display: none;">
				                                <textarea id="replyInput${comment.commentNo}" placeholder="답글을 작성하세요..." rows="2" cols="70"></textarea>
				                                <button class="submitReplyBtn">등록</button>
				                            </div>
				                        </c:if>
				                        <!-- 대댓글 영역 시작 -->
				                        <c:forEach items="${commentList}" var="reply">
				                        	<!-- 해당 댓글에 대한 대댓글이고 삭제되지 않았을 경우 출력 -->
				                            <c:if test="${reply.refCommentNo eq comment.commentNo and reply.status ne 'DELETED'}">
				                                <div class="replyList" style="margin-left: 20px;">
				                                    <div class="recommentItem" id="reply${reply.commentNo}">
				                                        <span class="recommentWriter">${reply.member.memberName }</span>
				                                        <span class="recommentDate">${reply.commentDate }</span>
				                                        <div class="recommentContent">${reply.commentContent }</div>
				                                        <div>
				                                            <c:if test="${ reply.member.memberId eq loginMember.memberId}">
				                                                <button class="replyUpdateBtn2 btnSimple">수정</button>
				                                                <button class="replyDeleteBtn2 btnSimple">삭제</button>
				                                            </c:if>
				                                        </div>
				                                    </div>
				                                </div>
				                            </c:if>
				                        </c:forEach>
				                    </div>
				                </c:if>
				            </c:if>
				        </c:forEach>
				    </c:if>
				</div>
				<!-- 댓글영역끝 -->
		    </div>
		</div>
</section>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
$(document).ready(function() {
	$('#listBtn').on('click', function() {
        location.href = "${path}/board/noticeList";
    });
	
    $('.replyBtn').on('click', function() {
        var replySection = $(this).parent().parent().next('.replySection');
        replySection.toggle();
    });

    // 이전글 버튼 클릭 이벤트
    $('#prevBtn').on('click', function() {
        location.href = "${path}/board/noticeView?no=" + ${prevNo};
    });

    // 다음글 버튼 클릭 이벤트
    $('#nextBtn').on('click', function() {
        location.href = "${path}/board/noticeView?no=" + ${nextNo};
    });

    
 // 댓글 등록 버튼 클릭 이벤트
    $('#submitCommentBtn').on('click', function() {
        const noticeNo = ${n.noticeNo};
        addCommentOrReply(noticeNo);
    });
 // 대댓글 등록 버튼 클릭 이벤트
    $('#commentList').on('click', '.submitReplyBtn', function() {
        const commentNo = $(this).prev('textarea').attr('id').replace('replyInput', '');
        const noticeNo = ${n.noticeNo};
        addCommentOrReply(noticeNo, commentNo);
    });

 // 댓글 수정 버튼 클릭 이벤트
    $('#commentList').on('click', '.replyUpdateBtn', function() {
        let commentItem = $(this).closest('.commentItem');
        let commentContent = commentItem.find('.commentContent').text().trim();
        let commentNo = $(this).closest('.commentItem').attr('id').replace('comment', '');
        commentItem.find('.commentContent').html('<textarea rows="2" cols="70" id="editComment' + commentNo + '">' + commentContent + '</textarea><button class="confirmEditCommentBtn">수정 완료</button>');
    });

    // 대댓글 수정 버튼 클릭 이벤트
    $('#commentList').on('click', '.replyUpdateBtn2', function() {
        let replyItem = $(this).closest('.recommentItem');
        let replyContent = replyItem.find('.recommentContent').text().trim();
        let commentNo = $(this).closest('.recommentItem').attr('id').replace('reply', '');
        replyItem.find('.recommentContent').html('<textarea rows="2" cols="70" id="editReply' + commentNo + '">' + replyContent + '</textarea><button class="confirmEditReplyBtn">수정 완료</button>');
    });

    // 댓글 삭제 버튼 클릭 이벤트
    $('#commentList').on('click', '.replyDeleteBtn', function() {
        if (confirm('정말로 삭제하시겠습니까?')) {
            let commentNo = $(this).closest('.commentItem').attr('id').replace('comment', '');
            deleteCommentOrReply(commentNo);
        }
    });

    // 대댓글 삭제 버튼 클릭 이벤트
    $('#commentList').on('click', '.replyDeleteBtn2', function() {
        if (confirm('정말로 삭제하시겠습니까?')) {
            let commentNo = $(this).closest('.recommentItem').attr('id').replace('reply', '');
            deleteCommentOrReply(commentNo);
        }
    });

	 // 댓글 및 대댓글 삭제 함수
	 function deleteCommentOrReply(commentNo) {
	     $.post(
	         "${path}/board/noticeCommentDelete",
	         {commentNo: commentNo},
	         function(response) {
	             if(response.status === "success") {
	                 alert("댓글이 성공적으로 삭제되었습니다.");
	                 location.reload();
	             } else {
	                 alert("댓글 삭제에 실패하였습니다.");
	             }
	         });
	 }

	 //수정페이지로 넘기는 이벤트
	 $("#updateBtn").on('click', function() {
	         location.href = "${path}/board/updateNotice?no="+${n.noticeNo};
	 });
 
	//삭제버튼 이벤트
	$("#deleteBtn").on('click', function() {
		if (confirm('정말로 삭제하시겠습니까?')) {
		     $.post(
		             "${path}/board/deleteNotice",
		             {noticeNo: ${n.noticeNo}},
		             function(response) {
		                 if(response.status === "success") {
		                     alert("게시글이 성공적으로 삭제되었습니다.");
		                     location.href = "${path}/board/noticeList";
		                 } else {
		                     alert("게시글 삭제에 실패하였습니다.");
		                 }
		             });
	    }
	});


});

//댓글 및 대댓글 작성 함수
function addCommentOrReply(noticeNo, parentCommentNo) {
    let commentContent = "";
    if(parentCommentNo) {
    	commentContent = $("#replyInput" + parentCommentNo).val();
    } else {
        commentContent = $("#commentInput").val();
    }

    $.post(
        "${path}/board/noticeCommentAdd",
        {
            noticeNo: noticeNo,
            commentContent: commentContent,
            refCommentNo: parentCommentNo ? parentCommentNo : null
        },
        function(response) {
            location.reload();
        }
    );
}

//댓글 수정 완료 버튼 클릭 이벤트
$('#commentList').on('click', '.confirmEditCommentBtn', function() {
    let commentItem = $(this).closest('.commentItem');
    let editedContent = commentItem.find('textarea').val();
    let commentNo = commentItem.attr('id').replace('comment', '');
    updateCommentOrReply(commentNo, editedContent);
});

// 대댓글 수정 완료 버튼 클릭 이벤트
$('#commentList').on('click', '.confirmEditReplyBtn', function() {
    let replyItem = $(this).closest('.recommentItem');
    let editedContent = replyItem.find('textarea').val();
    let commentNo = replyItem.attr('id').replace('reply', '');
    updateCommentOrReply(commentNo, editedContent);
});

// 댓글 및 대댓글 수정 함수
function updateCommentOrReply(commentNo, content) {
    $.post(
        "${path}/board/noticeCommentUpdate",
        {commentNo: commentNo, commentContent: content},
        function(response) {
            if(response.status === "success") {
                alert("댓글 수정이 성공적으로 완료되었습니다.");
                location.reload();
            } else {
                alert("댓글 수정 중 오류가 발생하였습니다.");
            }
        }
    );
}



</script>


</body>
</html>
