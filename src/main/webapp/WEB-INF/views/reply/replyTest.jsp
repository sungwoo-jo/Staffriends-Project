<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../layout/header.jsp"%>

<div class="card" style="margin: 0 auto; width: 80%; height: auto; margin-bottom:10px; left: 0px;" id="card">
    <div class="card-header">
        <h7>작성자: 메로나먹고싶다</h7>
        <span class="card-text text-right" style="font-size: small; float: right">2023-05-18 01:25:51</span></div>
    <div class="border-bottom">
        <div class="card-body"><h6 class="card-title"><textarea id="replyEditContents">이동 경로도 표시해준다던데, 정말 가능할까요??</textarea></h6></div>
        <div style="text-align: right"><span style="float: right"><a style="color: #007bff; margin-right: 10px;"
                                                                     href="javascript:deleteReply(2);">삭제하기</a></span><span
                style="float: right;"><a href="javascript:showModifyReplyForm(2, 이동 경로도 표시해준다던데, 정말 가능할까요??);" style="color: #007bff; margin-right: 10px;" id="modifyReply2">수정하기</a></span><span style="float: right;"><a href="javascript:showReplyForm(2);" style="color: #007bff; margin-right: 10px;" id="addReply2">댓글달기</a></span>
        </div>
    </div>
    <replyadd2 style="display: none">
        <div class="card-header" style="border: none; padding-bottom: 0; "> <!-- 대댓글 헤더 --><strong
                style="padding-right: 5px; margin-bottom: 0">└</strong>&nbsp;
        </div>
        <div class="border-bottom" style="background: rgba(0, 0, 0, .03); border-style: hidden; padding-right: 10px">
            <div class="card-body" style="padding-left: 40px;"><textarea style="width: 80%; resize: none" id="reReply2"
                                                                         placeholder="댓글 내용을 입력해주세요."></textarea></div>
            <div style="text-align: right; padding-left: 40px;"><span style="float: right; margin-right: 10px;"><a
                    href="javascript:insertReReply(2)" style="color: #007bff">작성완료</a></span></div>
        </div>
    </replyadd2>
</div>