<style>
    .hr-sect {
        display: flex;
        flex-basis: 100%;
        align-items: center;
        color: #111;
        font-size: 18px;
        margin: 8px 0px;
        position: relative;
    }
    .hr-sect::before,
    .hr-sect::after {
        content: "";
        flex-grow: 1;
        background: rgba(0, 0, 0, 0.35);
        height: 1px;
        font-size: 0px;
        line-height: 0px;
        margin: 0px 16px;
    }
</style>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../layout/header.jsp"%>
<title>로그인</title>
<html>
<body>
<c:set var="KAKAO_REST_API_KEY" value="69eddbebb2b07d6a316fc057c32fdbdf"/>
<%--<c:set var="KAKAO_REDIRECT_URI" value="http://localhost/user/kakao"/>--%>
<c:set var="NAVER_CLIENT_ID" value="7qqLASP70SF5B7AX2r7H"/>
<%--<c:set var="NAVER_REDIRECT_URI" value="http://localhost/user/naver"/>--%>
<c:set var="KAKAO_REDIRECT_URI" value="http://staffriends.duckdns.org/user/kakao"/>
<c:set var="NAVER_REDIRECT_URI" value="http://staffriends.duckdns.org/user/naver"/>
<h2 style="text-align: center; margin-top: 30px; margin-bottom: 70px; font-family: KakaoBold;">로그인</h2>
<section style="padding-bottom: 10px;">
<div class="container center-div">
    <form method="post" class="container center-div container-size">
        <div>
            <ul style="padding-left: 0">
                <div class="form-group" style="margin-bottom: 32px;">
                    <h5 style="text-align: left">아이디</h5><input type="text" class="form-control" placeholder="아이디를 입력하세요." name="username" id="username">
                </div>
                <div class="form-group">
                    <h5 style="text-align: left;padding-bottom: 10px;">비밀번호</h5><input type="password" class="form-control" placeholder="비밀번호를 입력하세요." name="password" id="password">
                </div>
            </ul>
            <input class="btn btn-staffriends btn-lg center-div" type="button" value="로그인" onclick="loginProc()">
            <div style="text-align: center; padding-bottom: 30px; padding-top: 10px;"><a href="javascript:findMyIdPopUp()">아이디 찾기</a> | <a href="javascript:findMyPasswordPopUp()">비밀번호 찾기</a></div>
                <div class="hr-sect">SNS 로그인</div>
                <ul style="text-align: center; padding-left: 0;">
                    <a style="margin: 0 10px;" href="https://kauth.kakao.com/oauth/authorize?client_id=${KAKAO_REST_API_KEY}&redirect_uri=${KAKAO_REDIRECT_URI}&response_type=code"><img src="/img/ico_sns_kakao.png"></a>
                    <a style="margin: 0 10px;" href="https://nid.naver.com/oauth2.0/authorize?response_type=code&client_id=${NAVER_CLIENT_ID}&redirect_uri=${NAVER_REDIRECT_URI}&state=test"><img src="/img/ico_sns_naver.png"></a>
                </ul>
            </div>
        </div>
</form>
</div>
</section>
</body>
</html>
<%@ include file="../layout/footer.jsp"%>