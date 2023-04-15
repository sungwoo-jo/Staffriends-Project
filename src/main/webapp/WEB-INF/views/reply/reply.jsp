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
<div class="card" style="margin: 0 auto; width: 80%; height: auto;">
    <h5 class="card-header">댓글 작성</h5>
    <div class="card-body">
        <form id="replyForm"><textarea id="contents" style="width: 100%" placeholder="내용을 입력해주세요."></textarea></form>
    </div>
    <div class="card-footer">
        <a href="#" class="btn btn-primary float-right">작성 완료</a>
    </div>
</div>
<br/>
<div class="card" style="margin: 0 auto; width: 80%; height: auto; margin-bottom:100px;">
    <h7 class="card-header">작성자: 조성우</h7>
    <div class="border-bottom">
        <div class="card-body">
            <tr><td><h6 class="card-title">내용이 들어갈 부분입니다.</h6></td>
        </div>
        <div style="text-align: right">
            <td><span class="card-text text-right" style="text-align: right">2023-04-13 오후 11:08:32</span></td></tr>
        </div>
    </div>
    <h7 class="card-header">작성자: 조성우</h7>
    <div class="border-bottom">
        <div class="card-body">
            <tr><td><h6 class="card-title">내용이 들어갈 부분입니다.</h6></td>
        </div>
        <div style="text-align: right">
            <td><span class="card-text text-right" style="text-align: right">2023-04-13 오후 11:08:32</span></td></tr>
        </div>
    </div>
</div>

</body>
<%@ include file="../layout/footer.jsp"%>
</html>