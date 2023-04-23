<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2023-04-13
  Time: 오후 11:00
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
<reply>123123</reply>

<script>
    window.onload = function() {
        getAllReply();
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
                        getAllReply();
                        document.getElementById("replyContent").value = "";
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

    function getAllReply() { // 댓글 목록 출력
        const boardIdx = document.getElementById('boardIdx').value;

        let data = boardIdx;
        let xhr = new XMLHttpRequest();
        xhr.open("POST", "/reply/getAllReply", "true");
        xhr.onload = function () {
            if (xhr.status === 200 || xhr.status === 201) {
                let resp = xhr.responseText;
                if (resp.status === 500) {
                    alert('에러가 발생했습니다.');
                } else {
                    console.log(resp);
                    let reply = "";
                    let parseData = JSON.parse(resp);

                    for(let i=0; i<parseData.length; i++) {
                        reply += '<div class="card" style="margin: 0 auto; width: 80%; height: auto; margin-bottom:10px;" id="card">';
                        reply += '<h7 class="card-header">'+'작성자: '+parseData[i].creatorId+'</h7>';
                        reply += '<div class="border-bottom">';
                        reply += '<div class="card-body">';
                        reply += '<tr><td><h6 class="card-title">'+ parseData[i].replyContent +'</h6></td>';
                        reply += '</div>';
                        reply += '<div style="text-align: right">';
                        reply += '<td><span class="card-text text-right" style="text-align: right">'+parseData[i].createdDatetime+'</span></td></tr>';
                        reply += '</div>';
                        reply += '</div>';
                        reply += '</div>';
                    }
                    document.querySelector("reply").innerHTML = reply;
                }

            } else {
                console.log(xhr.responseText);
                alert('에러가 발생했습니다. \n에러 코드: ' + xhr.status);
            }
        };
        xhr.onerror = function () {
            alert('에러가 발생했습니다. \n에러 코드: ' + xhr.status);
        };
        xhr.send(data);
    }

</script>