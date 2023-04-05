<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2023-04-02
  Time: 오후 10:46
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../layout/header.jsp"%>
<c:if test="${signIn == null}"><c:redirect url="http://localhost:8080/user/needLogin"/></c:if>
<html>
<head>
    <title>Title</title>
</head>
<body>
<h1 style="text-align: center">Error</h1>
<h3 style="text-align: center">시리얼 번호를 등록하지 않으셨거나, 잘못된 시리얼 번호를 입력하셨습니다.</h3>
<h3 style="text-align: center">(또는 한 번도 사용되지 않은 시리얼번호일 수 있습니다.)</h3>
</body>
</html>
