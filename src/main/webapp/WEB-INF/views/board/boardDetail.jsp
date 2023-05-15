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
            <div class="btn-group" role="group" aria-label="Basic mixed styles example">
            <button type="button" class="btn btn-success" id="list" style="margin-top: 20px; margin-bottom: 20px;">목록</button>
            </div>
        </div>
    </div>

    <script>
        showBoardDetail();
        <c:if test="${signIn.username == board.creatorId}"> <%-- 수정, 삭제 가능 --%>
        editAndDelete();
        </c:if>
    </script>


</div>

<%@ include file="../reply/reply.jsp" %>
</body>
<%@ include file="../layout/footer.jsp"%>
</html>
