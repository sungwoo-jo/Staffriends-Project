<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../layout/header.jsp"%>
<c:if test="${signIn == null}"><c:redirect url="http://localhost:8080/user/needLogin"/></c:if>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>게시글 등록</title>
    <style>
      .ck-editor__editable { height: 1000px; }
      .ck-content { font-size: 12px; }
      .cke_chrome {max-width: 90%; height: auto; margin: auto;}
    </style>
</head>
<body class="center-div">

    <div class="container justify-content-center">
    <h2 style="text-align: center; margin-top: 30px; margin-bottom: 70px; font-family: KakaoBold;">게시글 등록</h2>
    <form id="frm" name="frm" method="post">
      <table style="margin-left:auto;margin-right:auto;">
        <tr>
          <td>제목
          <input type="text" id="title" name="title"></td>
        </tr>
        <tr>
          <td colspan="2">내용
            <textarea class="form-control" id="contents" name="contents"></textarea>
            <script type="text/javascript">
              CKEDITOR.replace('contents', {
                        filebrowserUploadUrl: '/fileUpload'
                      });
            </script>
          </td>
        </tr>
        <input type="hidden" value="${signIn.username}" name="username" id="username">
      </table>
    </form>
    <button class="btn btn-success" id="save">저장</button>
    <script src="/js/ckeditor.js"></script>
      <script>
        document.getElementById("save").onclick = function(event) {
          frm.action = "/board/insertBoard";
          frm.submit();
        }
      </script>
    </div>

</body>
<%@ include file="../layout/footer.jsp"%>
</html>