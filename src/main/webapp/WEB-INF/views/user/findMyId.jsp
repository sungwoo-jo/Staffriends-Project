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
    <script src="/js/user.js"></script>
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
</html>


