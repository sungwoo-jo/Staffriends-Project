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
    <div style="text-align: right; padding-right: 10px;" id="replyControl">
      <span style="float: right"><a href="#" style="color: #007bff" id="deleteReply">삭제하기</a></span>
      <span style="float: right; margin-right: 10px;"><a href="javascript:showReplyForm()" style="color: #007bff" id="addReply">댓글달기</a></span>
    </div>
  </div>
  <replyAdd></replyAdd>
  <div class="card-header" style="border: none;"> <!-- 대댓글 작성 시 추가되는 부분 시작 -->
    <h7 class="text-left" style="padding-left: 20px;"> -> 작성자: sungwoo1122</h7>
    <td><span class="card-text text-right" style="font-size: small; float: right">2023-04-23 21:50:53</span></td></tr>
  </div>
  <div class="border-bottom"  style="background: rgba(0, 0, 0, .03); border-style: hidden">
    <div class="card-body" style="padding-left: 60px;">
      <tr>
        <b style="padding-right: 5px;">sungwoo11</b><span>두 번째 답글입니다.</span>
    </div>
    <div style="text-align: right; padding-right: 10px;">
      <span style="float: right"><a href="#" style="color: #007bff">삭제하기</a></span>
      <span style="float: right; margin-right: 10px;"><a href="#" style="color: #007bff">댓글달기</a></span>
    </div>
  </div> <!-- 대댓글 작성 시 추가되는 부분 끝 -->

</div>
  </div>



</div>

<script>
  window.onload = function() {
    getAllReply();
  }

  function showReplyForm() { // 댓글 작성 폼 보여주기
    let replyAddForm = ""; // 댓글 작성 폼
    replyAddForm += '<div class="card-header" style="border: none; padding-bottom: 0"> <!-- 대댓글 헤더 -->';
    replyAddForm += '<strong style="padding-right: 5px; margin-bottom: 0">└</strong>&nbsp;';
    replyAddForm += '</div>';
    replyAddForm += '<div class="border-bottom" style="background: rgba(0, 0, 0, .03); border-style: hidden; padding-right: 10px">';
    replyAddForm += '  <div class="card-body" style="padding-left: 40px;">';
    replyAddForm += '    <td><textarea style="width: 80%; resize: none" placeholder="댓글 내용을 입력해주세요."></textarea></td>';
    replyAddForm += '  </div>';
    replyAddForm += '  <div style="text-align: right; padding-left: 40px;">';
    replyAddForm += '    <span style="float: right; margin-right: 10px;"><a href="#" style="color: #007bff">작성완료</a></span>';
    replyAddForm += '  </div>';
    replyAddForm += '</div>';
    document.querySelector('replyAdd').innerHTML = replyAddForm;
    document.getElementById('addReply').innerText = "취소하기";
    document.getElementById('addReply').href = "javascript:deleteReplyForm()";
  }

  function deleteReplyForm() { // 댓글 작성 폼 삭제하기
    let replyAddForm = ""; // 댓글 작성 폼
    document.querySelector('replyAdd').innerHTML = replyAddForm;
    document.getElementById('addReply').innerText = "댓글달기";
    document.getElementById('addReply').href = "javascript:showReplyForm()";
  }
</script>



