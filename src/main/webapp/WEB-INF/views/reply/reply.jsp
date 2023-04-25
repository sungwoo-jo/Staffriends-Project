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
            <textarea id="replyContents" style="width: 100%; resize: none" placeholder="내용을 입력해주세요."></textarea>
            <input type="hidden" id="userId" value="${signIn.id}">
            <input type="hidden" id="boardIdx" value="${board.boardIdx}">
            <input type="hidden" id="username" value="${signIn.username}">
        </form>
    </div>
    <div class="card-footer">
        <input type="button" class="btn btn-primary float-right" value="작성 완료" onclick="insertReply()">
    </div>
</div>
<br/>
<reply></reply>

<script>
    window.onload = function() {
        getAllReply();
    }

</script>

<script>
    function insertReply() { // 댓글 등록
        const userId = document.getElementById('userId').value;
        const username = document.getElementById('username').value;
        const replyContents = document.getElementById('replyContents').value;
        const boardIdx = document.getElementById('boardIdx').value;

        if (replyContents.trim() === '' || replyContents.length === 0) {
            alert('댓글 내용을 입력해주세요.');
            return;
        }
        let data = {
            userId: userId,
            username: username,
            boardIdx: boardIdx,
            replyContents: replyContents
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
        const userId = document.getElementById('userId').value;
        const username = document.getElementById('username').value;

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
                        reply += '<div class="card-header">';
                        reply += '<h7>'+'작성자: '+parseData[i].username+'</h7>';
                        if (username === parseData[i].username) { // 댓글 작성자인 경우 삭제하기 버튼 생성
                            reply += '<span style="float: right"><a href="javascript:deleteReply('+parseData[i].replyIdx+');">삭제하기</a></span>';
                        }
                        reply += '</div>';
                        reply += '<div class="border-bottom">';
                        reply += '<div class="card-body">';
                        reply += '<tr><td><h6 class="card-title">'+ parseData[i].replyContents +'</h6></td>';
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

    function deleteReply(replyIdx) { // 댓글 삭제
        let data = replyIdx;
        let xhr = new XMLHttpRequest();
        xhr.open("POST", "/reply/deleteReply", "true");
        xhr.onload = function () {
            if (xhr.status === 200 || xhr.status === 201) {
                let resp = xhr.responseText;
                if (resp.status === 500) {
                    alert('에러가 발생했습니다.');
                } else {
                    if (resp === "deleteSuccess") {
                        alert('댓글이 삭제되었습니다.');
                        getAllReply();
                    } else {
                        alert('댓글을 삭제하지 못했습니다.');
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
        xhr.send(data);
    }
</script>