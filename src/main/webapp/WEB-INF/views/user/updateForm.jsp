<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2023-04-02
  Time: 오전 2:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../layout/header.jsp"%>
<c:if test="${signIn == null}"><c:redirect url="http://localhost:8080/user/needLogin"/></c:if>
<html>
<head>
    <title>정보수정</title>
</head>
<body>
<h2 style="text-align: center; margin-top: 30px; margin-bottom: 70px; font-family: KakaoBold;">정보수정</h2>
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
        <h5>시리얼번호</h5><input type="text" class="form-control" placeholder="시리얼번호를 입력하세요." name="serialNum" id="serialNum" value="${signIn.serialNum}" style="text-align: center">
    </div>
    <div class="form-group text-center">
        <input class="btn btn-staffriends btn-lg center-div" type="button" value="정보수정" id="updateBtn" onclick="updateInfo()">
    </div>
</form>
    </div>
</section>

<script>
    let validPassword = false;
    let validSamePassword = false;
    let validNickname = false;
    let validEmail = false;
    function pwCheck() { // 비밀번호 체크
        let password = document.getElementById('password').value; // password 값을 담아줌
        let passwordCheck = /(?=.*\d)(?=.*[a-zA-ZS]).{8,}/; // 비밀번호의 정규표현식
        if (password.trim() === '') { // 입력값이 없는 경우
            document.getElementById("notInputPw").style.display = "block"; // 비밀번호를 입력하라는 메시지를 block으로 표시해 화면에 띄워지게 한다.
            document.getElementById("invalidPw").style.display = "none";
            document.getElementById("password").style.backgroundColor="#FFCECE";
            validPassword = false;
        } else if (passwordCheck.test(password) === false || password.length > 128) { // 양식에 맞지 않고 길이 초과 시
            document.getElementById("notInputPw").style.display = "none";
            document.getElementById("invalidPw").style.display = "block"; // 양식에 맞지 않는다는 메시지를 block으로 표시해 화면에 띄워지게 한다.
            document.getElementById("password").style.backgroundColor="#FFCECE";
            validPassword = false;
        } else { // 사용 가능한 비밀번호
            document.getElementById("notInputPw").style.display = "none";
            document.getElementById("invalidPw").style.display = "none";
            document.getElementById("password").style.backgroundColor="#FFFFFF"; // 사용 가능한 경우 다른효과 없이 흰색 배경으로 마무리
            validPassword = true;
        }
    }

    function samePwCheck() { // 비밀번호 확인 체크
        let password = document.getElementById('password').value; // 원래 비밀번호 값을 담아줌
        let passwordCheck = /(?=.*\d)(?=.*[a-zA-ZS]).{8,}/; // 비밀번호의 정규표현식
        let samePassword = document.getElementById('samePassword').value; // 비밀번호 확인 값을 담아줌
        if (samePassword.trim() === '') { // 입력값이 없는 경우
            document.getElementById("notInputSamePw").style.display = "block"; // 비밀번호를 한번 더 입력하라는 메시지를 block으로 표시해 화면에 띄워지게 한다.
            document.getElementById("invalidSamePw").style.display = "none";
            document.getElementById("notSamePw").style.display = "none";
            document.getElementById("validSamePw").style.display = "none";
            document.getElementById("samePassword").style.backgroundColor="#FFCECE";
            validSamePassword = false;
        } else if (passwordCheck.test(samePassword) === false || password.length > 128) { // 양식에 맞지 않고 길이 초과 시
            document.getElementById("notInputSamePw").style.display = "none";
            document.getElementById("invalidSamePw").style.display = "block"; // 양식에 맞지 않는다는 메시지를 block으로 표시해 화면에 띄워지게 한다.
            document.getElementById("notSamePw").style.display = "none";
            document.getElementById("validSamePw").style.display = "none";
            document.getElementById("samePassword").style.backgroundColor="#FFCECE";
            validSamePassword = false;
        } else if (password !== samePassword) { // 일치하지 않는 경우
            document.getElementById("notInputSamePw").style.display = "none";
            document.getElementById("invalidSamePw").style.display = "none";
            document.getElementById("notSamePw").style.display = "block"; // 비밀번호가 같지 않다는 메시지를 block으로 표시해 화면에 띄워지게 한다.
            document.getElementById("validSamePw").style.display = "none";
            document.getElementById("samePassword").style.backgroundColor="#FFCECE";
            validSamePassword = false;
        } else { // 사용 가능한 비밀번호
            document.getElementById("notInputSamePw").style.display = "none";
            document.getElementById("invalidSamePw").style.display = "none";
            document.getElementById("notSamePw").style.display = "none";
            document.getElementById("validSamePw").style.display = "block"; // 비밀번호가 일치한다는 메시지를 block으로 표시해 화면에 띄워지게 한다.
            document.getElementById("samePassword").style.backgroundColor="#B0F6AC";
            validSamePassword = true;
        }
    }

    function nicknameCheck() { // 닉네임 체크
        let nickname = document.getElementById('nickname').value; // nickname 값을 담아줌
        let nicknameCheck = /^[가-힇a-zA-Z0-9]{2,15}$/; // 닉네임의 정규표현식
        if (nickname.trim() === '') { // 입력값이 없는 경우
            document.getElementById("notInputNickname").style.display = "block"; // 비밀번호를 입력하라는 메시지를 block으로 표시해 화면에 띄워지게 한다.
            document.getElementById("invalidNickname").style.display = "none";
            document.getElementById("nickname").style.backgroundColor="#FFCECE";
            validNickname = false;
        } else if (nicknameCheck.test(nickname) === false || nickname.length > 15) { // 양식에 맞지 않고 길이 초과 시
            document.getElementById("notInputNickname").style.display = "none";
            document.getElementById("invalidNickname").style.display = "block"; // 양식에 맞지 않는다는 메시지를 block으로 표시해 화면에 띄워지게 한다.
            document.getElementById("nickname").style.backgroundColor="#FFCECE";
            validNickname = false;
        } else { // 사용 가능한 닉네임
            document.getElementById("notInputNickname").style.display = "none";
            document.getElementById("invalidNickname").style.display = "none";
            document.getElementById("nickname").style.backgroundColor="#B0F6AC";
            validNickname = true;
        }
    }

    function emailCheck() { // 이메일 체크
        let email = document.getElementById('email').value; // email 값을 담아줌
        let emailCheck = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/; // 이메일의 정규표현식
        if (email.trim() === '') { // 입력값이 없는 경우
            document.getElementById("notInputEmail").style.display = "block"; // 이메일을 입력하라는 메시지를 block으로 표시해 화면에 띄워지게 한다.
            document.getElementById("invalidEmail").style.display = "none";
            document.getElementById("email").style.backgroundColor="#FFCECE";
            validEmail = false;
        } else if (emailCheck.test(email) === false) { // 양식에 맞지 않을 시
            document.getElementById("notInputEmail").style.display = "none";
            document.getElementById("invalidEmail").style.display = "block"; // 양식에 맞지 않는다는 메시지를 block으로 표시해 화면에 띄워지게 한다.
            document.getElementById("email").style.backgroundColor="#FFCECE";
            validEmail = false;
        } else { // 사용 가능한 이메일
            document.getElementById("notInputEmail").style.display = "none";
            document.getElementById("invalidEmail").style.display = "none";
            document.getElementById("email").style.backgroundColor="#B0F6AC";
            validEmail = true;
        }
    }

    function updateInfo() {
        if(validPassword === true && validSamePassword === true && validNickname === true && validEmail === true) {
            const password = document.getElementById('password').value;
            const nickname = document.getElementById('nickname').value;
            const email = document.getElementById('email').value;
            const serialNum = document.getElementById('serialNum').value;
            const id = document.getElementById('id').value;

            // 유효성 검사 완료 후 실행할 로직
            // json 데이터로 변환
            let data = {
                password:password,
                nickname:nickname,
                email:email,
                serialNum:serialNum,
                id:id
            };

            let xhr = new XMLHttpRequest();
            xhr.open("POST", "/user/updateProc");
            xhr.setRequestHeader("Content-Type", "application/json; charset=utf-8");
            xhr.onload = function() {
                if (xhr.status === 200 || xhr.status === 201) {
                    let resp = xhr.responseText;
                    if (resp.status === 500) {
                        alert("에러가 발생했습니다.");
                    } else {
                        alert("정보수정이 완료되었습니다.");
                        location.href = "/";
                    }
                } else {
                    console.log(xhr.responseText);
                    alert("에러가 발생했습니다. \n에러 코드: " + xhr.status);
                }
            };
            xhr.onerror = function() {
                alert("에러가 발생했습니다. \n에러 코드: " + xhr.status);
            };
            xhr.send(JSON.stringify(data));
        } else {
            alert('입력하신 정보를 다시 한 번 확인해주세요.');
        }
    }
</script>
</body>
<%@ include file="../layout/footer.jsp"%>
</html>