
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<body>
<form id="joinFrm" method="post">
    <div class="form-group">
        아이디:<input type="text" class="form-control" placeholder="아이디를 입력하세요." name="username" id="username"><div id="chkDiv"></div><button type="button" onclick="idCheck()">중복확인</button>
    </div>
    <div class="form-group">
        비밀번호:<input type="password" class="form-control" placeholder="비밀번호를 입력하세요." name="password" id="password">
    </div>
    <div class="form-group">
        닉네임:<input type="text" class="form-control" placeholder="닉네임을 입력하세요." name="nickName" id="nickName">
    </div>
    <div class="form-group">
        이메일:<input type="text" class="form-control" placeholder="이메일을 입력하세요." name="email" id="email">
    </div>
    <input type="button" value="전송" id="join">
</form>

<script>
    function idCheck() {

        let username = document.querySelector("#username").value;
        // let password = document.querySelector("#password").value;
        // let nickName = document.querySelector("#nickName").value;
        // let email = document.querySelector("#email").value;

        if(username == null || username == undefined || username == ""){ alert('아이디를 입력해주세요.'); document.getElementById('username').focus(); return;}
        // if(password == null || password == undefined || password == ""){ alert('비밀번호를 입력해주세요.'); document.getElementById('password').focus(); return;}
        // if(nickName == null || nickName == undefined || nickName == ""){ alert('닉네임을 입력해주세요.'); document.getElementById('nickName').focus(); return;}
        // if(email == null || email == undefined || email == ""){ alert('이메일을 입력해주세요.'); document.getElementById('email').focus(); return;}

        // 유효성 검사 완료 후 실행할 로직
        // json 데이터로 변환
        let data = {
            username: username,
            password: password,
            nickName: nickName,
            email: email
        };

        let xhr = new XMLHttpRequest();
        xhr.open("POST", "/user/join/idCheck");
        // xhr.setRequestHeader("Content-Type", "application/json; charset=utf-8");
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
