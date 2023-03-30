<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>board</title>
</head>
<body>
  <div class="container">
    <h2>게시판 등록</h2>
    <form id="frm" name="frm" method="post" action="/board/insertBoard">
      <table>
        <tr>
          <td>제목</td>
          <td><input type="text" id="title" name="title"></td>
        </tr>
        <tr>
          <td colspan="2">
            <textarea id="contents" name="contents"></textarea>
          </td>
        </tr>
      </table>
      <input type="submit" id="submit" value="저장" class="btn">
    </form>
  </div>
</body>
</html>