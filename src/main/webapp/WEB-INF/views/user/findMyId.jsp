<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2023-05-10
  Time: 오후 10:27
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <title>아이디 찾기</title>
    <link rel="stylesheet" href="/css/bootstrap.min.css">
</head>
<body class="center-div">
<section class="bg-white">
    <h2 style="text-align: center; margin-top: 30px; margin-bottom: 10px; font-family: KakaoBold;">아이디 찾기</h2>
    <br>
    <section style="padding-bottom: 50px;">
        <div class="container center-div">
            <form method="post" class="container center-div container-size">
                <div class="form-group" style="margin-bottom: 32px;">
                    <h5 style="text-align: left">이름</h5><input type="text" class="form-control" placeholder="이름을 입력하세요."
                                                               name="name" id="name">
                </div>
                <div class="form-group">
                    <h5 style="text-align: left">이메일</h5><input type="text" class="form-control"
                                                                placeholder="이메일을 입력하세요." name="email" id="email">
                </div>
            </form>
            <input class="btn btn-staffriends btn-lg center-div" type="button" value="아이디 찾기" onclick="findMyIdProc()">
        </div>
    </section>
</section>
</body>

<script>
    function findMyIdProc() {
        let name = document.getElementById('name').value.trim();
        let email = document.getElementById('email').value.trim();

        if (name === "") {
            alert("아이디를 입력해주세요.");
            document.getElementById('name').focus();
            return false;
        }
        if (email === "") {
            alert("이메일을 입력해주세요.");
            document.getElementById('email').focus();
            return false;
        }

        let data = {
            name:name,
            email:email
        };

        console.log(data);

        let xhr = new XMLHttpRequest();
        xhr.open("POST", "/user/findMyIdProc");
        xhr.setRequestHeader("Content-Type", "application/json; charset=utf-8");
        xhr.onload = function() {
            if (xhr.status === 200 || xhr.status === 201) {
                let resp = xhr.responseText;
                let result = JSON.parse(resp);
                if (resp.status === 500) {
                    alert("에러가 발생했습니다.");
                } else {
                    if(result.username === '0') {
                        alert('입력하신 정보와 일치하는 아이디를 찾을 수 없습니다.')
                    } else {
                        alert('회원님의 아이디는 ' + result.username + '입니다.');
                    }
                }
            } else {
                console.log(xhr.responseText);
                alert("에러가 발생했습니다. \n에러 코드: " + xhr.status);
            }
        };
        xhr.onerror = function() {
            console.log(xhr.responseText);
            alert("에러가 발생했습니다. \n에러 코드: " + xhr.status);
        };
        xhr.send(JSON.stringify(data));
    }
</script>
</html>
