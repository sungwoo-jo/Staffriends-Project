<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2023-04-13
  Time: 오후 11:00
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../layout/header.jsp" %>
<div class="card" style="margin: 0 auto; width: 80%; height: auto;">
  <h5 class="card-header">댓글 작성</h5>
  <div class="card-body">
    <form id="replyForm">
      <textarea id="replyContent" style="width: 100%" placeholder="내용을 입력해주세요."></textarea>
      <input type="hidden" id="creatorId" value="${signIn.username}">
      <input type="hidden" id="boardIdx" value="${board.boardIdx}">
    </form>
  </div>
  <div class="card-footer">
    <input type="button" class="btn btn-primary float-right" value="작성 완료" onclick="insertReply()">
  </div>
</div>
<br/>

<div class="card" style="margin: 0 auto; width: 80%; height: auto; margin-bottom:10px;" id="card">
  <div class="card-header">
  <h7>작성자: sungwoo11</h7>
  <span style="float: right"><a href="#">삭제하기</a></span>
  </div>

  <div class="border-bottom">
    <div class="card-body">
      <tr>
        <span>첫 번째 댓글입니다.</span>
    </div>
    <div style="text-align: right">
      <td><span class="card-text text-right" style="text-align: right">2023-04-23 21:45:53</span></td></tr>
    </div>
  </div>
</div>

<reply>123123</reply>

<script>
  window.onload = function() {
    getAllReply();
  }
</script>
