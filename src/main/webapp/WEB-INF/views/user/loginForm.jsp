<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../layout/header.jsp"%>
<title>로그인</title>
<html>
<body>
<c:set var="KAKAO_REST_API_KEY" value="69eddbebb2b07d6a316fc057c32fdbdf"/>
<c:set var="KAKAO_REDIRECT_URI" value="http://staffriends.duckdns.org/user/kakao"/>
<c:set var="NAVER_CLIEND_ID" value="7qqLASP70SF5B7AX2r7H"/>
<c:set var="NAVER_REDIRECT_URI" value="http://localhost/user/naver"/>
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
    <a href="https://kauth.kakao.com/oauth/authorize?client_id=${KAKAO_REST_API_KEY}&redirect_uri=${KAKAO_REDIRECT_URI}&response_type=code"><img src="/img/kakao_login_medium.png" style="margin-top: 5px;height: 50px; width: 49%"></a>
    <a href="https://nid.naver.com/oauth2.0/authorize?response_type=code&cliend_id=${NAVER_CLIEND_ID}&redirect_uri=${NAVER_REDIRECT_URI}&state="><img src="/img/naver_login_small.png" style="margin-top: 5px;height: 50px;width: 49%"></a>
</form>
</div>
</section>
</body>
</html>
<%@ include file="../layout/footer.jsp"%>