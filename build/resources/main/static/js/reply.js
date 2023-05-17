function insertReply() { // 댓글 등록 메서드
    const username = document.getElementById('username').value;
    const replyContents = document.getElementById('replyContents').value;
    const boardIdx = document.getElementById('boardIdx').value;

    if (replyContents.trim() === '' || replyContents.length === 0) {
        alert('댓글 내용을 입력해주세요.');
        return;
    }
    let data = {
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
                if (resp === "insertSuccess") { // 결과로 받은 문자열이 insertSuccess면 댓글 작성 성공
                    alert('댓글 작성이 완료되었습니다.'); // 작성 완료 알림창 띄우기
                    getAllReply(); // 전체 댓글 재조회
                    document.getElementById("replyContents").value = ""; // 댓글창 비우기
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
    const username = document.getElementById('username').value;

    let data = boardIdx;
    let xhr = new XMLHttpRequest();
    xhr.open("POST", "/reply/getAllReply");
    xhr.onload = function () {
        if (xhr.status === 200 || xhr.status === 201) {
            let resp = xhr.responseText;
            if (resp.status === 500) {
                alert('에러가 발생했습니다.');
            } else {
                let replyForm = "";
                let parseData = JSON.parse(resp);
                for(let i=0; i<parseData.length; i++) {
                    replyForm += '<div class="card" style="margin: 0 auto; width: 80%; height: auto; margin-bottom:10px; left: ' + parseData[i].replyDepth * 10 + 'px;" id="card">';
                    replyForm +=    '<div class="card-header">';
                    replyForm +=        '<h7>'+'작성자: '+parseData[i].username+'</h7>';
                    replyForm +=        '<td><span class="card-text text-right" style="font-size: small; float: right">'+parseData[i].createdDatetime+'</span></td>';
                    replyForm +=    '</div>';
                    replyForm +=    '<div class="border-bottom">';
                    replyForm +=        '<div class="card-body">';
                    replyForm +=            '<tr><td><h6 class="card-title">'+ parseData[i].replyContents +'</h6></td>';
                    replyForm +=        '</div>';
                    replyForm +=    '<div style="text-align: right">';
                    if (username === parseData[i].username) { // 댓글 작성자인 경우 삭제하기 버튼 생성
                        replyForm +=    '<span style="float: right"><a style="color: #007bff; margin-right: 10px;" href="javascript:deleteReply('+parseData[i].replyIdx+');">삭제하기</a></span>';
                    }
                    // 대댓글 작성 시 동적 태그 추가
                    replyForm +=        '<span style="float: right;"><a href="javascript:showReplyForm('+ parseData[i].replyIdx +');" style="color: #007bff; margin-right: 10px;" id="addReply'+ parseData[i].replyIdx +'">댓글달기</a></span>';
                    replyForm +=    '</div>';
                    replyForm += '</div>';
                    replyForm += '<replyAdd'+ parseData[i].replyIdx +' style="display: none">'; <!-- 댓글작성 누르면 나타나는 부분 -->
                    replyForm +=    '<div class="card-header" style="border: none; padding-bottom: 0; "> <!-- 대댓글 헤더 -->';
                    replyForm +=        '<strong style="padding-right: 5px; margin-bottom: 0">└</strong>&nbsp;';
                    replyForm +=    '</div>';
                    replyForm += '<div class="border-bottom" style="background: rgba(0, 0, 0, .03); border-style: hidden; padding-right: 10px">';
                    replyForm += '  <div class="card-body" style="padding-left: 40px;">';
                    replyForm += '    <td><textarea style="width: 80%; resize: none" id="reReply'+ parseData[i].replyIdx +'" placeholder="댓글 내용을 입력해주세요."></textarea></td>';
                    replyForm += '  </div>';
                    replyForm += '  <div style="text-align: right; padding-left: 40px;">';
                    replyForm += '    <span style="float: right; margin-right: 10px;"><a href="javascript:insertReReply('+ parseData[i].replyIdx +')" style="color: #007bff">작성완료</a></span>';
                    replyForm += '  </div>';
                    replyForm += '</div>';
                    replyForm += '</replyAdd>';
                    replyForm += '</div>';
                }
                document.querySelector("reply").innerHTML = replyForm; // html의 reply 태그에 replyForm 내용을 동적으로 추가
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
    let boardIdx = document.getElementById('boardIdx').value;
    let data = {
        replyIdx: replyIdx,
        boardIdx: boardIdx
    };
    let xhr = new XMLHttpRequest();
    xhr.open("POST", "/reply/deleteReply");
    xhr.setRequestHeader("Content-Type", "application/json; charset=utf-8");
    xhr.onload = function () {
        if (xhr.status === 200 || xhr.status === 201) {
            let resp = xhr.responseText;
            if (resp.status === 500) {
                alert('에러가 발생했습니다.');
            } else {
                if (resp === "deleteSuccess") { // 결과로 받은 문자열이 deleteSuccess면 댓글 작성 성공
                    alert('댓글이 삭제되었습니다.');
                    getAllReply(); // 전체 댓글 재조회
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
    xhr.send(JSON.stringify(data));
}

function showReplyForm(replyIdx) { // 댓글 작성 폼 표시 메서드
    document.querySelector('replyAdd'+replyIdx).style.display = 'block'; // replyAdd 태그의 style을 block으로 지정
    document.getElementById('addReply'+replyIdx).innerText = "취소하기"; // 버튼의 글자를 '취소하기'로 변경
    document.getElementById('addReply'+replyIdx).href = "javascript:hideReplyForm("+ replyIdx +")"; // hideReplyForm 메서드를 링크
}

function hideReplyForm(replyIdx) { // 댓글 작성 폼 숨김 메서드
    document.querySelector('replyAdd'+replyIdx).style.display = 'none'; // replyAdd 태그의 style을 none으로 지정
    document.getElementById('addReply'+replyIdx).innerText = "댓글달기"; // 버튼의 글자를 '댓글달기'로 변경
    document.getElementById('addReply'+replyIdx).href = "javascript:showReplyForm("+ replyIdx +")"; // showReplyForm 메서드를 링크
}

function insertReReply(replyIdx) { // 대댓글 등록 메서드
    const username = document.getElementById('username').value;
    const replyContents = document.getElementById('reReply'+replyIdx).value; // 대댓글 textarea 번호
    const boardIdx = document.getElementById('boardIdx').value;
    const replyParent = replyIdx; // 부모 댓글의 번호도 같이 전송

    if (replyContents.trim() === '' || replyContents.length === 0) {
        alert('댓글 내용을 입력해주세요.');
        return;
    }
    let data = {
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
                if (resp === "insertSuccess") { // 결과로 받은 문자열이 insertSuccess면 댓글 작성 성공
                    alert('댓글 작성이 완료되었습니다.');
                    getAllReply(); // 전체 댓글 재조회
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