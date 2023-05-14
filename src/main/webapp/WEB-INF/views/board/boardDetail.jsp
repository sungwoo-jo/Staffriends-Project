<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../layout/header.jsp"%>
<c:if test="${signIn == null}"><c:redirect url="http://http://staffriends.duckdns.org/user/needLogin"/></c:if>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>board</title>
    <style>
        .ck.ck-editor {max-width: 90%; height: auto; margin: 0 auto;}
    </style>
</head>
<body class="center-div">
<div style="text-align:center">
    <div class="container">
        <div class="container justify-content-center" style="max-width: 80%; min-width: 370px; max-height: 80%">
            <h2 style="text-align: center; margin-top: 30px; margin-bottom: 20px; font-family: KakaoBold;">${board.title}</h2>
            <form id="frm" method="post">
                <table style="margin-left:auto;margin-right:auto; margin: 0 auto">
                    <tbody>
                    <tr>
                        <th scope="row" style="min-width: 50px; max-width: 50px;text-align: center; ">글 번호</th>
                        <td>${board.boardIdx}</td>
                        <th scope="row" style="min-width: 50px; max-width: 50px;text-align: center; ">작성자</th>
                        <td>${board.creatorId}</td>
                    </tr>
                    <tr>
                        <th scope="row" style="min-width: 50px; max-width: 50px;text-align: center; ">조회수</th>
                        <td>${board.hitCnt}</td>
                        <th scope="row" style="min-width: 50px; max-width: 50px;text-align: center; ">작성일</th>
                        <td>${board.createdDateTime}</td>
                    </tr>
                    <tr>
                        <td colspan="4" class="view_text" style="max-width: 30%; height: auto">
                            <textarea title="내용" id="editor" name="contents" style="text-align: center; ">${board.contents}</textarea>
                        </td>
                    </tr>
                    </tbody>
                </table>
                <input type="hidden" name="boardIdx" value="${board.boardIdx}">
            </form>
            <input type="button" id="list" value="목록으로" style="margin-top: 20px; margin-bottom: 20px;">
        </div>
    </div>
    <script src="/js/ckeditor.js"></script>
    <script>
        ClassicEditor.create( document.querySelector( '#editor' ) ) // 읽기 전용 모드
            .then(editor => {
                editor.enableReadOnlyMode('true');
            })

        document.getElementById("list").onclick = function(event) {
            history.back();
        }
    </script>
    <c:if test="${signIn.username == board.creatorId}"> <%-- 수정, 삭제 가능 --%>
        <script>
            list = document.getElementById("list");
            editButton = document.createElement("input"); // 수정하기 버튼 생성
            editButton.type = 'button';
            editButton.id = 'edit';
            editButton.value = '수정하기';
            list.insertAdjacentElement("afterend", editButton);

            deleteButton = document.createElement("input"); // 삭제하기 버튼 생성
            deleteButton.type = 'button';
            deleteButton.id = 'delete';
            deleteButton.value = '삭제하기';
            editButton.insertAdjacentElement("afterend", deleteButton);

            document.getElementById("edit").onclick = function(event) {
                frm.action = "/board/updateForm";
                frm.submit();
            }

            document.getElementById("delete").onclick = function(event) {
                frm.action = "/board/deleteBoard";
                frm.submit();
                alert('게시글 삭제가 완료되었습니다.');
            }
        </script>
    </c:if>
    <script src="/js/board.js"></script>
</div>

<%@ include file="../reply/reply.jsp" %>
</body>
<%@ include file="../layout/footer.jsp"%>
</html>
