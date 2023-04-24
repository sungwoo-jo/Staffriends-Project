<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2023-04-13
  Time: 오후 11:00
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../layout/header.jsp" %>
<div class="card" style="margin: 0 auto; width: 90%; height: auto;">
  <h5 class="card-header">댓글 작성</h5>
  <div class="card-body">
    <form id="replyForm">
      <textarea id="replyContent" style="width: 100%; resize: none" placeholder="내용을 입력해주세요."></textarea>
      <input type="hidden" id="creatorId" value="${signIn.username}">
      <input type="hidden" id="boardIdx" value="${board.boardIdx}">
    </form>
  </div>
  <div class="card-footer">
    <input type="button" class="btn btn-primary float-right" value="작성 완료" onclick="insertReply()">
  </div>
</div>
<br/>

<div class="card" style="margin: 0 auto; width: 90%; height: auto; margin-bottom:10px;" id="card">
  <div class="card-header">
  <h7>작성자: sungwoo11</h7>
    <td><span class="card-text text-right" style="font-size: small; float: right">2023-04-23 21:45:53</span></td></tr>
  </div>
  <div class="border-bottom">
    <div class="card-body">
      <tr>
        <span>첫 번째 댓글입니다.</span>
    </div>
    <div style="text-align: right; padding-right: 10px;">
      <span style="float: right"><a href="#" style="color: #007bff">삭제하기</a></span>
    </div>
  </div>
</div>
<div class="card" style="margin: 0 auto; width: 90%; height: auto; margin-bottom:10px; padding-right: 0;" id="card">
  <div class="card-header">
    <h7>작성자: sungwoo11</h7>
    <td><span class="card-text text-right" style="font-size: small; float: right">2023-04-23 21:50:53</span></td></tr>
  </div>
  <div class="border-bottom" style="border-left: none">
    <div class="card-body">
      <tr>
        <span>두 번째 댓글입니다.</span>
    </div>
    <div style="text-align: right; padding-right: 10px;">
      <span style="float: right"><a href="#" style="color: #007bff">삭제하기</a></span>
      <span style="float: right; margin-right: 10px;"><a href="#" style="color: #007bff">댓글달기</a></span>
    </div>

  </div>

  <div class="card-header" style="border: none;"> <!-- 대댓글 작성 시 추가되는 부분 -->
    <strong style="padding-right: 5px;">└</strong>&nbsp;<h7 class="text-left">작성자: sungwoo1122</h7>

<%--    <span style="float: right"><a href="#">삭제하기</a></span>--%>
<%--    <span style="float: right; margin-right: 10px;"><a href="#">댓글달기</a></span>--%>
    <td><span class="card-text text-right" style="font-size: small; float: right">2023-04-23 21:50:53</span></td></tr>
  </div>
  <div class="border-bottom"  style="background: rgba(0, 0, 0, .03); border-style: hidden">
    <div class="card-body" style="padding-left: 40px;">
      <tr>
        <b style="padding-right: 5px;">sungwoo11</b><span>두 번째 답글입니다.</span>
    </div>
    <div style="text-align: right; padding-right: 10px;">
      <span style="float: right"><a href="#" style="color: #007bff">삭제하기</a></span>
      <span style="float: right; margin-right: 10px;"><a href="#" style="color: #007bff">댓글달기</a></span>
    </div>
  </div>
</div>

<script>
  window.onload = function() {
    getAllReply();
  }
</script>
