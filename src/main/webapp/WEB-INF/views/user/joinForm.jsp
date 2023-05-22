<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="../layout/header.jsp"%>
<title>회원가입</title>
<html>
<body>
<h2 style="text-align: center; margin-top: 30px; margin-bottom: 70px; font-family: KakaoBold;">회원가입</h2>
<section style="padding-bottom: 50px;">
<div class="container center-div">
<form id="joinFrm" method="post" class="container center-div container-size">
    <div class="form-group">
        <h5>아이디</h5><input type="text" class="form-control" placeholder="영문 대/소문자, 숫자, 언더바/하이픈 포함 7~20자" name="username" id="username" style="text-align: center" oninput="idCheck(), activateSignupBtn()">
        <span style="display: none; text-align: center; color: red; " id="invalidId">영문 대/소문자, 숫자, 언더바/하이픈 포함 7~20자로 입력해야합니다.</span>
        <span style="display: none; text-align: center; color: red; " id="duplicateId">이미 사용중인 ID입니다.</span>
        <span style="display: none; text-align: center; color: red; " id="notInputId">ID를 입력해주세요.</span>
        <span style="display: none; text-align: center; color: green; " id="validId">사용이 가능한 ID입니다.</span>
    </div>
    <div class="form-group">
        <h5>비밀번호</h5><input type="password" class="form-control" placeholder="문자/숫자 포함 8자리 이상" name="password" id="password" style="text-align: center" oninput="pwCheck()">
        <span style="display: none; text-align: center; color: red; " id="notInputPw">비밀번호를 입력해주세요.</span>
        <span style="display: none; text-align: center; color: red; " id="invalidPw">문자/숫자 포함 8자리 이상 입력해야합니다.</span>
    </div>
    <div class="form-group">
        <h5>비밀번호확인</h5><input type="password" class="form-control" placeholder="비밀번호를 한번 더 입력하세요." name="samePassword" id="samePassword" style="text-align: center" oninput="samePwCheck(), activateSignupBtn()">
        <span style="display: none; text-align: center; color: red; " id="notInputSamePw">비밀번호를 한번 더 입력해주세요.</span>
        <span style="display: none; text-align: center; color: red; " id="invalidSamePw">문자/숫자 포함 8자리 이상 입력해야합니다.</span>
        <span style="display: none; text-align: center; color: red;" id="notSamePw">비밀번호가 일치하지 않습니다.</span>
        <span style="display: none; text-align: center; color: green;" id="validSamePw">비밀번호가 일치합니다.</span>
    </div>
    <div class="form-group">
        <h5>닉네임</h5><input type="text" class="form-control" placeholder="한글, 영문 대/소문자, 숫자 포함 2~15자" name="nickName" id="nickname" style="text-align: center" oninput="nicknameCheck(), activateSignupBtn()">
        <span style="display: none; text-align: center; color: red;" id="notInputNickname">닉네임을 입력해주세요.</span>
        <span style="display: none; text-align: center; color: red;" id="invalidNickname">한글, 영문 대/소문자, 숫자 포함 2~15자로 입력해야합니다.</span>
        <span style="display: none; text-align: center; color: green;" id="validNickname">사용 가능한 닉네임입니다.</span>
    </div>
    <div class="form-group">
        <h5>이메일</h5><input type="text" class="form-control" placeholder="이메일을 입력하세요." name="email" id="email" style="text-align: center" oninput="emailCheck(), activateSignupBtn()">
        <span style="display: none; text-align: center; color: red;" id="notInputEmail">이메일을 입력해주세요.</span>
        <span style="display: none; text-align: center; color: red;" id="invalidEmail">이메일 형식이 올바르지 않습니다.</span>
        <span style="display: none; text-align: center; color: green;" id="validEmail">사용 가능한 이메일입니다.</span>
    </div>
    <div class="form-group">
        <h5>이름</h5><input type="text" class="form-control" placeholder="이름을 입력하세요" name="name" id="name" style="text-align: center" oninput="nameCheck(), activateSignupBtn()">
        <span style="display: none; text-align: center; color: red;" id="notInputName">이름을 입력해주세요.</span>
        <span style="display: none; text-align: center; color: red;" id="invalidName">이름을 올바르게 입력해주세요.</span>
        <span style="display: none; text-align: center; color: green;" id="validName">사용 가능한 이름입니다.</span>
    </div>
    <div class="form-group">
        <h5>시리얼번호</h5><input type="text" class="form-control" placeholder="시리얼번호를 입력하세요(선택)" name="serialNum" id="serialNum" style="text-align: center">
    </div>
    <div class="form-group text-center">
        <input class="btn btn-staffriends  btn-lg center-div" type="button" value="회원가입" id="joinBtn" onclick="join()" disabled>
    </div>
</form>
</div>
</section>
</body>
<%@ include file="../layout/footer.jsp"%>
</html>
