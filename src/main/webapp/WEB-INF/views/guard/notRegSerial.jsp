<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2023-04-06
  Time: 오전 1:52
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
<h3 style="text-align: center">시리얼 번호를 등록하지 않았습니다. 시리얼 번호를 등록해주세요.</h3>
</body>
<%@ include file="../layout/footer.jsp"%>
</html>
