<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2023-04-13
  Time: 오후 11:00
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../layout/header.jsp"%>
<html>
<body>
<div class="card" style="margin: 0 auto; width: 55%; height: auto;">
    <h5 class="card-header">작성자: 조성우</h5>
    <div class="card-body">
        <form id="replyForm"><textarea id="contents" style="width: 100%" placeholder="내용을 입력해주세요."></textarea></form>
    </div>
    <div class="card-footer">
        <a href="#" class="btn btn-primary float-right">작성 완료</a>
    </div>
</div>
<br/>
<div class="card" style="margin: 0 auto; width: 55%; height: auto; margin-bottom:100px;">
    <h5 class="card-header">작성자: 조성우</h5>
    <div class="card-body">
        <h5 class="card-title">내용이 들어갈 부분입니다.</h5>
        <p class="card-text">작성 시간: 2023-04-13 오후 11:08:32</p>
    </div>
</div>

</body>
<%@ include file="../layout/footer.jsp"%>
</html>