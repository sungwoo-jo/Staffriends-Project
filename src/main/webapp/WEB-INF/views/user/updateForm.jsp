<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2023-04-02
  Time: 오전 2:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../layout/header.jsp"%>
<c:if test="${signIn == null}"><c:redirect url="http://localhost/user/needLogin"/></c:if>
<%--<c:if test="${signIn == null}"><c:redirect url="http://staffriends.duckdns.org/user/needLogin"/></c:if>--%>
<html>
<head>
    <title>회원정보수정</title>
</head>
<body>
<h2 style="text-align: center; margin-top: 30px; margin-bottom: 70px; font-family: KakaoBold;">회원정보수정</h2>
<section style="padding-bottom: 50px;">
    <div class="container center-div">
<form method="post" class="container center-div container-size">
    <input type="hidden" id="id" value="${signIn.id}">
    <div class="form-group">
        <h5>아이디</h5><input type="text" name="username" class="form-control" disabled style="text-align: center" value="${signIn.username}"><p/>
    </div>
    <c:if test="${empty signIn.oauth}"> <%-- 일반 유저는 비밀번호 수정이 가능 --%>
    <div class="form-group">
        <h5>비밀번호</h5><input type="password" class="form-control" placeholder="문자/숫자 포함 8자리 이상" name="password" id="password" style="text-align: center" oninput="pwCheck()">
        <span style="display: none; text-align: center; color: red; " id="notInputPw">비밀번호를 입력해주세요.</span>
        <span style="display: none; text-align: center; color: red; " id="invalidPw">문자/숫자 포함 8자리 이상 입력해야합니다.</span>
    </div>
    <div class="form-group">
        <h5>비밀번호확인</h5><input type="password" class="form-control" placeholder="비밀번호를 한번 더 입력하세요." name="samePassword" id="samePassword" style="text-align: center" oninput="samePwCheck()">
        <span style="display: none; text-align: center; color: red; " id="notInputSamePw">비밀번호를 한번 더 입력해주세요.</span>
        <span style="display: none; text-align: center; color: red; " id="invalidSamePw">문자/숫자 포함 8자리 이상 입력해야합니다.</span>
        <span style="display: none; text-align: center; color: red;" id="notSamePw">비밀번호가 일치하지 않습니다.</span>
        <span style="display: none; text-align: center; color: green;" id="validSamePw">비밀번호가 일치합니다.</span>
    </div>
    </c:if>
    <div class="form-group">
        <h5>닉네임</h5><input type="text" class="form-control" placeholder="한글, 영문 대/소문자, 숫자 포함 2~15자" name="nickName" id="nickname" style="text-align: center" value="${signIn.nickname}" oninput="nicknameCheck()">
        <span style="display: none; text-align: center; color: red;" id="notInputNickname">닉네임을 입력해주세요.</span>
        <span style="display: none; text-align: center; color: red;" id="invalidNickname">한글, 영문 대/소문자, 숫자 포함 2~15자로 입력해야합니다.</span>
        <span style="display: none; text-align: center; color: green;" id="validNickname">사용 가능한 닉네임입니다.</span>
    </div>
    <div class="form-group">
        <h5>이메일</h5><input type="text" class="form-control" placeholder="이메일을 입력하세요." name="email" id="email" style="text-align: center" value="${signIn.email}" oninput="emailCheck()">
        <span style="display: none; text-align: center; color: red;" id="notInputEmail">이메일을 입력해주세요.</span>
        <span style="display: none; text-align: center; color: red;" id="invalidEmail">이메일 형식이 올바르지 않습니다.</span>
        <span style="display: none; text-align: center; color: green;" id="validEmail">사용 가능한 이메일입니다.</span>
    </div>
    <div class="form-group">
        <h5>이름</h5><input type="text" name="name" class="form-control" disabled style="text-align: center" value="${signIn.name}"><p/>
    </div>
    <div class="form-group">
        <h5>시리얼번호</h5><input type="text" class="form-control" placeholder="시리얼번호를 입력하세요." name="serialNum" id="serialNum" value="${signIn.serialNum}" style="text-align: center">
    </div>
    <div class="form-group text-center">
        <input class="btn btn-staffriends btn-lg center-div" type="button" value="정보수정" id="updateBtn" onclick="updateInfo()">
    </div>
</form>
    </div>
</section>

<script>
    window.onload = function () { // 페이지 진입 시 모든 정보들을 체크
        pwCheck();
        samePwCheck();
        nicknameCheck();
        emailCheck();
    }
</script>
</body>
<%@ include file="../layout/footer.jsp"%>
</html>