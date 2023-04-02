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
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
  <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.3/dist/jquery.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
  <link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.css" rel="stylesheet">
  <script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.js"></script>
</head>
<body>
<nav class="navbar navbar-expand-md bg-dark navbar-dark">
  <a class="navbar-brand" href="/">Staffriends</a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#collapsibleNavbar">
    <span class="navbar-toggler-icon"></span>
  </button>
  <div class="collapse navbar-collapse justify-content-end" id="collapsibleNavbar">
    <c:choose>
      <c:when test="${signIn != null}">
        <%-- 로그인 시 --%>
              <ul class="navbar-nav">
                <li class="nav-item">
                  <a class="nav-link" href="/guard/guardIndex?serial_num=${signIn.serialNum}">보호자페이지</a>
                </li>
                <li class="nav-item">
                  <a class="nav-link" href="/board">커뮤니티</a>
                </li>
                <li class="nav-item">
                  <a class="nav-link" href="/board/boardWrite">글쓰기</a>
                </li>
                <li class="nav-item">
                  <a class="nav-link" href="/user/updateForm">${signIn.nickname}님</a>
                </li>
                <li class="nav-item">
                  <a class="nav-link" href="/user/logout">로그아웃</a>
                </li>
              </ul>
      </c:when>
      <c:otherwise>
        <%-- 비로그인 시 --%>
        <ul class="navbar-nav">
          <li class="nav-item">
            <a class="nav-link" href="/user/joinForm">회원가입</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="/user/loginForm">로그인</a>
          </li>
        </ul>
      </c:otherwise>
    </c:choose>
  </div>
</nav>
<br>