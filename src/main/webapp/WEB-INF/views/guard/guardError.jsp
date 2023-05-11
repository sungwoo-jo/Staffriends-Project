<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../layout/header.jsp"%>
<c:if test="${signIn == null}"><c:redirect url="http://localhost/user/needLogin"/></c:if>
<html>
<head>
    <title>Error</title>
</head>
<body>
<h1 style="text-align: center">Error</h1>
<h3 style="text-align: center">잘못된 시리얼 번호를 입력하였거나, 기기 등록 정보가 없습니다.</h3>
</body>
<%@ include file="../layout/footer.jsp"%>
</html>
