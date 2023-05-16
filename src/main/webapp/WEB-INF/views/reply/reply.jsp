<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2023-04-13
  Time: 오후 11:00
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<div class="card" style="margin: 0 auto; width: 80%; height: auto;">
    <h5 class="card-header">댓글 작성</h5> <!-- 댓글 작성 폼 -->
    <div class="card-body">
        <form id="replyForm">
            <textarea id="replyContents" style="width: 100%; resize: none" placeholder="내용을 입력해주세요."></textarea>
            <input type="hidden" id="boardIdx" value="${board.boardIdx}">
            <input type="hidden" id="username" value="${signIn.username}">
        </form>
    </div>
    <div class="card-footer">
        <input type="button" class="btn btn-primary float-right" value="작성 완료" onclick="insertReply()">
    </div>
</div>
<br/>
<reply></reply> <!-- 댓글 출력부분을 나타내는 reply 태그 -->

<script>
    window.onload = function() {
        getAllReply();
    }
</script>