<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2023-03-16
  Time: 오후 4:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="/css/bootstrap.min.css">
  <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.3/dist/jquery.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
  <link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.css" rel="stylesheet">
  <script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.js"></script>
</head>
<body class="center-div">
<section class="border-bottom bg-white">
<nav class="navbar navbar-expand-md navbar-white container">
  <a href="/"><img src="/img/mainlogo3.png" height="40" width="195"></a>
  <button class="navbar-toggler navbar-light" type="button" data-toggle="collapse" data-target="#collapsibleNavbar" style="text-align: center">
    <span class="navbar-toggler-icon"></span>
  </button>
  <div class="collapse navbar-collapse justify-content-end" id="collapsibleNavbar" style="text-align: center">
    <c:choose>
      <c:when test="${signIn != null}">
        <%-- 로그인 시 --%>
              <ul class="navbar-nav">
                <li class="nav-item">
                  <a class="nav-link" href="/guard/guardIndex?serial_num=${signIn.serialNum}"><h4>보호자페이지</h4></a>
                </li>
                <li class="nav-item">
                  <a class="nav-link" href="/board"><h4>커뮤니티</h4></a>
                </li>
                <li class="nav-item">
                  <a class="nav-link" href="/board/boardWrite"><h4>글쓰기</h4></a>
                </li>
                <li class="nav-item">
                  <a class="nav-link" href="/user/updateForm"><h4>${signIn.nickname}님</h4></a>
                </li>
                <li class="nav-item">
                  <a class="nav-link" href="/user/logout"><h4>로그아웃</h4></a>
                </li>
              </ul>
      </c:when>
      <c:otherwise>
        <%-- 비로그인 시 --%>
        <ul class="navbar-nav">
          <li class="nav-item">
            <a class="nav-link" href="/user/joinForm"><h4>회원가입</h4></a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="/user/loginForm"><h4>로그인</h4></a>
          </li>
        </ul>
      </c:otherwise>
    </c:choose>
  </div>
</nav>
</section>
<br>