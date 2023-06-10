function editAndDelete() {
    let frm = document.getElementById("frm");

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

    document.getElementById("edit").onclick = function(event) {
        frm.action = "/board/updateForm";
        frm.submit();
    }

    document.getElementById("delete").onclick = function(event) {
        frm.action = "/board/deleteBoard";
        frm.method = "DELETE";
        frm.submit();
        alert('게시글 삭제가 완료되었습니다.');
    }
}

function showBoardDetail() {
    ClassicEditor.create( document.querySelector( '#editor' ) ) // 읽기 전용 모드
        .then(editor => {
            editor.enableReadOnlyMode('true');
        })

    document.getElementById("list").onclick = function(event) {
        history.back();
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
        history.back();
        // event.preventDefault(); // 클릭 시 결과 실행 후 대기
    }
}