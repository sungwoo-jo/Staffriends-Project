document.getElementById("list").onclick = function(event) {
    location.href = "/board";
    // event.preventDefault(); // 클릭 시 결과 실행 후 대기
}

document.getElementById("edit").onclick = function(event) {
    frm.action = "updateBoard";
    frm.submit();
}

document.getElementById("delete").onclick = function(event) {
    frm.action = "deleteBoard";
    frm.submit();
}