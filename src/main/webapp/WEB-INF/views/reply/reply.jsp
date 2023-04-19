<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2023-04-13
  Time: 오후 11:00
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--<%@ include file="../layout/header.jsp" %>--%>
<div class="card" style="margin: 0 auto; width: 80%; height: auto;">
    <h5 class="card-header">댓글 작성</h5>
    <div class="card-body">
        <form id="replyForm">
            <textarea id="replyContent" style="width: 100%" placeholder="내용을 입력해주세요."></textarea>
            <input type="hidden" id="creatorId" value="${signIn.username}">
            <input type="hidden" id="boardIdx" value="${board.boardIdx}">
        </form>
    </div>
    <div class="card-footer">
        <input type="button" class="btn btn-primary float-right" value="작성 완료" onclick="insertReply()">
    </div>
</div>
<br/>



<div class="card" style="margin: 0 auto; width: 80%; height: auto; margin-bottom:100px;">
    <h7 class="card-header">작성자: 조성우</h7>
    <div class="border-bottom">
        <div class="card-body">
            <tr><td><h6 class="card-title">내용이 들어갈 부분입니다.</h6></td>
        </div>
        <div style="text-align: right">
            <td><span class="card-text text-right" style="text-align: right">2023-04-13 오후 11:08:32</span></td></tr>
        </div>
    </div>
<%--    <h7 class="card-header">작성자: 조성우</h7>--%>
<%--    <div class="border-bottom">--%>
<%--        <div class="card-body">--%>
<%--            <tr><td><h6 class="card-title">내용이 들어갈 부분입니다.</h6></td>--%>
<%--        </div>--%>
<%--        <div style="text-align: right">--%>
<%--            <td><span class="card-text text-right" style="text-align: right">2023-04-13 오후 11:08:32</span></td></tr>--%>
<%--        </div>--%>
<%--    </div>--%>
</div>

<script>
    window.onload = function () { // 댓글 목록 출력
        const boardIdx = document.getElementById('boardIdx').value;
        let data = {boardIdx: boardIdx};

        let xhr = new XMLHttpRequest();
        xhr.open("POST", "/reply/getAllReply");
        xhr.setRequestHeader("Content-Type", "application/json; charset=utf-8");
        xhr.onload = function () {
            if (xhr.status === 200 || xhr.status === 201) {
                let resp = xhr.responseText;
                if (resp.status === 500) {
                    alert('에러가 발생했습니다.');
                } else {
                    alert(resp);
                }
            } else {
                console.log(xhr.responseText);
                alert('에러가 발생했습니다. \n에러 코드: ' + xhr.status);
            }
        };
        xhr.onerror = function () {
            alert('에러가 발생했습니다. \n에러 코드: ' + xhr.status);
        };
        xhr.send(JSON.stringify(data));
    }

</script>

<script>
    function insertReply() { // 댓글 등록
        const creatorId = document.getElementById('creatorId').value;
        const replyContent = document.getElementById('replyContent').value;
        const boardIdx = document.getElementById('boardIdx').value;

        if (replyContent.trim() === '' || replyContent.length === 0) {
            alert('댓글 내용을 입력해주세요.');
            return;
        }
        let data = {
            creatorId: creatorId,
            boardIdx: boardIdx,
            replyContent: replyContent
        };
        let xhr = new XMLHttpRequest();
        xhr.open("POST", "/reply/insertReply");
        xhr.setRequestHeader("Content-Type", "application/json; charset=utf-8");
        xhr.onload = function () {
            if (xhr.status === 200 || xhr.status === 201) {
                let resp = xhr.responseText;
                if (resp.status === 500) {
                    alert('에러가 발생했습니다.');
                } else {
                    if (resp == "insertSuccess") {
                        alert('댓글 작성이 완료되었습니다.');
                    } else {
                        alert('댓글 작성에 실패하였습니다.');
                    }
                }
            } else {
                console.log(xhr.responseText);
                alert('에러가 발생했습니다. \n에러 코드: ' + xhr.status);
            }
        };
        xhr.onerror = function () {
            alert('에러가 발생했습니다. \n에러 코드: ' + xhr.status);
        };
        xhr.send(JSON.stringify(data));
    }

</script>