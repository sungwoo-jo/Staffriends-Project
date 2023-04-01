<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2023-04-02
  Time: 오전 2:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../layout/header.jsp"%>
<html>
<head>
    <title>정보수정페이지</title>
</head>
<body>
<form method="post">
    <input type="hidden" id="id" value="${signIn.id}">
    아이디:<input type="text" name="username" disabled value="${signIn.username}"><p/>
    비밀번호:<input type="password" name="password" id="password" placeholder="문자/숫자 포함 8자리 이상"><p/>
    비밀번호 확인:<input type="password" name="validPassword" id="validPassword" placeholder="비밀번호를 한번 더 입력하세요."><p/>
    닉네임:<input type="text" name="nickname" value="${signIn.nickname}" id="nickname" placeholder="한글, 영문 대/소문자, 숫자 포함 2~15자"><p/>
    이메일<input type="text" name="email" value="${signIn.email}" id="email" placeholder="이메일을 입력하세요."><p/>
    <input type="button" value="수정완료" onclick="checkInfo()">
</form>


<script>
    function checkInfo() {
        const password = document.getElementById('password').value.trim();
        const validPassword = document.getElementById('validPassword').value.trim();
        const nickname = document.getElementById('nickname').value.trim();
        const email = document.getElementById('email').value.trim();
        const id = document.getElementById('id').value.trim();
        let passwordCheck = /(?=.*\d)(?=.*[a-zA-ZS]).{8,}/;
        let nicknameCheck = /^[가-힇a-zA-Z0-9]{2,15}$/;
        let emailCheck = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/;

        console.log(id);

        if (password == '') { // 입력값이 없는 경우
            alert('비밀번호를 입력해주세요.');
            document.getElementById('password').focus();
            return false;
        };
        if (!passwordCheck.test(password)) { // 양식에 맞지 않는 경우
            alert('비밀번호는 문자와 숫자 1개 이상을 포함하여 8자리 이상 입력해야합니다.');
            document.getElementById('password').focus();
            return false;
        };

        if (validPassword == '') {
            alert(document.getElementById('password').value);
            alert('비밀번호를 한번 더 입력해주세요.');
            document.getElementById('validPassword').focus();
            return false;
        }
        if (password != validPassword) {
            alert('입력한 비밀번호가 다릅니다. \n다시 확인해주세요.');
            document.getElementById('validPassword').focus();
            return false;
        }

        if (nickname == '') { // 입력값이 없는 경우
            alert('닉네임을 입력해주세요.');
            document.getElementById('nickname').focus();
            return false;
        };
        if (!nicknameCheck.test(nickname)) { // 양식에 맞지 않는 경우
            alert('닉네임은 한글, 영문 대/소문자, 숫자를 포함하여 2~15자로 입력해야합니다.');
            document.getElementById('nickname').focus();
            return false;
        };

        if (email == '') { // 입력값이 없는 경우
            alert('이메일을 입력해주세요.');
            document.getElementById('email').focus();
            return false;
        };
        if (!emailCheck.test(email)) { // 양식에 맞지 않는 경우
            alert('이메일 형식이 올바르지 않습니다.');
            document.getElementById('email').focus();
            return false;
        };

        // 유효성 검사 완료 후 실행할 로직
        // json 데이터로 변환
        let data = {
            id:id,
            password:password,
            nickname:nickname,
            email:email
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
                    alert("회원정보 수정이 완료되었습니다.");
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
    }
</script>
</body>
</html>