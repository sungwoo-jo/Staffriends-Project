
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<body>
<form id="joinFrm" method="post">
    <div class="form-group">
        아이디:<input type="text" class="form-control" placeholder="아이디를 입력하세요." name="username" id="username"> <button type="button" onclick="idCheck()">중복확인</button><div id="chkDiv"></div>
    </div>
    <div class="form-group">
        비밀번호:<input type="password" class="form-control" placeholder="비밀번호를 입력하세요." name="password" id="password">
    </div>
    <div class="form-group">
        닉네임:<input type="text" class="form-control" placeholder="닉네임을 입력하세요." name="nickName" id="nickname">
    </div>
    <div class="form-group">
        이메일:<input type="text" class="form-control" placeholder="이메일을 입력하세요." name="email" id="email">
    </div>
</form>
<input type="button" value="전송" onclick="join()">

<script>
    let validUsername = false;
    function join() {
        const username = document.getElementById('username').value;
        const password = document.getElementById('password').value;
        const nickname = document.getElementById('nickname').value;
        const email = document.getElementById('email').value;
        let usernameCheck = /^[a-zA-Z0-9_-]{7,20}$/;
        let passwordCheck = /(?=.*\d)(?=.*[a-zA-ZS]).{8,}/;
        let nicknameCheck = /^[가-힇a-zA-Z0-9]{2,15}$/;
        let emailCheck = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/;

        if (username.trim() === '') { // 입력값이 없는 경우
            alert('아이디를 입력해주세요.');
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
            return false;
        };
        if (!passwordCheck.test(password)) { // 양식에 맞지 않는 경우
            alert('비밀번호는 문자와 숫자 1개 이상을 포함하여 8자리 이상 입력해야합니다.');
            document.getElementById('password').focus();
            return false;
        };

        if (nickname.trim() === '') { // 입력값이 없는 경우
            alert('닉네임을 입력해주세요.');
            return false;
        };
        if (!nicknameCheck.test(nickname)) { // 양식에 맞지 않는 경우
            alert('닉네임은 한글, 영문 대/소문자, 숫자를 포함하여 2~15자로 입력해야합니다.');
            document.getElementById('nickname').focus();
            return false;
        };

        if (email.trim() === '') { // 입력값이 없는 경우
            alert('이메일을 입력해주세요.');
            return false;
        };
        if (!emailCheck.test(email)) { // 양식에 맞지 않는 경우
            alert('이메일 형식이 올바르지 않습니다.');
            document.getElementById('email').focus();
            return false;
        };

        document.getElementById("joinFrm").sub
    }

    function idCheck() {
        let username = document.querySelector("#username").value;
        if(username == null || username == undefined || username == ""){ alert('아이디를 입력해주세요.'); document.getElementById('username').focus(); return;}

        // 유효성 검사 완료 후 실행할 로직
        // json 데이터로 변환
        let data = {username:username};

        let xhr = new XMLHttpRequest();
        xhr.open("POST", "/user/join/idCheck");
        xhr.setRequestHeader("Content-Type", "application/json; charset=utf-8");
        xhr.onload = function() {
            if (xhr.status === 200 || xhr.status === 201) {
                let resp = xhr.responseText;
                if (resp.status === 500) {
                    alert("회원가입실패");
                } else {
                    let result = JSON.parse(resp);
                    let divElement = document.getElementById('chkDiv');
                    let aElement = document.createElement('a');
                    if(result.count > 0) {
                        console.log("아이디 존재");
                        aElement.innerHTML = '사용 불가.';
                    } else {
                        console.log(result.count);
                        aElement.innerHTML = '사용 가능.';
                    }
                    divElement.innerHTML = '';
                    divElement.appendChild(aElement);
                    validUsername = true;
                    // alert("회원가입완료");
                    // location.href = "/";
                }
            } else {
                console.log(xhr.responseText);
                alert("Request failed. Status: " + xhr.status);
            }
        };
        xhr.onerror = function() {
            alert("Request failed. Status: " + xhr.status);
        };
        xhr.send(JSON.stringify(data.username));
    }
</script>

</body>
</html>
