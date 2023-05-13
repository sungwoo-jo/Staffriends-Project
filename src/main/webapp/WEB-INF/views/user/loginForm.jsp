<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../layout/header.jsp"%>
<html>
<body>
<c:set var="REST_API_KEY" value="69eddbebb2b07d6a316fc057c32fdbdf"/>
<%--<c:set var="REDIRECT_URI" value="http://localhost/user/kakao"/>--%>
<c:set var="REDIRECT_URI" value="http://staffriends.duckdns.org/user/kakao"/>
<h2 style="text-align: center; margin-top: 30px; margin-bottom: 70px; font-family: KakaoBold;">로그인</h2>
<section style="padding-bottom: 50px;">
<div class="container center-div">
<form method="post" class="container center-div container-size">
    <div class="form-group" style="margin-bottom: 32px;">
        <h5 style="text-align: left">아이디</h5><input type="text" class="form-control" placeholder="아이디를 입력하세요." name="username" id="username">
    </div>
    <div class="form-group">
        <h5 style="text-align: left">비밀번호</h5><input type="password" class="form-control" placeholder="비밀번호를 입력하세요." name="password" id="password">
    </div>
    <div style="text-align: center; padding-bottom: 20px;"><a href="javascript:findMyIdPopUp()">아이디 찾기</a> | <a href="javascript:findMyPasswordPopUp()">비밀번호 찾기</a></div>
    <input class="btn btn-staffriends btn-lg center-div" type="button" value="로그인" onclick="loginProc()">
    <a href="https://kauth.kakao.com/oauth/authorize?client_id=${REST_API_KEY}&redirect_uri=${REDIRECT_URI}&response_type=code"><img src="/img/kakao_login_medium_wide.png" class="btn-block" style="margin-top: 5px;height: 50px"></a>
</form>
</div>
</section>
</body>
</html>
<script>
    function loginProc() { // 로그인 실행 로직
        let username = document.getElementById('username').value.trim();
        let password = document.getElementById('password').value.trim();

        if (username === "") {
            alert("아이디를 입력해주세요.");
            document.getElementById('username').focus();
            return false;
        }
        if (password === "") {
            alert("비밀번호를 입력해주세요.");
            document.getElementById('password').focus();
            return false;
        }

        let data = {
            username:username,
            password:password
        };

        let xhr = new XMLHttpRequest();
        xhr.open("POST", "/user/loginProc");
        xhr.setRequestHeader("Content-Type", "application/json; charset=utf-8");
        xhr.onload = function() {
            if (xhr.status === 200 || xhr.status === 201) {
                let resp = xhr.responseText;
                let result = JSON.parse(resp);
                if (resp.status === 500) {
                    alert("에러가 발생했습니다.");
                } else {
                    if (result) { // 회원 정보를 반환받은 경우
                        alert("로그인이 완료되었습니다.");
                        location.href = "/";
                    } else { // 반환받은 회원 정보가 없는 경우
                        alert("아이디 또는 비밀번호를 확인해주세요.");
                        document.getElementById('username').focus();
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

    function findMyIdPopUp() { // 아이디 찾기 팝업창 열기
        // 창 크기 지정(700 x 500)
        let width = 700;
        let height = 500;

        // pc 화면 기준 가운데 정렬
        let left = (window.screen.width / 2) - (width/2);
        let top = (window.screen.height / 4);

        // 팝업창 속성 지정
        let windowStatus = 'width='+width+', height='+height+', left='+left+', top='+top+'';

        // /user/findMyId로 연결
        const url = "/user/findMyId";

        //등록된 url 및 window 속성 기준으로 팝업창 열기
        window.open(url, "findMyIdPopUp", windowStatus);
    }

    function findMyPasswordPopUp() { // 비밀번호 찾기 팝업창 열기
        // 창 크기 지정(700 x 500)
        let width = 700;
        let height = 500;

        // pc 화면 기준 가운데 정렬
        let left = (window.screen.width / 2) - (width/2);
        let top = (window.screen.height / 4);

        // 팝업창 속성 지정
        let windowStatus = 'width='+width+', height='+height+', left='+left+', top='+top+'';

        // /user/findMyId로 연결
        const url = "/user/findMyPassword";

        //등록된 url 및 window 속성 기준으로 팝업창 열기
        window.open(url, "findMyPasswordPopUp", windowStatus);
    }
</script>
<%@ include file="../layout/footer.jsp"%>