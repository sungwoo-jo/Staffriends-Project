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
<c:if test="${signIn == null}"><c:redirect url="http://http://staffriends.duckdns.org/user/needLogin"/></c:if>
<head>
    <title>board</title>
</head>
<body>
    <div class="container">
        <h2 style="text-align: center; margin-top: 30px; margin-bottom: 20px; font-family: KakaoBold;">게시글 목록</h2>
            <h5 style="text-align: right"><a href="/board/boardWrite" class="btn btn-success justify-content-end">글 쓰기</a></h5>
        <table class="table table-striped border-bottom" >
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
                <c:if test="${fn:length(list) > 0}">
                    <c:forEach var="li" items="${list}">
                    <tr>
                        <td style="text-align: center"><c:out value="${li.boardIdx}"/></td>
                        <td style="text-align: center"><a href="/board/boardDetail?boardIdx=${li.boardIdx}"> <%-- 제목을 클릭하면 해당 게시글로 이동 --%>
                            <c:out value="${li.title}"></c:out></a>
                            <c:if test="${li.replyCount ne 0}">&nbsp;<small>(<c:out value="${li.replyCount}"/>)</small></c:if> <%-- 게시글에 달린 댓글의 갯수를 표시 --%>
                        </td>
                        <td style="text-align: center"><c:out value="${li.hitCnt}"/></td>
                        <td style="text-align: center"><c:out value="${li.createdDateTime}"/></td>
                    </tr>
                    </c:forEach>
                </c:if>
            </tbody>
        </table>
        <nav aria-label="Page navigation example">
            <ul class="pagination justify-content-center">
                <c:choose>
                    <c:when test="${startPage == 1}"> <%-- 첫 페이지일 때 Previous 버튼 비활성화 --%>
                        <li class="page-item disabled"><a class="page-link" href="#" aria-disabled="true">Previous</a></li>
                    </c:when>
                    <c:otherwise>
                        <li class="page-item"><a class="page-link" href="board?page=${startPage-1}" aria-disabled="true">Previous</a></li>
                    </c:otherwise>
                </c:choose>
                <c:choose>
                    <c:when test="${startPage <= endPage}"> <%-- 끝 페이지 이하일 경우 --%>
                        <c:forEach var="start" begin="${startPage}" end="${endPage}" step="1"> <%-- 페이지 번호 출력 --%>
                            <c:choose>
                                <c:when test="${start != cPage}"> <%-- 버튼 별 이동할 페이지 링크 설정 --%>
                                    <li class="page-item">
                                        <a class="page-link" href="board?page=${start}">${start}</a></li>
                                </c:when>
                                <c:otherwise> <%-- 클릭한 페이지 번호 비활성화 --%>
                                    <li class="page-item">
                                    <li class="page-item disabled"><a class="page-link" href="#" aria-disabled="true" style="background: #e9ecef; color: #8B4513">${start}</a></li>
                                </c:otherwise>
                            </c:choose>
                        </c:forEach>
                    </c:when>
                </c:choose>
                <c:choose>
                    <%-- 마지막 페이지 숫자와 startPage에서 pageLength 더해준 값이 일치할 때 --%>
                    <%-- 즉 마지막 페이지 블럭일 때 Next 버튼 비활성화 --%>
                    <c:when test="${totalPages == endPage}">
                        <li class="page-item disabled"><a class="page-link" href="#">Next</a></li>
                    </c:when>
                    <c:otherwise>
                        <li class="page-item">
                            <a class="page-link" href="board?page=${endPage+1}">Next</a>
                        </li>
                    </c:otherwise>
                </c:choose>
            </ul>
        </nav>
    </div>
</body>
<%@ include file="../layout/footer.jsp"%>
