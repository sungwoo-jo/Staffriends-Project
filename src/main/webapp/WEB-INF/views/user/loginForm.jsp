<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<form method="post">
    <div class="form-group">
        아이디:<input type="text" class="form-control" placeholder="아이디를 입력하세요." name="username" id="username">
    </div>
    <div class="form-group">
        비밀번호:<input type="password" class="form-control" placeholder="비밀번호를 입력하세요." name="password" id="password">
    </div>
    <input type="button" value="전송" onclick="loginCheck()" >
</form>

<script>
    function loginCheck() {
        let username = document.getElementById('username').value.trim();
        let password = document.getElementById('password').value.trim();

        if (username == "") {
            alert("아이디를 입력해주세요.");
            document.getElementById('username').focus();
            return false;
        }
        if (password == "") {
            alert("비밀번호를 입력해주세요.");
            document.getElementById('password').focus();
            return false;
        }

        let data = {
            username:username,
            password:password
        };

        let xhr = new XMLHttpRequest();
        xhr.open("POST", "/user/checkUser");
        xhr.setRequestHeader("Content-Type", "application/json; charset=utf-8");
        xhr.onload = function() {
            if (xhr.status === 200 || xhr.status === 201) {
                let resp = xhr.responseText;
                if (resp.status === 500) {
                    alert("에러가 발생했습니다.");
                } else {
                    let result = JSON.parse(resp);
                    if (result.count) {
                        alert("로그인이 완료되었습니다.");
                        location.href = "/";
                    } else {
                        alert("아이디 또는 비밀번호를 확인해주세요.");
                        document.getElementById('username').focus();
                    }
                }
            } else {
                console.log(xhr.responseText);
                alert("Request failed. Status: " + xhr.status);
            }
        };
        xhr.onerror = function() {
            alert("Request failed. Status: " + xhr.status);
        };
        xhr.send(JSON.stringify(data));
    }



</script>