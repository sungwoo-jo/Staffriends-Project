<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../layout/header.jsp"%>
<c:if test="${signIn == null}"><c:redirect url="http://http://staffriends.duckdns.org/user/needLogin"/></c:if>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>게시글 등록</title>
    <style>
      .ck-editor__editable { height: 1000px; }
      .ck-content { font-size: 12px; }
      .cke_chrome {max-width: 90%; height: auto; margin: auto; }
      .textarea {width: 100%; border: none; resize: none; height: 3.1rem;}
    </style>
</head>
<body class="center-div">

    <div class="container justify-content-center">
    <h2 style="text-align: center; margin-top: 30px; margin-bottom: 70px; font-family: KakaoBold;">게시글 등록</h2>
    <form id="frm" name="frm" method="post">
      <table style="margin-left:auto;margin-right:auto;">
        <tr>
          <td>
              <textarea class="textarea" id="title" name="title" placeholder="제목을 입력해주세요." style="font-size: 30px"></textarea>
              <hr style="margin-top: 0;"/>
          </td>
        </tr>
        <tr>
          <td colspan="2">
            <textarea class="form-control" id="contents" name="contents"></textarea>
            <script>
                writeEditor();
            </script>
          </td>
        </tr>
        <input type="hidden" value="${signIn.username}" name="username" id="username">
      </table>
    </form>
    <h5 style="text-align: center"><button class="btn btn-success" id="save" style="margin-top: 20px; margin-bottom: 20px;">글 작성 완료</button></h5>
      <script>
          insertBoard();
      </script>
    </div>

</body>
<%@ include file="../layout/footer.jsp"%>
</html>