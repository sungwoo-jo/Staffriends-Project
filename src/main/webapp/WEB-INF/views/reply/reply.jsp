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
                    if (resp === "insertSuccess") {
                        alert('댓글 작성이 완료되었습니다.');
                        getAllReply();
                        document.getElementById("replyContents").value = "";
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
                        reply += '<div class="card" style="margin: 0 auto; width: 80%; height: auto; margin-bottom:10px; left: ' + parseData[i].replyDepth * 10 + 'px;" id="card">';
                        reply +=    '<div class="card-header">';
                        reply +=        '<h7>'+'작성자: '+parseData[i].username+'</h7>';
                        reply +=        '<td><span class="card-text text-right" style="font-size: small; float: right">'+parseData[i].createdDatetime+'</span></td>';
                        reply +=    '</div>';
                        reply +=    '<div class="border-bottom">';
                        reply +=        '<div class="card-body">';
                        reply +=            '<tr><td><h6 class="card-title">'+ parseData[i].replyContents +'</h6></td>';
                        reply +=        '</div>';
                        reply +=    '<div style="text-align: right">';
                        if (username === parseData[i].username) { // 댓글 작성자인 경우 삭제하기 버튼 생성
                            reply +=    '<span style="float: right"><a style="color: #007bff; margin-right: 10px;" href="javascript:deleteReply('+parseData[i].replyIdx+');">삭제하기</a></span>';
                        }
                        reply +=        '<span style="float: right;"><a href="javascript:showReplyForm('+ parseData[i].replyIdx +');" style="color: #007bff; margin-right: 10px;" id="addReply'+ parseData[i].replyIdx +'">댓글달기</a></span>';
                        reply +=    '</div>';
                        reply += '</div>';
                        reply += '<replyAdd'+ parseData[i].replyIdx +' style="display: none">'; <!-- 댓글작성 누르면 나타나는 부분 -->
                        reply +=    '<div class="card-header" style="border: none; padding-bottom: 0; "> <!-- 대댓글 헤더 -->';
                        reply +=        '<strong style="padding-right: 5px; margin-bottom: 0">└</strong>&nbsp;';
                        reply +=    '</div>';
                        reply += '<div class="border-bottom" style="background: rgba(0, 0, 0, .03); border-style: hidden; padding-right: 10px">';
                        reply += '  <div class="card-body" style="padding-left: 40px;">';
                        reply += '    <td><textarea style="width: 80%; resize: none" id="reReply'+ parseData[i].replyIdx +'" placeholder="댓글 내용을 입력해주세요."></textarea></td>';
                        reply += '  </div>';
                        reply += '  <div style="text-align: right; padding-left: 40px;">';
                        reply += '    <span style="float: right; margin-right: 10px;"><a href="javascript:insertReReply('+ parseData[i].replyIdx +')" style="color: #007bff">작성완료</a></span>';
                        reply += '  </div>';
                        reply += '</div>';
                        reply += '</replyAdd>';
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

    function showReplyForm(replyIdx) { // 댓글 작성 폼 보여주기
        // let replyAddForm = ""; // 댓글 작성 폼
        // replyAddForm += '<div class="card-header" style="border: none; padding-bottom: 0"> <!-- 대댓글 헤더 -->';
        // replyAddForm += '<strong style="padding-right: 5px; margin-bottom: 0">└</strong>&nbsp;';
        // replyAddForm += '</div>';
        // replyAddForm += '<div class="border-bottom" style="background: rgba(0, 0, 0, .03); border-style: hidden; padding-right: 10px">';
        // replyAddForm += '  <div class="card-body" style="padding-left: 40px;">';
        // replyAddForm += '    <td><textarea style="width: 80%; resize: none" placeholder="댓글 내용을 입력해주세요."></textarea></td>';
        // replyAddForm += '  </div>';
        // replyAddForm += '  <div style="text-align: right; padding-left: 40px;">';
        // replyAddForm += '    <span style="float: right; margin-right: 10px;"><a href="#" style="color: #007bff">작성완료</a></span>';
        // replyAddForm += '  </div>';
        // replyAddForm += '</div>';
        // document.querySelector('replyAdd').innerHTML = replyAddForm;
        document.querySelector('replyAdd'+replyIdx).style.display = 'block'; // replyAdd 태그의 style을 block으로 지정
        document.getElementById('addReply'+replyIdx).innerText = "취소하기";
        document.getElementById('addReply'+replyIdx).href = "javascript:deleteReplyForm("+ replyIdx +")";
    }

    function deleteReplyForm(replyIdx) { // 댓글 작성 폼 삭제하기
        let replyAddForm = ""; // 댓글 작성 폼
        // document.querySelector('replyAdd').innerHTML = replyAddForm;
        document.querySelector('replyAdd'+replyIdx).style.display = 'none'; // replyAdd 태그의 style을 none으로 지정
        document.getElementById('addReply'+replyIdx).innerText = "댓글달기";
        document.getElementById('addReply'+replyIdx).href = "javascript:showReplyForm("+ replyIdx +")";
    }

    function insertReReply(replyIdx) { // 대댓글 등록
        const userId = document.getElementById('userId').value;
        const username = document.getElementById('username').value;
        const replyContents = document.getElementById('reReply'+replyIdx).value; // 대댓글 textarea 번호
        const boardIdx = document.getElementById('boardIdx').value;
        const replyParent = replyIdx;

        // alert("parent:"+replyIdx);

        if (replyContents.trim() === '' || replyContents.length === 0) {
            alert('댓글 내용을 입력해주세요.');
            return;
        }
        let data = {
            userId: userId,
            username: username,
            boardIdx: boardIdx,
            replyContents: replyContents,
            replyParent: replyParent
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
                    if (resp === "insertSuccess") {
                        alert('댓글 작성이 완료되었습니다.');
                        getAllReply();
                        // document.getElementById("replyContents").value = "";
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