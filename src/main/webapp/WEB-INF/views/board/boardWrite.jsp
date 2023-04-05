<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../layout/header.jsp"%>
<c:if test="${signIn == null}"><c:redirect url="http://localhost:8080/user/needLogin"/></c:if>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>board</title>
    <style>
      .ck-editor__editable { height: 400px; }
      .ck-content { font-size: 12px; }
    </style>
</head>
<body>
  <div class="container">
    <div class="container justify-content-center">
    <h2>게시판 등록</h2>
    <form id="frm" name="frm" method="post" action="/board/insertBoard">
      <table>
        <tr>
          <td>제목</td>
          <td><input type="text" id="title" name="title"></td>
        </tr>
        <tr>
          <td colspan="2">내용
            <input type="text" name="contents" id="editor" style="width: 100%; margin: 0 auto;"></input>
          </td>
        </tr>
      </table>
      <input type="submit" id="submit" value="저장">
    </form>
    <script src="/js/ckeditor.js"></script>
    <script>
      ClassicEditor.create( document.querySelector( '#editor' ) );
    </script>
    </div>
  </div>
</body>
<%@ include file="../layout/footer.jsp"%>
</html>