function editAndDelete(boardIdx) {
    let frm = document.getElementById("frm");
    // let boardIdx = document.getElementById("boardIdx").value;
    console.log(boardIdx);
    let list = document.getElementById("list");
    let editButton = document.createElement("button"); // 수정하기 버튼 생성
    editButton.type = 'button';
    editButton.id = 'edit';
    editButton.innerHTML = '수정';
    editButton.className = 'btn btn-warning';
    editButton.style = 'margin-top: 20px; margin-bottom: 20px;';
    list.insertAdjacentElement("afterend", editButton);

    let deleteButton = document.createElement("button"); // 삭제하기 버튼 생성
    deleteButton.type = 'button';
    deleteButton.id = 'delete';
    deleteButton.innerHTML = '삭제';
    deleteButton.className = 'btn btn-danger';
    deleteButton.style = 'margin-top: 20px; margin-bottom: 20px;';
    editButton.insertAdjacentElement("afterend", deleteButton);

    document.getElementById("edit").onclick = function (event) {
        location.href = "/board/updateForm/" + boardIdx;
    }

    document.getElementById("delete").onclick = function (event) {
        let form = document.createElement("form");
        form.setAttribute("charset", "UTF-8");
        form.setAttribute("method", "DELETE");
        form.setAttribute("action", "/board/deleteBoard/" + boardIdx);

        document.body.appendChild(form);
        form.submit();
    }
}

function showBoardDetail() {
    ClassicEditor.create( document.querySelector( '#editor' ) ) // 읽기 전용 모드
        .then(editor => {
            editor.enableReadOnlyMode('true');
        })

    document.getElementById("list").onclick = function(event) {
        location.href = "/boardList";
    }
}

function insertBoard() {
    document.getElementById("save").onclick = function(event) {
        let frm = document.getElementById("frm");
        frm.action = "/board/insertBoard";
        frm.submit();
        alert('글 작성이 완료되었습니다.');
    }
}

function writeEditor() {
    CKEDITOR.replace('contents', {
        filebrowserUploadUrl: '/fileUpload',
        height: '500px'
    });
}

function modifyBoard() {
    let frm = document.getElementById("frm");
    document.getElementById("successEdit").onclick = function(event) {
        let boardIdx = document.getElementById('boardIdx');
        frm.action = "/board/modifyBoard";
        frm.submit();
        alert('수정이 완료되었습니다.');
    }

    document.getElementById("list").onclick = function(event) {
        location.href = "/boardList";
    }
}