<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<form method="post" action="/user/join/insert">
    <div class="form-group">
        아이디:<input type="text" class="form-control" placeholder="아이디를 입력하세요." name="username">
    </div>
    <div class="form-group">
        비밀번호:<input type="password" class="form-control" placeholder="비밀번호를 입력하세요." name="password">
    </div>
    <div class="form-group">
        닉네임:<input type="text" class="form-control" placeholder="닉네임을 입력하세요." name="nickName">
    </div>
    <div class="form-group">
        이메일:<input type="text" class="form-control" placeholder="이메일을 입력하세요." name="email">
    </div>
    <input type="submit" value="전송">
</form>