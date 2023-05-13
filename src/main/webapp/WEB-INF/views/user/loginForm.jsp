<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../layout/header.jsp"%>
<html>
<body>
<c:set var="REST_API_KEY" value="69eddbebb2b07d6a316fc057c32fdbdf"/>
<%--<c:set var="REDIRECT_URI" value="http://localhost/user/kakao"/>--%>
<c:set var="REDIRECT_URI" value="http://staffriends.duckdns.org/user/kakao"/>
<h2 style="text-align: center; margin-top: 30px; margin-bottom: 70px; font-family: KakaoBold;">로그인</h2>
<section style="padding-bottom: 50px;">
<div class="container center-div">
<form method="post" class="container center-div container-size">
    <div class="form-group" style="margin-bottom: 32px;">
        <h5 style="text-align: left">아이디</h5><input type="text" class="form-control" placeholder="아이디를 입력하세요." name="username" id="username">
    </div>
    <div class="form-group">
        <h5 style="text-align: left">비밀번호</h5><input type="password" class="form-control" placeholder="비밀번호를 입력하세요." name="password" id="password">
    </div>
    <div style="text-align: center; padding-bottom: 20px;"><a href="javascript:findMyIdPopUp()">아이디 찾기</a> | <a href="javascript:findMyPasswordPopUp()">비밀번호 찾기</a></div>
    <input class="btn btn-staffriends btn-lg center-div" type="button" value="로그인" onclick="loginProc()">
    <a href="https://kauth.kakao.com/oauth/authorize?client_id=${REST_API_KEY}&redirect_uri=${REDIRECT_URI}&response_type=code"><img src="/img/kakao_login_medium_wide.png" class="btn-block" style="margin-top: 5px;height: 50px"></a>
</form>
</div>
</section>
</body>
</html>
<%@ include file="../layout/footer.jsp"%>