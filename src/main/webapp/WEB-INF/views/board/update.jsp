<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../layout/header.jsp"%>
<%--<c:if test="${signIn == null}"><c:redirect url="http://staffriends.duckdns.org/user/needLogin"/></c:if>--%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>board</title>
    <style>
      .ck.ck-editor {max-width: 90%; height: auto; margin: 0 auto;}
      .textarea {width: 100%; border: none; resize: none; height: 3.1rem;}
    </style>
</head>
<body class="center-div">
<div style="text-align:center">
<div class="container">
  <div class="container justify-content-center">
      bgno: <c:out value="${bgno}"/>
    <h2 style="text-align: center; margin-top: 30px; margin-bottom: 20px; font-family: KakaoBold;">게시글 수정</h2>
  <form id="frm" method="post">
    <table style="margin-left:auto;margin-right:auto; margin: 0 auto">
    <tbody>
      <tr>
          <td>
              <textarea class="textarea" id="title" name="title" placeholder="제목을 입력해주세요." style="font-size: 30px">${boardVo.title}</textarea>
              <hr style="margin-top: 0;"/>
          </td>
      </tr>
      <tr>
          <td colspan="4" class="view_text" style="max-width: 30%; height: auto">
            <textarea title="내용" id="contents" name="contents" style="text-align: center; ">${boardVo.contents}</textarea>
            <script>
                writeEditor();
            </script>
          </td>
      </tr>
    </tbody>
  </table>
  <input type="hidden" id="boardIdx" name="boardIdx" value="${boardVo.boardIdx}">
  <input type="hidden" id="bgno" name="bgno" value="${bgno}">
  </form>
    <div class="btn-group" role="group" aria-label="Basic mixed styles example">
        <button type="button" class="btn btn-warning" id="list" style="margin-top: 20px; margin-bottom: 20px;">되돌아가기</button>
        <button type="button" class="btn btn-success" id="successEdit" style="margin-top: 20px; margin-bottom: 20px;">수정완료</button>
    </div>
    <script>
        modifyBoard();
    </script>
  </div>
</div>
</div>
</body>
<%@ include file="../layout/footer.jsp"%>