<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2023-03-28
  Time: 오후 12:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file="../layout/header.jsp"%>
<c:if test="${signIn == null}"><c:redirect url="http://localhost:8080/user/needLogin"/></c:if>
<head>
    <title>board</title>
</head>
<body>
    <div class="container">
        <h2 style="text-align: center; margin-top: 30px; margin-bottom: 70px; font-family: KakaoBold;">게시글 목록</h2>
        <table class="table table-striped" >
            <colgroup>
                <col width="15%"/>
                <col width="*"/>
                <col width="15%"/>
                <col width="20%"/>
            </colgroup>
            <thead>
                <tr>
                    <th scope="col" style="text-align: center">글번호</th>
                    <th scope="col" style="text-align: center">제목</th>
                    <th scope="col" style="text-align: center">조회수</th>
                    <th scope="col" style="text-align: center">작성일</th>
                </tr>
            </thead>
            <tbody>
            <c:choose>
                <c:when test="${fn:length(list) > 0}">
                    <c:forEach var="li" items="${list}">
                    <tr>
                        <td style="text-align: center"><c:out value="${li.boardIdx}"/></td>
                        <td style="text-align: center"><a href="/board/boardDetail?boardIdx=${li.boardIdx}"><c:out value="${li.title}"></c:out></a></td>
                        <td style="text-align: center"><c:out value="${li.hitCnt}"/></td>
                        <td style="text-align: center"><c:out value="${li.createdDateTime}"/></td>
                    </tr>
                    </c:forEach>
                </c:when>
                <c:otherwise> <%-- 게시글 정보가 없으면 조회 결과 없음 출력 --%>
                    <h1>조회결과없음</h1>
                </c:otherwise>
            </c:choose>
            </tbody>
        </table>
        <a href="/board/boardWrite" class="btn">글 쓰기</a>
    </div>
</body>
<%@ include file="../layout/footer.jsp"%>
</html>
