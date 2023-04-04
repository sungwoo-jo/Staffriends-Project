<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../layout/header.jsp"%>
<html>
<body>
<section class="bg-light">
<div class="container py-4">
<form id="joinFrm" method="post">
    <div class="form-group">
        아이디<input type="text" class="form-control col-md-8" placeholder="영문 대/소문자, 숫자, 언더바/하이픈 포함 7~20자" name="username" id="username"> <button type="button" class="col-md-3" onclick="idCheck()">중복확인</button><div id="chkDiv"></div>
    </div>
    <div class="form-group">
        비밀번호<input type="password" class="form-control" placeholder="문자/숫자 포함 8자리 이상" name="password" id="password">
    </div>
    <div class="form-group">
        비밀번호확인<input type="password" class="form-control" placeholder="비밀번호를 한번 더 입력하세요." name="password" id="validPassword">
    </div>
    <div class="form-group">
        닉네임<input type="text" class="form-control" placeholder="한글, 영문 대/소문자, 숫자 포함 2~15자" name="nickName" id="nickname">
    </div>
    <div class="form-group">
        이메일<input type="text" class="form-control" placeholder="이메일을 입력하세요." name="email" id="email">
    </div>
</form>
    <input class="btn btn-staffriends btn-lg" type="button" value="회원가입" style="width: inherit" onclick="join()">
</div>

</section>
</body>
<script>
    let validUsername = false;
    function join() {
        const username = document.getElementById('username').value;
        const password = document.getElementById('password').value;
        const validPassword = document.getElementById('validPassword').value;
        const nickname = document.getElementById('nickname').value;
        const email = document.getElementById('email').value;
        let usernameCheck = /^[a-zA-Z0-9_-]{7,20}$/;
        let passwordCheck = /(?=.*\d)(?=.*[a-zA-ZS]).{8,}/;
        let nicknameCheck = /^[가-힇a-zA-Z0-9]{2,15}$/;
        let emailCheck = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/;

        if (username.trim() === '') { // 입력값이 없는 경우
            alert('아이디를 입력해주세요.');
            document.getElementById('username').focus();
            return false;
        };
        if (!validUsername) { // 중복확인을 안한 경우
            alert('아이디 중복확인이 완료되지 않았습니다.');
            return false;
        };
        if (!usernameCheck.test(username)) { // 양식에 맞지 않는 경우
            alert('아이디는 영문 대/소문자, 숫자, 언더바/하이픈을 포함하여 7~20자로 입력해야합니다.');
            document.getElementById('username').focus();
            validUsername = false;
            return false;
        };

        if (password.trim() === '') { // 입력값이 없는 경우
            alert('비밀번호를 입력해주세요.');
            document.getElementById('password').focus();
            return false;
        };
        if (!passwordCheck.test(password)) { // 양식에 맞지 않는 경우
            alert('비밀번호는 문자와 숫자 1개 이상을 포함하여 8자리 이상 입력해야합니다.');
            document.getElementById('password').focus();
            return false;
        };

        if (validPassword.trim() === '') {
            alert('비밀번호를 한번 더 입력해주세요.');
            document.getElementById('validPassword').focus();
            return false;
        }
        if (password != validPassword) {
            alert('입력한 비밀번호가 다릅니다. \n다시 확인해주세요.');
            document.getElementById('validPassword').focus();
            return false;
        }

        if (nickname.trim() === '') { // 입력값이 없는 경우
            alert('닉네임을 입력해주세요.');
            document.getElementById('nickname').focus();
            return false;
        };
        if (!nicknameCheck.test(nickname)) { // 양식에 맞지 않는 경우
            alert('닉네임은 한글, 영문 대/소문자, 숫자를 포함하여 2~15자로 입력해야합니다.');
            document.getElementById('nickname').focus();
            return false;
        };

        if (email.trim() === '') { // 입력값이 없는 경우
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
            username:username,
            password:password,
            nickname:nickname,
            email:email
        };

        let xhr = new XMLHttpRequest();
        xhr.open("POST", "/user/join/insert");
        xhr.setRequestHeader("Content-Type", "application/json; charset=utf-8");
        xhr.onload = function() {
            if (xhr.status === 200 || xhr.status === 201) {
                let resp = xhr.responseText;
                if (resp.status === 500) {
                    alert("에러가 발생했습니다.");
                } else {
                    alert("회원가입이 완료되었습니다.");
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

    function idCheck() { // 아이디 중복확인
        let username = document.getElementById('username').value;
        let usernameCheck = /^[a-zA-Z0-9_-]{7,20}$/;
        if (username.trim() === '') { // 입력값이 없는 경우
            alert('아이디를 입력해주세요.');
            document.getElementById('username').focus();
            return false;
        };
        if (!usernameCheck.test(username)) { // 양식에 맞지 않는 경우
            alert('아이디는 영문 대/소문자, 숫자, 언더바/하이픈을 포함하여 7~20자로 입력해야합니다.');
            document.getElementById('username').focus();
            validUsername = false;
            return false;
        }

        // json 데이터로 변환
        let data = {username:username};

        let xhr = new XMLHttpRequest();
        xhr.open("POST", "/user/join/idCheck");
        xhr.setRequestHeader("Content-Type", "application/json; charset=utf-8");
        xhr.onload = function() {
            if (xhr.status === 200 || xhr.status === 201) {
                let resp = xhr.responseText;
                if (resp.status === 500) {
                    alert("에러가 발생했습니다.");
                } else {
                    let result = JSON.parse(resp);
                    let divElement = document.getElementById('chkDiv');
                    let aElement = document.createElement('a');
                    if(result.count > 0) {
                        aElement.innerHTML = '이미 존재하는 아이디입니다.';
                    } else {
                        console.log(result.count);
                        aElement.innerHTML = '사용이 가능한 아이디입니다.';
                    }
                    divElement.innerHTML = '';
                    divElement.appendChild(aElement);
                    validUsername = true;
                    // alert("회원가입완료");
                    // location.href = "/";
                }
            } else {
                console.log(xhr.responseText);
                alert("에러가 발생했습니다. \n에러 코드: " + xhr.status);
            }
        };
        xhr.onerror = function() {
            alert("에러가 발생했습니다. \n에러 코드: " + xhr.status);
        };
        xhr.send(JSON.stringify(data.username));
    }
</script>
</html>
