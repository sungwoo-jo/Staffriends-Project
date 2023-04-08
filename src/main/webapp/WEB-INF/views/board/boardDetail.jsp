<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../layout/header.jsp"%>
<c:if test="${signIn == null}"><c:redirect url="http://localhost:8080/user/needLogin"/></c:if>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>board</title>

</head>
<body>
<div class="container">
  <div class="container justify-content-center">
    <h2 style="text-align: center; margin-top: 30px; margin-bottom: 70px; font-family: KakaoBold;">게시글 보기</h2>
  <form id="frm" method="post">
    <table style="margin-left:auto;margin-right:auto;">
    <tbody>
      <tr>
        <th scope="row" style="min-width: 50px; max-width: 50px;">글 번호</th>
        <td>${board.boardIdx}</td>
        <th scope="row" style="min-width: 50px; max-width: 50px;">조회수</th>
        <td>${board.hitCnt}</td>
      </tr>
      <tr>
        <th scope="row" style="min-width: 50px; max-width: 50px;">작성자</th>
        <td>${board.creatorId}</td>
        <th scope="row" style="min-width: 50px; max-width: 50px;">작성일</th>
        <td>${board.createdDateTime}</td>
      </tr>
      <tr>
        <th scope="row" style="min-width: 50px; max-width: 50px;">제목</th>
          <td colspan="3">
            <input type="text" id="title" name="title" value="${board.title}"/>
          </td>
      </tr>
      <tr>
          <td colspan="4" class="view_text">
            <textarea title="내용" id="editor" name="contents">${board.contents}</textarea>
          </td>
      </tr>
    </tbody>
  </table>
  <input type="hidden" name="boardIdx" value="${board.boardIdx}">
  </form>
    <input type="button" id="list" value="목록으로">
    <input type="button" id="edit" value="수정하기">
    <input type="button" id="delete" value="삭제하기">
  </div>
  <script src="/js/board.js"></script>
  <script src="/js/ckeditor.js"></script>
  <script>
    ClassicEditor.create( document.querySelector( '#editor' ) );
  </script>
</div>
</body>
<%@ include file="../layout/footer.jsp"%>
</html>
