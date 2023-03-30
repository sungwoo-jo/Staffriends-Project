<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>board</title>
</head>
<body>
  <h2>게시판 상세 화면</h2>
  <form id="frm" method="post">
  <table>
    <tbody>
      <tr>
        <th scope="row">글 번호</th>
        <td>${board.boardIdx}</td>
        <th scope="row">조회수</th>
        <td>${board.hitCnt}</td>
      </tr>
      <tr>
        <th scope="row">작성자</th>
        <td>${board.creatorId}</td>
        <th scope="row">작성일</th>
        <td>${board.createdDateTime}</td>
      </tr>
      <tr>
        <th scope="row">제목</th>
          <td colspan="3">
            <input type="text" id="title" name="title" value="${board.title}"/>
          </td>
      </tr>
      <tr>
        <th scope="row">내용</th>
          <td colspan="4" class="view_text">
            <textarea title="내용" id="contents" name="contents">${board.contents}</textarea>
          </td>
      </tr>
    </tbody>
  </table>
  <input type="hidden" name="boardIdx" value="${board.boardIdx}">
  </form>
  <input type="button" id="list" value="목록으로">
  <input type="button" id="edit" value="수정하기">
  <input type="button" id="delete" value="삭제하기">

  <script src="/js/board.js"></script>
</body>
</html>